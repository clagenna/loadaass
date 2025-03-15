package prova.javafx.updtab;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javafx.application.Application;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.geometry.Insets;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellEditEvent;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import sm.clagenna.stdcla.sql.DBConn;
import sm.clagenna.stdcla.sql.DBConnFactory;
import sm.clagenna.stdcla.sql.Dataset;
import sm.clagenna.stdcla.sql.DtsRow;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.stdcla.utils.AppProperties;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

public class P04TableViewRecIntesta extends Application {

  private static final String COL_ID_INTESTA   = "idIntesta";
  private static final String COL_NOME_INTESTA = "nomeIntesta";
  private static final String COL_DIR_FATTURE  = "dirFatture";

  private static final String CSZ_FILE_PROPERTIES = "loadAass.properties";

  private TableView<P04Intesta>           table = new TableView<>();
  private TableColumn<P04Intesta, String> idIntestaCol;
  private TableColumn<P04Intesta, String> nomeIntestaCol;
  private TableColumn<P04Intesta, String> dirFattureCol;
  private HBox                            hb;
  private VBox                            vb;

  private AppProperties m_prop;
  private DBConn        m_db;
  private Dataset       m_dts;
  private Scene         scene;

  private Label     label;
  private TextField addIdIntesta;
  private TextField addNomeIntesta;
  private TextField addDirFatture;

  public static void main(String[] args) {
    Application.launch(args);
  }

  @Override
  public void start(Stage stage) throws Exception {
    scene = new Scene(new Group());
    stage.setTitle("Intestatari di Fatture");
    stage.setWidth(450);
    stage.setHeight(550);

    label = new Label("Elenco degli Intestatari");
    label.setFont(new Font("Arial", 20));

    doTheJob();

    stage.setScene(scene);
    stage.show();
  }

  private void doTheJob() throws Exception {
    openProps();
    openDB();
    openDataset();
    creaTableView();
    creaInsertRow();
    vb = new VBox();
    vb.setSpacing(5);
    vb.setPadding(new Insets(10, 0, 0, 10));
    vb.getChildren().addAll(label, table, hb);
    ((Group) scene.getRoot()).getChildren().addAll(vb);
    fillTableView();
  }

  private void openProps() throws FileNotFoundException, ReadFattPropsException, AppPropsException {
    AppProperties.setSingleton(false);
    try {
      m_prop = new AppProperties();
    } catch (AppPropsException  e) {
      e.printStackTrace();
    }
    File fiProp = new File(CSZ_FILE_PROPERTIES);
    if ( !fiProp.exists())
      throw new FileNotFoundException(CSZ_FILE_PROPERTIES);
    m_prop.leggiPropertyFile(fiProp, true, false);
  }

  private void openDB() {
    DBConnFactory conFact = new DBConnFactory();
    String szDbType = m_prop.getProperty(AppProperties.CSZ_PROP_DB_Type);
    m_db = conFact.get(szDbType);
    m_db.readProperties(m_prop);
    // m_db.changePragma();
    m_db.doConn();
  }

  private Dataset openDataset() {
    String szQry = "SELECT * FROM intesta;";
    try (Dataset dtset = new Dataset(m_db)) {
      if ( !dtset.executeQuery(szQry)) {
        System.err.println("Lettura andata male !");
      } else
        m_dts = dtset;
    } catch (IOException e) {
      e.printStackTrace();
    }
    return m_dts;
  }

