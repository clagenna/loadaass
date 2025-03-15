package prova.javafx.updtab;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellEditEvent;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;
import sm.clagenna.stdcla.sql.DBConn;
import sm.clagenna.stdcla.sql.DBConnFactory;
import sm.clagenna.stdcla.sql.Dataset;
import sm.clagenna.stdcla.sql.DtsCol;
import sm.clagenna.stdcla.sql.DtsCols;
import sm.clagenna.stdcla.sql.DtsRow;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.stdcla.utils.AppProperties;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

/**
 * Vedi <a href=
 * "https://docs.oracle.com/javafx/2/ui_controls/table-view.htm#:~:text=Editing%20Data%20in%20the%20Table,help%20of%20the%20TextFieldTableCell%20class."
 * > sito</a>
 */
public class P01PrUpdTabViewWithMap extends Application {
  private static final String CSZ_FILE_PROPERTIES = "loadAass.properties";

  private TableView<List<Object>> tableview;

  private AppProperties                     m_prop;
  private DBConn                            m_db;
  private Dataset                           m_dts;
  private Map<String, SimpleStringProperty> m_mapCols;

  public P01PrUpdTabViewWithMap() {
    //
  }

  private void doTheJob() throws Exception {
    openProps();
    openDB();
    openDataset();
    creaTableView();
    creaMapFields();
    fillTableView();
  }

  private void openProps() throws FileNotFoundException, ReadFattPropsException, AppPropsException {
    AppProperties.setSingleton(false);
    try {
      m_prop = new AppProperties();
    } catch (AppPropsException e) {
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
    String szQry = "SELECT idEEConsumo," //
        + "       idEEFattura," //
        + "       tipoSpesa," //
        + "       dtIniz," //
        + "       dtFine," //
        + "       prezzoUnit," //
        + "       quantita," //
        + "       importo" //
        + "  FROM EEConsumo;";
    szQry = "SELECT *" //
        + "  FROM prova;";

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
    //

  }

  @SuppressWarnings({ "unchecked", "rawtypes" })
  private void creaMapFields() {
    DtsCols cols = m_dts.getColumns();
    m_mapCols = new HashMap<>();
    tableview = new TableView<>();
    int k = 0;
    for (DtsCol col : cols.getColumns()) {
      final int j = k++;
      final String szColNam = col.getName();
      SimpleStringProperty colTab = new SimpleStringProperty(szColNam);
      m_mapCols.put(szColNam, colTab);

      String cssAlign = "-fx-alignment: center-left;";
      int colWdth = 100;
      switch (col.getType()) {
        case BIGINT:
        case DATE:
        case DOUBLE:
        case DECIMAL:
        case FLOAT:
        case INTEGER:
        case NUMERIC:
        case REAL:
          cssAlign = "-fx-alignment: center-right;";
          colWdth = 50;
          break;
        default:
          break;
      }
      TableColumn<List<Object>, String> tbcol = new TableColumn<>(szColNam);
      tbcol.setStyle(cssAlign);
      tbcol.setMinWidth(colWdth);
      // tbcol.setCellValueFactory(new PropertyValueFactory<List<Object>, String>(szColNam));
      tbcol.setCellValueFactory(riga -> {
        List<Object> setto = riga.getValue();
        Object val = setto.get(j);
        System.out.printf("P01PrUpdTabViewWithMap.creaMapFields(%s)", val);
        return new ReadOnlyObjectWrapper(val);
      });

      tbcol.setCellFactory(TextFieldTableCell.forTableColumn());
      tbcol.setOnEditCommit(ev -> cambiaCampo(ev, szColNam));
      tableview.getColumns().add(tbcol);
    }
  }

  private Object cambiaCampo(CellEditEvent<List<Object>, String> ev, String szColNam) {
    String val = ev.getNewValue();
    TableView<List<Object>> tbl = ev.getTableView();
    int k = ev.getTablePosition().getRow();
    Object rec = tbl.getItems().get(k);
    // DAFARE cambiare il valore del campo in rec
    System.out.printf("P01PrUpdTabView.cambiaCampo(%s=%s)\trec={%s}\n", szColNam, val, rec.getClass().getSimpleName());
    return null;
  }

  private void fillTableView() {
    ObservableList<List<Object>> dati = FXCollections.observableArrayList();
    for (DtsRow riga : m_dts.getRighe()) {
      ObservableList<Object> tbRiga = FXCollections.observableArrayList();
      tbRiga.addAll(riga.getValues());
      dati.add(tbRiga);
    }
    tableview.setItems(dati);
  }

  @Override
  public void start(Stage stage) throws Exception {
    doTheJob();
    Scene scene = new Scene(tableview);
    stage.setScene(scene);
    stage.setOnCloseRequest(new EventHandler<WindowEvent>() {
      @Override
      public void handle(WindowEvent event) {
        Platform.exit();
        System.exit(0);
      }
    });
    stage.show();
  }

  public static void main(String[] args) {
    Application.launch(args);
  }

}
