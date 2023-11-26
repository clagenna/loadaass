package sm.clagenna.loadaass.javafx;

import java.io.File;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableView;
import javafx.stage.Stage;
import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.data.TableViewFiller;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.SqlServIntest;
import sm.clagenna.loadaass.dbsql.dtset.Dataset;
import sm.clagenna.loadaass.dbsql.dtset.Dts2Csv;
import sm.clagenna.loadaass.sys.AppProperties;
import sm.clagenna.loadaass.sys.IStartApp;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

public class ResultView implements Initializable, IStartApp {
  private static final Logger s_log = LogManager.getLogger(ResultView.class);

  public static final String  CSZ_FXMLNAME          = "ResultView.fxml";
  private static final String CSZ_PROP_POSRESVIEW_X = "resview.x";
  private static final String CSZ_PROP_POSRESVIEW_Y = "resview.y";
  private static final String CSZ_PROP_DIMRESVIEW_X = "resview.lx";
  private static final String CSZ_PROP_DIMRESVIEW_Y = "resview.ly";
  //  private static final String        CSZ_PROP_SPLITPOS     = "resview.splitpos";
  private static final String CSZ_QRY_TRUE   = "1=1";
  private static final String CSZ_PROP_QRIES = "Queries.properties";
  //  private static final DecimalFormat s_xfmt                = new DecimalFormat("#0.0000");
  private static final String QRY_ANNOCOMP = "" //
      + "SELECT DISTINCT annoComp FROM EEFattura" //
      + " UNION " //
      + "SELECT DISTINCT annoComp FROM GASFattura" //
      + " UNION " //
      + "SELECT DISTINCT annoComp FROM H2OFattura;";

  @FXML
  private ComboBox<RecIntesta> cbIntesta;
  @FXML
  private ComboBox<Integer>    cbAnnoComp;
  @FXML
  private ComboBox<String>     cbQuery;
  @FXML
  private Button               btCerca;
  @FXML
  private Button               btExportCsv;

  @FXML
  private TableView<List<Object>> tblview;

  @Getter @Setter
  private Scene               myScene;
  private Stage               lstage;
  private AppProperties       m_prQries;
  private LoadAassMainApp     m_appmain;
  private AppProperties       m_mainProps;
  private DBConn              m_db;
  private Map<String, String> m_mapQry;

  private RecIntesta m_fltrIntesta;
  private Integer    m_fltrAnnoComp;
  private String     m_qry;

  private TableViewFiller m_tbvf;

  public ResultView() {
    //
  }

  @Override
  public void initialize(URL p_location, ResourceBundle p_resources) {
    // initApp(null);
  }

  @Override
  public void initApp(AppProperties p_props) {
    m_appmain = LoadAassMainApp.getInst();
    m_appmain.addResView(this);
    m_mainProps = m_appmain.getProps();
    m_db = m_appmain.getConnSQL();
    try {
      m_prQries = new AppProperties();
      File fi = new File(CSZ_PROP_QRIES);
      m_prQries.leggiPropertyFile(fi, true, true);
    } catch (ReadFattPropsException e) {
      s_log.error("Errore caricamento file {} delle Queries", CSZ_PROP_QRIES);
    }

    caricaComboTitolare();
    caricaComboAnno();
    // caricaComboQueries();
    caricaComboQueriesFromDB();

    impostaForma(m_mainProps);
    if (lstage != null)
      lstage.setOnCloseRequest(e -> {
        closeApp(m_mainProps);
      });
  }

  private void caricaComboTitolare() {
    SqlServIntest intesta = m_appmain.getSqlIntesta();
    List<RecIntesta> liInte = intesta.getList();
    liInte.add(0, (RecIntesta) null);
    cbIntesta.getItems().addAll(liInte);
  }

