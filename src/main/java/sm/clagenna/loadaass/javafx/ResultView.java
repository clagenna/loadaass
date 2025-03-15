package sm.clagenna.loadaass.javafx;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javafx.application.Platform;
import javafx.beans.value.ObservableValue;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Rectangle2D;
import javafx.scene.Cursor;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.SelectionMode;
import javafx.scene.control.TableRow;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.stage.Screen;
import javafx.stage.Stage;
import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.dbsql.SqlServIntest;
import sm.clagenna.stdcla.javafx.IStartApp;
import sm.clagenna.stdcla.javafx.TableViewFiller;
import sm.clagenna.stdcla.sql.DBConn;
import sm.clagenna.stdcla.sql.Dataset;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.stdcla.sys.ex.DatasetException;
import sm.clagenna.stdcla.utils.AppProperties;
import sm.clagenna.stdcla.utils.Utils;

public class ResultView implements Initializable, IStartApp {
  private static final Logger s_log = LogManager.getLogger(ResultView.class);

  public static final String  CSZ_FXMLNAME          = "ResultView.fxml";
  private static final String CSZ_PROP_POSRESVIEW_X = "resview.x";
  private static final String CSZ_PROP_POSRESVIEW_Y = "resview.y";
  private static final String CSZ_PROP_DIMRESVIEW_X = "resview.lx";
  private static final String CSZ_PROP_DIMRESVIEW_Y = "resview.ly";

  private static final String CSZ_QRY_TRUE   = "1=1";
  private static final String CSZ_PROP_QRIES = "Queries.properties";

  //  private static final DecimalFormat s_xfmt                = new DecimalFormat("#0.0000");
  private static final String  QRY_ANNOCOMP  = ""                                          //
      + "SELECT DISTINCT annoComp FROM EEFattura"                                          //
      + " UNION "                                                                          //
      + "SELECT DISTINCT annoComp FROM GASFattura"                                         //
      + " UNION "                                                                          //
      + "SELECT DISTINCT annoComp FROM H2OFattura;";
  private static final String  QRY_MESESCOMP = ""                                          //
      + "SELECT DISTINCT strftime('%Y-%m', cs.dtIniz) AS meseComp FROM EEConsumo as cs"    //
      + " UNION "                                                                          //
      + "SELECT DISTINCT strftime('%Y-%m', cs.dtIniz) AS meseComp FROM GASConsumo as cs"   //
      + " UNION "                                                                          //
      + "SELECT DISTINCT strftime('%Y-%m', cs.dtIniz) AS meseComp FROM H2OConsumo as cs";
  @FXML
  private ComboBox<RecIntesta> cbIntesta;
  @FXML
  private ComboBox<Integer>    cbAnnoComp;
  @FXML
  private ComboBox<String>     cbMeseComp;
  @FXML
  private TextArea             txWhere;
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
  private String     m_fltrMeseComp;
  private String     m_fltrWhere;
  private String     m_qry;

  private TableViewFiller m_tbvf;

