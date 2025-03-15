package prova.javafx.dyntabvw;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;
import sm.clagenna.stdcla.sql.DBConn;
import sm.clagenna.stdcla.sql.DBConnFactory;
import sm.clagenna.stdcla.sql.Dataset;
import sm.clagenna.stdcla.sql.DtsCol;
import sm.clagenna.stdcla.sql.DtsCols;
import sm.clagenna.stdcla.sql.DtsRow;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.stdcla.utils.AppProperties;

public class P08Dataset2TableView extends Application {
  private static final String     CSZ_FILE_PROPERTIES = "loadAass.properties";
  private AppProperties           m_prop;
  private TableView<List<Object>> tableview;
  private DBConn                  m_db;
  private Dataset                 m_dts;

  public P08Dataset2TableView() {
    //
  }

  private void doTheJob() throws Exception {
    openProps();
    openDB();
    openDataset();
    creaTableView();
    fillTableView();
  }

  private void openProps() throws FileNotFoundException, ReadFattPropsException, AppPropsException {
    AppProperties.setSingleton(false);
    m_prop = new AppProperties();
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
    szQry = "SELECT chiave," //
        + "       stringa," //
        + "       intero," //
        + "       prezzo," //
        + "       dataoggi," //
        + "       percento" //
        + "  FROM prova;";
    szQry = m_prop.getProperty("QRY.EE.comsumo");

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
    DtsCols cols = m_dts.getColumns();
    tableview = new TableView<>();
    int k = 0;
    for (DtsCol col : cols.getColumns()) {
      final int j = k++;
      String szColNam = col.getName();
      String cssAlign = "-fx-alignment: center-left;";
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
          break;
        default:
          break;
      }
      TableColumn<List<Object>, Object> tbcol = new TableColumn<>(szColNam);
      tbcol.setCellValueFactory(param -> new SimpleObjectProperty<Object>(formattaCella(param.getValue().get(j))));
      tbcol.setStyle(cssAlign);
      tableview.getColumns().add(tbcol);
    }

  }

  private Object formattaCella(Object p_o) {
    if (p_o == null)
      return "**null**";
    return p_o;
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