  private void creaTableView() {
    table.setEditable(true);

    idIntestaCol = new TableColumn<>(COL_ID_INTESTA);
    idIntestaCol.setMinWidth(50);
    idIntestaCol.setCellValueFactory(new PropertyValueFactory<P04Intesta, String>(COL_ID_INTESTA));
    idIntestaCol.setCellFactory(TextFieldTableCell.forTableColumn());
    idIntestaCol.setOnEditCommit(ev -> cambiaidRecIntesta(ev, COL_ID_INTESTA));
    idIntestaCol.setStyle("-fx-alignment: center-right;");

    nomeIntestaCol = new TableColumn<>(COL_NOME_INTESTA);
    nomeIntestaCol.setMinWidth(100);
    nomeIntestaCol.setCellValueFactory(new PropertyValueFactory<P04Intesta, String>(COL_NOME_INTESTA));
    nomeIntestaCol.setCellFactory(TextFieldTableCell.forTableColumn());
    nomeIntestaCol.setOnEditCommit(ev -> cambiaidRecIntesta(ev, COL_NOME_INTESTA));

    dirFattureCol = new TableColumn<>(COL_DIR_FATTURE);
    dirFattureCol.setMinWidth(200);
    dirFattureCol.setCellValueFactory(new PropertyValueFactory<P04Intesta, String>(COL_DIR_FATTURE));
    dirFattureCol.setCellFactory(TextFieldTableCell.forTableColumn());
    dirFattureCol.setOnEditCommit(ev -> cambiaidRecIntesta(ev, COL_DIR_FATTURE));

    ObservableList<TableColumn<P04Intesta, ?>> cols = table.getColumns();
    cols.add(idIntestaCol);
    cols.add(nomeIntestaCol);
    cols.add(dirFattureCol);

  }

  private void creaInsertRow() {
    addIdIntesta = new TextField();
    addIdIntesta.setPromptText("Id Intesta");
    addIdIntesta.setMaxWidth(idIntestaCol.getPrefWidth());

    addNomeIntesta = new TextField();
    addNomeIntesta.setMaxWidth(nomeIntestaCol.getPrefWidth());
    addNomeIntesta.setPromptText("Nome Intestatario");

    addDirFatture = new TextField();
    addDirFatture.setMaxWidth(dirFattureCol.getPrefWidth());
    addDirFatture.setPromptText("Dir. delle fatture");

    final Button addButton = new Button("Add");
    addButton.setOnAction(ev -> btAddClick(ev));
    hb = new HBox();
    hb.getChildren().addAll(addIdIntesta, addNomeIntesta, addDirFatture, addButton);
    hb.setSpacing(3);
  }

  private Object btAddClick(ActionEvent ev) {
    String szIdInt = addIdIntesta.getText();
    String szNome = addNomeIntesta.getText();
    String szDirFatt = addDirFatture.getText();
    int len = szIdInt == null ? 0 : szIdInt.trim().length();
    len *= szNome == null ? 0 : szNome.trim().length();
    len *= szDirFatt == null ? 0 : szDirFatt.trim().length();
    if (len == 0) {
      Alert alert = new Alert(AlertType.WARNING, "Manca qualche campo per aggiungere", ButtonType.OK);
      alert.showAndWait();
      return null;
    }
    dataAdd(new P04Intesta(szIdInt, szNome, szDirFatt));
    addIdIntesta.clear();
    addNomeIntesta.clear();
    addDirFatture.clear();
    return null;
  }

  private void fillTableView() {
    System.out.println("--> passa i dati dal dataset alla tableview");
    List<P04Intesta> li = new ArrayList<>();
    for (DtsRow rec : m_dts.getRighe()) {
      P04Intesta rig = new P04Intesta(rec);
      li.add(rig);
    }
    table.getItems().addAll(li);
  }

  private Object cambiaidRecIntesta(CellEditEvent<P04Intesta, String> ev, String p_colNam) {
    String val = ev.getNewValue();
    TableView<P04Intesta> tbl = ev.getTableView();
    int k = ev.getTablePosition().getRow();
    P04Intesta rec = tbl.getItems().get(k);
    switch (p_colNam) {
      case COL_ID_INTESTA:
        rec.setIdIntesta(val);
        break;
      case COL_NOME_INTESTA:
        rec.setNomeIntesta(val);
        break;
      case COL_DIR_FATTURE:
        rec.setDirFatture(val);
        break;
    }
    System.out.printf("P04TableViewRecIntesta.cambiaidIntesta(%s=%s)\trec={%s}\n", COL_ID_INTESTA, val,
        rec.getClass().getSimpleName());
    return null;
  }

  private void dataAdd(P04Intesta p) {
    table.getItems().add(p);
  }

}
