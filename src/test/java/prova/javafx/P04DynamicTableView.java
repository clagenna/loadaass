package prova.javafx;

import java.util.List;

import javafx.application.Application;
import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Scene;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.stage.Stage;

public class P04DynamicTableView extends Application {
  private static final int N_COLS = 5;
  private static final int N_ROWS = 100;

  @Override
  public void start(Stage stage) throws Exception {
    P04LoremIpsumGenerator dataGenerator = new P04LoremIpsumGenerator();

    TableView<ObservableList<String>> tableView = new TableView<>();

    // add columns
    List<String> columnNames = dataGenerator.getNext(N_COLS);
    for (int i = 0; i < columnNames.size(); i++) {
      final int finalIdx = i;
      TableColumn<ObservableList<String>, String> column;
      column = new TableColumn<>(columnNames.get(i));
      column.setCellValueFactory(param -> new ReadOnlyObjectWrapper<>(param.getValue().get(finalIdx)));
      tableView.getColumns().add(column);
    }

    // add data
    for (int i = 0; i < N_ROWS; i++) {
      List<String> liWords = dataGenerator.getNext(N_COLS);
      ObservableList<String> coll = FXCollections.observableArrayList(liWords);
      tableView.getItems().add(coll);
    }

    tableView.setPrefHeight(200);

    Scene scene = new Scene(tableView);
    stage.setScene(scene);
    stage.show();
  }

  public static void main(String[] args) {
    Application.launch(args);
  }
}