  private String m_CSVfile;

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
    } catch (AppPropsException e) {
      s_log.error("Errore caricamento file {} delle Queries", CSZ_PROP_QRIES);
    }

    caricaComboTitolare();
    caricaComboAnno();
    caricaComboMese();
    // caricaComboQueries();
    caricaComboQueriesFromDB();
    txWhere.textProperty().addListener((obj, old, nv) -> txWhereSel(obj, old, nv));
    impostaForma(m_mainProps);
    if (lstage != null)
      lstage.setOnCloseRequest(e -> {
        closeApp(m_mainProps);
      });
    abilitaBottoni();
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
      s_log.error("Query {}; err={}", QRY_ANNOCOMP, e.getMessage(), e);
    }

  }

  private void caricaComboMese() {
    Connection conn = m_db.getConn();
    List<String> liMese = new ArrayList<>();
    liMese.add((String) null);
    try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(QRY_MESESCOMP)) {
      while (rs.next()) {
        String mese = rs.getString(1);
        liMese.add(mese);
      }
      cbMeseComp.getItems().addAll(liMese);
    } catch (SQLException e) {
      s_log.error("Query {}; err={}", QRY_MESESCOMP, e.getMessage(), e);
    }

  }

  //  @SuppressWarnings("unused")
  //  private void caricaComboQueries() {
  //    m_mapQry = new HashMap<>();
  //    List<String> liQry = new ArrayList<>();
  //    Set<Object> keys = m_prQries.getProperties().keySet();
  //    for (Object k : keys) {
  //      String szKey = k.toString();
  //      if ( !szKey.startsWith("QRY."))
  //        continue;
  //      String szDiz = szKey.substring(4).replace('.', ' ');
  //      m_mapQry.put(szDiz, szKey);
  //      liQry.add(szDiz);
  //    }
  //    cbQuery.getItems().addAll(liQry);
  //  }
  //
  //  private void caricaComboQueriesFromDB() {
  //    Connection conn = m_db.getConn();
  //    m_mapQry = new HashMap<>();
  //    List<String> liQry = new ArrayList<>();
  //    liQry.add((String) null);
  //    String szQryAllViews = m_db.getQueryListViews();
  //    try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(szQryAllViews)) {
  //      while (rs.next()) {
  //        String szViewName = rs.getString(1);
  //        if ( ! (szViewName.startsWith("EE") || //
  //            szViewName.startsWith("GAS") || //
  //            szViewName.startsWith("H2O")))
  //          continue;
  //        liQry.add(szViewName);
  //        m_mapQry.put(szViewName, szViewName);
  //        String szQry = String.format("SELECT * FROM %s WHERE 1=1", szViewName);
  //        m_prQries.getProperties().put(szViewName, szQry);
  //      }
  //      cbQuery.getItems().addAll(liQry);
  //    } catch (SQLException e) {
  //      s_log.error("Query {}; err={}", CSZ_FXMLNAME, e.getMessage(), e);
  //    }
  //  }

  private void caricaComboQueriesFromDB() {
    m_mapQry = m_db.getListDBViews();
    List<String> liNam = new ArrayList<String>(m_mapQry.keySet());
    Collections.sort(liNam);
    cbQuery.getItems().clear();
    cbQuery.getItems().add((String) null);
    cbQuery.getItems().addAll(liNam);
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

    ObservableList<Screen> screenSizes = Screen.getScreens();
    int minX = 0, maxX = 0, minY = 0, maxY = 0;
    for (Screen scr : screenSizes) {
      Rectangle2D rect = scr.getBounds();
      minX = (int) (rect.getMinX() < minX ? rect.getMinX() : minX);
      maxX = (int) (rect.getMaxX() > maxX ? rect.getMaxX() : maxX);
      minY = (int) (rect.getMinY() < minY ? rect.getMinY() : minY);
      maxY = (int) (rect.getMaxY() > maxY ? rect.getMaxY() : maxY);
    }

    int px = p_props.getIntProperty(CSZ_PROP_POSRESVIEW_X);
    int py = p_props.getIntProperty(CSZ_PROP_POSRESVIEW_Y);
    int dx = p_props.getIntProperty(CSZ_PROP_DIMRESVIEW_X);
    int dy = p_props.getIntProperty(CSZ_PROP_DIMRESVIEW_Y);
    if (px * py != 0) {
      px = px < minX ? minX : px;
      px = px > maxX ? maxX - 100 : px;
      py = py < minY ? minY : py;
      py = py > maxY ? maxY - 100 : py;
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
    abilitaBottoni();
  }

  @FXML
  void cbAnnoCompSel(ActionEvent event) {
    m_fltrAnnoComp = cbAnnoComp.getSelectionModel().getSelectedItem();
    s_log.debug("ResultView.cbAnnoCompSel({}):", m_fltrAnnoComp);
    abilitaBottoni();
  }

  @FXML
  void cbMeseCompSel(ActionEvent event) {
    m_fltrMeseComp = cbMeseComp.getSelectionModel().getSelectedItem();
    s_log.debug("ResultView.cbMeseCompSel({}):", m_fltrMeseComp);
    abilitaBottoni();
  }

  @FXML
  void cbQuerySel(ActionEvent event) {
    String szK = cbQuery.getSelectionModel().getSelectedItem();
    m_qry = m_mapQry.get(szK);
    s_log.debug("ResultView.cbQuerySel():" + szK);
    abilitaBottoni();
  }

  @FXML
  void txWhereSel(ObservableValue<? extends String> obj, String old, String nval) {
    m_fltrWhere = nval;
    // s_log.debug("ResultView.txWhereSel({}):", m_fltrWhere);
    abilitaBottoni();
  }

  private void abilitaBottoni() {
    boolean bv = Utils.isValue(m_qry);
    btCerca.setDisable( !bv);
    btExportCsv.setDisable( !bv);
    if (bv) {
      ObservableList<List<Object>> li = tblview.getItems();
      bv = li != null && li.size() > 2;
      btExportCsv.setDisable( !bv);
    }
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
    StringBuilder szFiltr = new StringBuilder();
    if (m_fltrIntesta != null) {
      szFiltr.append(String.format(" AND NomeIntesta='%s'", m_fltrIntesta.getNomeIntesta()));
    }
    if (m_fltrAnnoComp != null) {
      szFiltr.append(String.format(" AND annoComp=%d", m_fltrAnnoComp));
    }
    if (m_fltrMeseComp != null) {
      szFiltr.append(String.format(" AND meseComp='%s'", m_fltrMeseComp));
    }
    if (null != m_fltrWhere && m_fltrWhere.length() > 3) {
      szFiltr.append(String.format(" AND %s", m_fltrWhere));
    }
    String szQryFltr = String.format("%s %s %s", szLeft, szFiltr.toString(), szRight);
    m_tbvf = new TableViewFiller(tblview, m_db);
    m_tbvf.setSzQry(szQryFltr);
    // m_tbvf.openQuery();

    ExecutorService backGrService = Executors.newFixedThreadPool(1);
    Platform.runLater(new Runnable() {
      @Override
      public void run() {
        lstage.getScene().setCursor(Cursor.WAIT);
        btCerca.setDisable(true);
      }
    });

    try {
      m_tbvf.setOnRunning(ev -> {
        s_log.debug("TableViewFiller task running...");
      });
      m_tbvf.setOnSucceeded(ev -> {
        s_log.debug("TableViewFiller task Finished!");
        endTask();
      });
      m_tbvf.setOnFailed(ev -> {
        s_log.debug("TableViewFiller task failure");
        endTask();
      });
      backGrService.execute(m_tbvf);
    } catch (Exception e) {
      s_log.error("Errore task TableViewFiller");
    }
    backGrService.shutdown();

    //    tblview.setRowFactory( tbl -> new  TableRow<Object>() {
    //            TableRow<Object> row = this;
    //            setOnMouseClicked( roev -> {
    //              if ( row.isEmpty())
    //                return;
    //              if ( roev.getClickCount() == 2 ) {
    //                tableRow_dblclick(row);
    //              }
    //              }
    //            );
    //          }
    //        );

    tblview.setRowFactory(tbl -> new TableRow<List<Object>>() {
      {
        setOnMouseClicked(ev -> {
          if (isEmpty())
            return;
          if (ev.getClickCount() == 2) {
            tableRow_dblclick(this);
          }
        });
      }
    });
    tblview.getSelectionModel().setSelectionMode(SelectionMode.MULTIPLE);
    abilitaBottoni();
  }

  private void endTask() {
    Platform.runLater(new Runnable() {
      @Override
      public void run() {
        lstage.getScene().setCursor(Cursor.DEFAULT);
        btCerca.setDisable(false);
        btExportCsv.setDisable(false);
      }
    });

  }

  protected void tableRow_dblclick(TableRow<List<Object>> row) {
    //    System.out.println("ResultView.tableRow_dblclick(row):" + (null != row ? row.getClass().getSimpleName() : "**null**"));
    List<Object> r = tblview.getSelectionModel().getSelectedItem();
    String szPdf = null;
    if (null != r) {
      // System.out.println("r.=" + r.toString());
      for (Object e : r) {
        if (null != e) {
          String sz = e.toString();
          if (sz.toLowerCase().endsWith(".pdf")) {
            szPdf = sz;
            break;
          }
        }
      }
      // System.out.println("PDF = " + szPdf);
    }
    if (null != szPdf) {
      String szLastDir = m_mainProps.getLastDir(); // ??
      szLastDir = m_fltrIntesta.getDirFatture();
      Path pth = Paths.get(szLastDir, szPdf);
      // System.out.println("ResultView.tableRow_dblclick()="+pth.toString());
      if ( !Files.exists(pth, LinkOption.NOFOLLOW_LINKS))
        s_log.error("Il file {} non esiste !", pth.toString());
      else {
        s_log.info("Mostro il file PDF fattura \"{}\"", szPdf);
        m_appmain.getHostServices().showDocument(pth.toString());
      }
    }
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
    LoadAassController cntrl = (LoadAassController) LoadAassMainApp.getInst().getController();
    szFilNam.append(".csv");
    // System.out.println("ResultView.btExportCsvClick():" + szFilNam.toString());
    try {
      Dataset dts = m_tbvf.getDataset();
      //    Dts2Csv csv = new Dts2Csv(dts);
      m_CSVfile = szFilNam.toString();
      dts.savecsv(Paths.get(m_CSVfile));
    } catch (DatasetException e) {
      s_log.error("Save CSV file {} andata male ! err={}", szFilNam, e.getMessage(), e);
    }
    if (cntrl.isLanciaExc())
      lanciaExcel2();
    abilitaBottoni();
  }

  @SuppressWarnings({ "deprecation", "unused" })
  private void lanciaExcel() {
    try {
      File fi = new File(m_CSVfile);
      String sz = fi.getAbsolutePath();
      String szCmd = String.format("cmd /c start excel.exe \"%s\"", sz);
      Runtime.getRuntime().exec(szCmd);
    } catch (IOException e) {
      s_log.error("Errore lancio Excel", e);
      // e.printStackTrace();
    }
  }

  public void lanciaExcel2() {
    File fi = new File(m_CSVfile);
    String sz = fi.getAbsolutePath();
    //    String szCmd = String.format("cmd /c start excel \"%s\"", sz);
    //    szCmd = String.format("\"%s\"", sz);
    ProcessBuilder pb = new ProcessBuilder();
    pb.command("cmd.exe", "/c", "start", "excel.exe", sz);
    pb.redirectErrorStream(true);
    int rc = -1;
    try {
      Process process = pb.start();
      process.getInputStream().transferTo(System.out);
      rc = process.waitFor();
    } catch (IOException e) {
      s_log.error("Errore lancio Excel: {}", e.getMessage(), e);
    } catch (InterruptedException e) {
      s_log.error("Interruzione lancio Excel: {}", e.getMessage(), e);
    }
    if (rc != 0)
      throw new RuntimeException("Start Excel failed rc=" + rc);
  }

  @Override
  public void changeSkin() {
    // TODO Auto-generated method stub

  }

}
