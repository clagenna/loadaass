package prova.javafx.updtab;

import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.stage.Stage;

public class P02TableviewEditable extends Application {

  private TableView<P02Person>            table = new TableView<>();
  private final ObservableList<P02Person> data  = FXCollections.observableArrayList(
      new P02Person("Jacob", "Smith", "jacob.smith@example.com"),                   //
      new P02Person("Isabella", "Johnson", "isabella.johnson@example.com"),         //
      new P02Person("Ethan", "Williams", "ethan.williams@example.com"),             //
      new P02Person("Emma", "Jones", "emma.jones@example.com"),                     //
      new P02Person("Michael", "Brown", "michael.brown@example.com"));
  final HBox                              hb    = new HBox();

  public static void main(String[] args) {
    Application.launch(args);
  }

  @SuppressWarnings("unchecked")
  @Override
  public void start(Stage stage) {
    Scene scene = new Scene(new Group());
    stage.setTitle("Table View Sample");
    stage.setWidth(450);
    stage.setHeight(550);

    final Label label = new Label("Address Book");
    label.setFont(new Font("Arial", 20));

    table.setEditable(true);

    TableColumn<P02Person, String> firstNameCol = new TableColumn<>("First Name");
    firstNameCol.setMinWidth(100);
    firstNameCol.setCellValueFactory(new PropertyValueFactory<P02Person, String>("firstName"));

    TableColumn<P02Person, String> lastNameCol = new TableColumn<>("Last Name");
    lastNameCol.setMinWidth(100);
    lastNameCol.setCellValueFactory(new PropertyValueFactory<P02Person, String>("lastName"));

    TableColumn<P02Person, String> emailCol = new TableColumn<>("Email");
    emailCol.setMinWidth(200);
    emailCol.setCellValueFactory(new PropertyValueFactory<P02Person, String>("email"));

    table.setItems(data);

    ObservableList<TableColumn<P02Person, ?>> cols = table.getColumns();
    cols.addAll(firstNameCol, lastNameCol, emailCol);

    final TextField addFirstName = new TextField();
    addFirstName.setPromptText("First Name");
    addFirstName.setMaxWidth(firstNameCol.getPrefWidth());
    final TextField addLastName = new TextField();
    addLastName.setMaxWidth(lastNameCol.getPrefWidth());
    addLastName.setPromptText("Last Name");
    final TextField addEmail = new TextField();
    addEmail.setMaxWidth(emailCol.getPrefWidth());
    addEmail.setPromptText("Email");

    final Button addButton = new Button("Add");
    addButton.setOnAction(new EventHandler<ActionEvent>() {
      @Override
      public void handle(ActionEvent e) {
        String szFir = addFirstName.getText();
        String szLas = addLastName.getText();
        String szEma = addEmail.getText();
        int len = szFir == null ? 0 : szFir.trim().length();
        len *= szLas == null ? 0 : szLas.trim().length();
        len *= szEma == null ? 0 : szEma.trim().length();
        if (len == 0) {
          Alert alert = new Alert(AlertType.WARNING, "Manca qualche campo per aggiungere", ButtonType.OK);
          alert.showAndWait();
          return;
        }
        data.add(new P02Person(szFir, szLas, szEma));
        addFirstName.clear();
        addLastName.clear();
        addEmail.clear();
      }
    });

    hb.getChildren().addAll(addFirstName, addLastName, addEmail, addButton);
    hb.setSpacing(3);

    final VBox vbox = new VBox();
    vbox.setSpacing(5);
    vbox.setPadding(new Insets(10, 0, 0, 10));
    vbox.getChildren().addAll(label, table, hb);

    ((Group) scene.getRoot()).getChildren().addAll(vbox);

    stage.setScene(scene);
    stage.show();
  }
}
