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
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import sm.clagenna.loadaass.data.TableViewFiller;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.SqlServIntest;
import sm.clagenna.loadaass.dbsql.SqlServIntest.RecIntesta;
import sm.clagenna.loadaass.sys.AppProperties;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

public class ResultView implements Initializable {
  private static final Logger s_log = LogManager.getLogger(ResultView.class);

  public static final String  CSZ_FXMLNAME   = "ResultView4.fxml";
  private static final String CSZ_QRY_TRUE   = "1=1";
  private static final String CSZ_PROP_QRIES = "Queries.properties";
  private static final String QRY_ANNOCOMP   = ""                   //
      + "SELECT DISTINCT annoComp FROM EEFattura"                   //
      + " UNION "                                                   //
      + "SELECT DISTINCT annoComp FROM GASFattura"                  //
      + " UNION "                                                   //
      + "SELECT DISTINCT annoComp FROM H2OFattura;";

  @FXML private Button               btCerca;
  @FXML private ComboBox<RecIntesta> cbIntesta;
  @FXML private ComboBox<Integer>    cbAnnoComp;
  @FXML private ComboBox<String>     cbQuery;

  @FXML private TextField txDtEmiss;
  @FXML private TextField txFattNo;
  @FXML private TextField txPeriodoFatt;
  @FXML private TextField txTotPagare;
  @FXML private TextField txCredPrec;
  @FXML private TextField txCredAttuale;
  @FXML private TextField txAddizFER;

  @FXML private TableView<List<Object>> tblview;

  private AppProperties       m_prQries;
  private LoadAassMainApp     m_appmain;
  private DBConn              m_db;
  private Map<String, String> m_mapQry;

  private RecIntesta m_fltrIntesta;
  private Integer    m_fltrAnnoComp;
  private String     m_qry;

  public ResultView() {
    //
  }

  @Override
  public void initialize(URL p_location, ResourceBundle p_resources) {
    m_appmain = LoadAassMainApp.getInst();
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
    caricaComboQueries();
  }

  private void caricaComboTitolare() {
    SqlServIntest intesta = m_appmain.getIntesta();
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

  @FXML
  void cbIntestaSel(ActionEvent event) {
    m_fltrIntesta = cbIntesta.getSelectionModel().getSelectedItem();
    System.out.println("ResultView.cbIntestaSel():" + m_fltrIntesta);
  }

  @FXML
  void cbAnnoCompSel(ActionEvent event) {
    m_fltrAnnoComp = cbAnnoComp.getSelectionModel().getSelectedItem();
    System.out.println("ResultView.cbAnnoCompSel():" + m_fltrAnnoComp);
  }

  @FXML
  void cbQuerySel(ActionEvent event) {
    String szK = cbQuery.getSelectionModel().getSelectedItem();
    String szNam = m_mapQry.get(szK);
    m_qry = m_prQries.getProperty(szNam);
    System.out.println("ResultView.cbQuerySel():" + szK);
  }

  @FXML
  void btCercaClick(ActionEvent event) {
    System.out.println("ResultView.btCercaClick()");
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
      szFiltr += String.format(" AND te.NomeIntesta='%s'", m_fltrIntesta.nome());
    }
    if (m_fltrAnnoComp != null) {
      szFiltr += String.format(" AND ft.annoComp=%d", m_fltrAnnoComp);
    }
    String szQryFltr = String.format("%s %s %s", szLeft, szFiltr, szRight);
    TableViewFiller tbv = new TableViewFiller(tblview);
    tblview = tbv.openQuery(szQryFltr);

  }

}
