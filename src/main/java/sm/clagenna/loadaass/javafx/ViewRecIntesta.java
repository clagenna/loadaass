package sm.clagenna.loadaass.javafx;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellEditEvent;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.stage.Stage;
import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.SqlServIntest;
import sm.clagenna.loadaass.dbsql.dtset.Dataset;
import sm.clagenna.loadaass.dbsql.dtset.DtsRow;
import sm.clagenna.loadaass.sys.AppProperties;
import sm.clagenna.loadaass.sys.IStartApp;

public class ViewRecIntesta implements Initializable, IStartApp {

  private static final Logger s_log = LogManager.getLogger(ViewRecIntesta.class);

  public static final String  CSZ_FXMLNAME              = "Intesta.fxml";
  private static final String CSZ_PROP_POSINTESTAVIEW_X = "intestaview.x";
  private static final String CSZ_PROP_POSINTESTAVIEW_Y = "intestaview.y";
  private static final String CSZ_PROP_DIMINTESTAVIEW_X = "intestaview.lx";
  private static final String CSZ_PROP_DIMINTESTAVIEW_Y = "intestaview.ly";

  @FXML
  private TableView<RecIntesta>           table;
  @FXML
  private TableColumn<RecIntesta, String> colIdIntesta;
  @FXML
  private TableColumn<RecIntesta, String> colNomeIntesta;
  @FXML
  private TableColumn<RecIntesta, String> colDirFatture;
  @FXML
  private TextField                       txIdIntesta;
  @FXML
  private TextField                       txNomeIntesta;
  @FXML
  private TextField                       txDirFatture;
  @FXML
  private Button                          btAdd;

  @Getter @Setter
  private Scene           myScene;
  private AppProperties   m_mainProps;
  private Stage           lstage;
  private LoadAassMainApp m_appmain;
  private DBConn          m_db;
  private Dataset         m_dts;

  public ViewRecIntesta() {
    //
  }

  @Override
  public void initialize(URL location, ResourceBundle resources) {
    //
  }

  @Override
  public void initApp(AppProperties p_props) {
    m_appmain = LoadAassMainApp.getInst();
    m_mainProps = m_appmain.getProps();
    m_db = m_appmain.getConnSQL();

    openDataset2();
    impostaTableView();
    impostaForma(m_mainProps);
  }

  @SuppressWarnings("unused")
  private Dataset openDataset() {
    String szQry = "SELECT * FROM intesta;";
    m_dts = null;
    try (Dataset dtset = new Dataset(m_db)) {
      if ( !dtset.executeQuery(szQry)) {
        s_log.error("Errore lettura query");
        return m_dts;
      }
      m_dts = dtset;
    } catch (IOException e) {
      // e.printStackTrace();
      s_log.error("Errore open DataSet, err={}", e.getMessage(), e);
      return m_dts;
    }
    List<RecIntesta> li = new ArrayList<>();
    for (DtsRow rec : m_dts.getRighe()) {
      RecIntesta rig = new RecIntesta(rec);
      li.add(rig);
    }
    table.getItems().addAll(li);
    return m_dts;
  }

  private void openDataset2() {
    LoadAassMainApp fattmain = LoadAassMainApp.getInst();
    SqlServIntest sqlInt = fattmain.getSqlIntesta();
    List<RecIntesta> li = sqlInt.getList();
    table.getItems().addAll(li);
  }

  private void impostaTableView() {
    colIdIntesta.setMinWidth(50);
    colIdIntesta.setCellValueFactory(new PropertyValueFactory<RecIntesta, String>(RecIntesta.COL_ID_INTESTA));
    colIdIntesta.setCellFactory(TextFieldTableCell.forTableColumn());
    // colIdIntesta.setOnEditCommit(ev -> cambiaRecIntesta(ev, RecIntesta.COL_ID_INTESTA));
    colIdIntesta.setStyle("-fx-alignment: center-right;");

    colNomeIntesta.setMinWidth(120);
    colNomeIntesta.setCellValueFactory(new PropertyValueFactory<RecIntesta, String>(RecIntesta.COL_NOME_INTESTA));
    colNomeIntesta.setCellFactory(TextFieldTableCell.forTableColumn());
    colNomeIntesta.setOnEditCommit(ev -> cambiaRecIntesta(ev, RecIntesta.COL_NOME_INTESTA));

    colDirFatture.setMinWidth(200);
    colDirFatture.setCellValueFactory(new PropertyValueFactory<RecIntesta, String>(RecIntesta.COL_DIR_FATTURE));
    colDirFatture.setCellFactory(TextFieldTableCell.forTableColumn());
    colDirFatture.setOnEditCommit(ev -> cambiaRecIntesta(ev, RecIntesta.COL_DIR_FATTURE));

    table.setEditable(true);
  }

