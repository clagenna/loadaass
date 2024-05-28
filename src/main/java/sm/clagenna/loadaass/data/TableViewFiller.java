package sm.clagenna.loadaass.data;

import java.io.IOException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.dtset.Dataset;
import sm.clagenna.loadaass.dbsql.dtset.DtsCol;
import sm.clagenna.loadaass.dbsql.dtset.DtsCols;
import sm.clagenna.loadaass.dbsql.dtset.DtsRow;
import sm.clagenna.loadaass.javafx.LoadAassMainApp;

public class TableViewFiller {

  private static final Logger s_log = LogManager.getLogger(TableViewFiller.class);

  private String                  m_szQry;
  private TableView<List<Object>> tableview;
  private DBConn                  m_db;
  private Dataset                 m_dts;

  public TableViewFiller(TableView<List<Object>> tblview) {
    tableview = tblview;
  }

  public TableView<List<Object>> openQuery(String szQryFltr) {
    m_szQry = szQryFltr;
    m_db = LoadAassMainApp.getInst().getConnSQL();
    openDataSet();
    if (m_dts == null)
      return tableview;
    creaTableView();
    fillTableView();
    return tableview;
  }

  public Dataset getDataset() {
    return m_dts;
  }

  private Dataset openDataSet() {
    m_dts = null;
    s_log.debug("Lancio query:{}", m_szQry);
    try (Dataset dtset = new Dataset(m_db)) {
      if ( !dtset.executeQuery(m_szQry)) {
        s_log.error("Lettura andata male !");
      } else
        m_dts = dtset;
    } catch (IOException e) {
      e.printStackTrace();
    }
    return m_dts;
  }

  private void creaTableView() {
    DtsCols cols = m_dts.getColumns();
    // tableview = new TableView<>();
    tableview.getItems().clear();
    tableview.getColumns().clear();
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

  private void fillTableView() {
    ObservableList<List<Object>> dati = FXCollections.observableArrayList();
    List<DtsRow> righe = m_dts.getRighe();
    if (righe == null) {
      s_log.info("Nessuna informazione da mostrare");
      return;
    }
    for (DtsRow riga : m_dts.getRighe()) {
      ObservableList<Object> tbRiga = FXCollections.observableArrayList();
      tbRiga.addAll(riga.getValues());
      dati.add(tbRiga);
    }
    tableview.setItems(dati);
  }

  private Object formattaCella(Object p_o) {
    if (p_o == null)
      return "**null**";
    return p_o;
  }

}
