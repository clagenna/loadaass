package prova.javafx;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;
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

/**
 * @author Narayan from:
 *         https://blog.ngopal.com.np/2011/10/19/dyanmic-tableview-data-from-database/
 */
public class P07Resultset2TableView extends Application {

  //TABLE VIEW AND DATA
  private ObservableList<List<Object>> data;
  private TableView<List<Object>>      tableview;

  //MAIN EXECUTOR
  public static void main(String[] args) {
    Application.launch(args);
  }

  //CONNECTION DATABASE
  public void buildData() {
    Connection c;
    data = FXCollections.observableArrayList();
    try {
      c = P07ConnectDB.connect();
      //SQL FOR SELECTING ALL OF CUSTOMER
      String SQL = "SELECT * from prova";
      //ResultSet
      ResultSet res = c.createStatement().executeQuery(SQL);

      /**
       ********************************* TABLE COLUMN ADDED DYNAMICALLY *
       *********************************
       */
      ResultSetMetaData meta = res.getMetaData();
      int qtaCol = meta.getColumnCount();
      for (int i = 0; i < qtaCol; i++) {
        //We are using non property style for making dynamic table
        final int j = i;
        String szColName = meta.getColumnName(i + 1);
        String cssAlign = null;
        switch (meta.getColumnType(i + 1)) {
          case Types.BIGINT:
          case Types.DATE:
          case Types.DOUBLE:
          case Types.DECIMAL:
          case Types.FLOAT:
          case Types.INTEGER:
          case Types.NUMERIC:
          case Types.REAL:
            cssAlign = "-fx-alignment: center-right;";
            break;
          default:
            cssAlign = "-fx-alignment: center-left;";
            break;
        }
        TableColumn<List<Object>, Object> col = new TableColumn<>(szColName);
        col.setCellValueFactory(param -> new SimpleObjectProperty<Object>(formattaCella(param.getValue().get(j))));
        col.setStyle(cssAlign);
        tableview.getColumns().add(col);
        System.out.printf("Column [%d]=\"%s\"", i, szColName);
      }
      System.out.println();

      /**
       ******************************* Data added to ObservableList *
       *******************************
       */
      while (res.next()) {
        //Iterate Row
        ObservableList<Object> row = FXCollections.observableArrayList();
        for (int i = 1; i <= qtaCol; i++) {
          //Iterate Column
          Object oo = res.getObject(i);
          row.add(oo);
        }
        System.out.println("Row [1] added " + row);
        data.add(row);
      }

      //FINALLY ADDED TO TableView
      tableview.setItems(data);
    } catch (Exception e) {
      e.printStackTrace();
      System.out.println("Error on Building Data");
    }
  }

  private Object formattaCella(Object p_o) {
    if (p_o == null)
      return "**null**";
    return p_o;
  }

  @Override
  public void start(Stage stage) throws Exception {
    //TableView
    tableview = new TableView<>();
    buildData();

    //Main Scene
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
}