  private void impostaForma(AppProperties p_props) {
    lstage = null;
    if (myScene == null)
      myScene = btAdd.getScene();
    if (lstage == null && myScene != null)
      lstage = (Stage) myScene.getWindow();
    if (lstage == null) {
      s_log.error("Non trovo lo stage per RecIntestaView");
      return;
    }
    int px = p_props.getIntProperty(CSZ_PROP_POSINTESTAVIEW_X, 0);
    int py = p_props.getIntProperty(CSZ_PROP_POSINTESTAVIEW_Y, 0);
    int dx = p_props.getIntProperty(CSZ_PROP_DIMINTESTAVIEW_X, 0);
    int dy = p_props.getIntProperty(CSZ_PROP_DIMINTESTAVIEW_Y, 0);

    if (px * py != 0) {
      lstage.setX(px);
      lstage.setY(py);
      lstage.setWidth(dx);
      lstage.setHeight(dy);
    }
  }

  private Object cambiaRecIntesta(CellEditEvent<RecIntesta, String> ev, String p_colNam) {
    String val = ev.getNewValue();
    TableView<RecIntesta> tbl = ev.getTableView();
    int k = ev.getTablePosition().getRow();
    RecIntesta rec = tbl.getItems().get(k);
    switch (p_colNam) {
      case RecIntesta.COL_ID_INTESTA:
        rec.setIdIntesta(val);
        break;
      case RecIntesta.COL_NOME_INTESTA:
        rec.setNomeIntesta(val);
        break;
      case RecIntesta.COL_DIR_FATTURE:
        rec.setDirFatture(val);
        break;
    }
    System.out.printf("ViewRecIntesta.cambiaRecIntesta(%s=%s)\trec={%s}\n", p_colNam, val, rec.getClass().getSimpleName());
    return null;
  }

  @FXML
  private Object btAddClick(ActionEvent ev) {
    String szIdInt = txIdIntesta.getText();
    String szNome = txNomeIntesta.getText();
    String szDirFatt = txDirFatture.getText();
    int len = szIdInt == null ? 0 : szIdInt.trim().length();
    len *= szNome == null ? 0 : szNome.trim().length();
    len *= szDirFatt == null ? 0 : szDirFatt.trim().length();
    if (len == 0) {
      showAlert(AlertType.WARNING, "Manca qualche campo per aggiungere il record", ButtonType.OK);
      return null;
    }
    LoadAassMainApp fattmain = LoadAassMainApp.getInst();
    SqlServIntest sqlInt = fattmain.getSqlIntesta();
    RecIntesta newRec = new RecIntesta(szIdInt, szNome, szDirFatt);
    newRec.setChanged(true);
    if ( !sqlInt.isValidRecord(newRec)) {
      String szMsg = "Non posso aggiungere questo record\nForse gia' presente ?";
      showAlert(AlertType.WARNING, szMsg, ButtonType.OK);
      return null;
    }
    table.getItems().add(newRec);

    int ret = sqlInt.addNewRec(newRec);

    txIdIntesta.clear();
    txNomeIntesta.clear();
    txDirFatture.clear();
    if (ret == 1) {
      String szMsg = "Aggiunto nuovo rec nel DB!";
      showAlert(AlertType.INFORMATION, szMsg, ButtonType.OK);
    }
    return null;
  }

  private void showAlert(AlertType typ, String msg, ButtonType bt) {
    Alert alert = new Alert(typ, msg, bt);
    double posx = myScene.getWindow().getX();
    double posy = myScene.getWindow().getY();
    double widt = myScene.getWidth();
    double px = posx + widt / 2 - 366;
    double py = posy + 50;
    alert.setX(px);
    alert.setY(py);
    alert.showAndWait();
  }

  @FXML
  private Object btSaveClick(ActionEvent ev) {
    System.out.println("ViewRecIntesta.btSaveClick()");
    ObservableList<RecIntesta> li = table.getItems();
    for (RecIntesta rec : li) {
      if (rec.isChanged()) {
        System.out.println("Save:" + rec.getNomeIntesta());
      }
    }
    LoadAassMainApp fattmain = LoadAassMainApp.getInst();
    SqlServIntest sqlInt = fattmain.getSqlIntesta();
    int ret = sqlInt.saveUpdates();
    String szMsg = String.format("Salvati %d rec nel DB", ret);
    showAlert(AlertType.INFORMATION, szMsg, ButtonType.OK);
    return null;
  }

  @Override
  public void closeApp(AppProperties p_props) {
    double px = myScene.getWindow().getX();
    double py = myScene.getWindow().getY();
    double dx = myScene.getWindow().getWidth();
    double dy = myScene.getWindow().getHeight();

    p_props.setProperty(CSZ_PROP_POSINTESTAVIEW_X, (int) px);
    p_props.setProperty(CSZ_PROP_POSINTESTAVIEW_Y, (int) py);
    p_props.setProperty(CSZ_PROP_DIMINTESTAVIEW_X, (int) dx);
    p_props.setProperty(CSZ_PROP_DIMINTESTAVIEW_Y, (int) dy);
  }
}