  private void caricaComboAnno() {
    Connection conn = m_db.getConn();
    List<Integer> liAnno = new ArrayList<>();
    liAnno.add((Integer) null);
    try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(QRY_ANNOCOMP)) {
      while (rs.next()) {
        int anno = rs.getInt(1);
        liAnno.add(anno);
      }
      cbAnnoComp.getItems().addAll(liAnno);
    } catch (SQLException e) {
      s_log.error("Query {}; err={}", CSZ_FXMLNAME, e.getMessage(), e);
    }

  }

  @SuppressWarnings("unused")
  private void caricaComboQueries() {
    m_mapQry = new HashMap<>();
    List<String> liQry = new ArrayList<>();
    Set<Object> keys = m_prQries.getProperties().keySet();
    for (Object k : keys) {
      String szKey = k.toString();
      if ( !szKey.startsWith("QRY."))
        continue;
      String szDiz = szKey.substring(4).replace('.', ' ');
      m_mapQry.put(szDiz, szKey);
      liQry.add(szDiz);
    }
    cbQuery.getItems().addAll(liQry);
  }

  private void caricaComboQueriesFromDB() {
    Connection conn = m_db.getConn();
    m_mapQry = new HashMap<>();
    List<String> liQry = new ArrayList<>();
    liQry.add((String) null);
    String szQryAllViews = m_db.getQueryListViews();
    try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(szQryAllViews)) {
      while (rs.next()) {
        String szViewName = rs.getString(1);
        if ( ! (szViewName.startsWith("EE") || //
            szViewName.startsWith("GAS") || //
            szViewName.startsWith("H2O")))
          continue;
        liQry.add(szViewName);
        m_mapQry.put(szViewName, szViewName);
        String szQry = String.format("SELECT * FROM %s WHERE 1=1", szViewName);
        m_prQries.getProperties().put(szViewName, szQry);
      }
      cbQuery.getItems().addAll(liQry);
    } catch (SQLException e) {
      s_log.error("Query {}; err={}", CSZ_FXMLNAME, e.getMessage(), e);
    }
  }

  private void impostaForma(AppProperties p_props) {
    lstage = null;
    if (myScene == null)
      myScene = btCerca.getScene();
    if (lstage == null && myScene != null)
      lstage = (Stage) myScene.getWindow();
    if (lstage == null) {
      s_log.error("Non trovo lo stage per ResultView");
      return;
    }

    int px = p_props.getIntProperty(CSZ_PROP_POSRESVIEW_X);
    int py = p_props.getIntProperty(CSZ_PROP_POSRESVIEW_Y);
    int dx = p_props.getIntProperty(CSZ_PROP_DIMRESVIEW_X);
    int dy = p_props.getIntProperty(CSZ_PROP_DIMRESVIEW_Y);
    if (px * py != 0) {
      lstage.setX(px);
      lstage.setY(py);
      lstage.setWidth(dx);
      lstage.setHeight(dy);
    }
    //    double spltPos = Double.valueOf(p_props.getProperty(CSZ_PROP_SPLITPOS));
    //    spltPane.setDividerPositions(spltPos);
  }

  @Override
  public void closeApp(AppProperties p_props) {
    m_appmain.removeResView(this);
    if (myScene == null) {
      s_log.error("Il campo Scene risulta = **null**");
      return;
    }

    double px = myScene.getWindow().getX();
    double py = myScene.getWindow().getY();
    double dx = myScene.getWindow().getWidth();
    double dy = myScene.getWindow().getHeight();

    // double splPos = spltPane.getDividerPositions()[0];
    // String szDiv = String.format("%0.6f", splPos).replace(",", ".");
    // String szDiv = s_xfmt.format(splPos).replace(",", ".");

    p_props.setProperty(CSZ_PROP_POSRESVIEW_X, (int) px);
    p_props.setProperty(CSZ_PROP_POSRESVIEW_Y, (int) py);
    p_props.setProperty(CSZ_PROP_DIMRESVIEW_X, (int) dx);
    p_props.setProperty(CSZ_PROP_DIMRESVIEW_Y, (int) dy);
    // p_props.setProperty(CSZ_PROP_SPLITPOS, szDiv);

  }

  @FXML
  void cbIntestaSel(ActionEvent event) {
    m_fltrIntesta = cbIntesta.getSelectionModel().getSelectedItem();
    s_log.debug("ResultView.cbIntestaSel():" + m_fltrIntesta);
  }

  @FXML
  void cbAnnoCompSel(ActionEvent event) {
    m_fltrAnnoComp = cbAnnoComp.getSelectionModel().getSelectedItem();
    s_log.debug("ResultView.cbAnnoCompSel():" + m_fltrAnnoComp);
  }

  @FXML
  void cbQuerySel(ActionEvent event) {
    String szK = cbQuery.getSelectionModel().getSelectedItem();
    String szNam = m_mapQry.get(szK);
    m_qry = m_prQries.getProperty(szNam);
    s_log.debug("ResultView.cbQuerySel():" + szK);
  }

  @FXML
  void btCercaClick(ActionEvent event) {
    // System.out.println("ResultView.btCercaClick()");
    if (m_qry == null) {
      s_log.warn("Non hai selezionato una query");
      return;
    }
    int n = m_qry.indexOf(CSZ_QRY_TRUE);
    if (n < 0) {
      s_log.warn("Query \"{}\" malformata", m_qry);
      return;
    }
    String szLeft = m_qry.substring(0, n + CSZ_QRY_TRUE.length());
    String szRight = m_qry.substring(n + CSZ_QRY_TRUE.length());
    String szFiltr = "";
    if (m_fltrIntesta != null) {
      szFiltr += String.format(" AND NomeIntesta='%s'", m_fltrIntesta.getNomeIntesta());
    }
    if (m_fltrAnnoComp != null) {
      szFiltr += String.format(" AND annoComp=%d", m_fltrAnnoComp);
    }
    String szQryFltr = String.format("%s %s %s", szLeft, szFiltr, szRight);
    m_tbvf = new TableViewFiller(tblview);
    tblview = m_tbvf.openQuery(szQryFltr);
  }

  @FXML
  void btExportCsvClick(ActionEvent event) {
    if (m_qry == null) {
      s_log.warn("Non hai selezionato una query");
      return;
    }
    StringBuilder szFilNam = new StringBuilder().append(cbQuery.getSelectionModel().getSelectedItem());
    if (m_fltrIntesta != null) {
      szFilNam.append("_").append(m_fltrIntesta.getNomeIntesta());
    }
    if (m_fltrAnnoComp != null) {
      szFilNam.append("_").append(m_fltrAnnoComp);
    }
    szFilNam.append(".csv");
    System.out.println("ResultView.btExportCsvClick():" + szFilNam.toString());
    Dataset dts = m_tbvf.getDataset();
    Dts2Csv csv = new Dts2Csv(dts);
    csv.saveFile(szFilNam.toString());
  }

}
