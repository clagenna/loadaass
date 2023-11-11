package prova.javafx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javafx.application.Application;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

//Author: Yerbol
//SQL database "sqlbase_schema" contains a Table "sqlbase_table" with 3 columns: "id" (Integer(INT(11))), "name" (String(VARCHAR(45))), "married" (Boolean(TINYINT(1)));
// from: https://copyprogramming.com/howto/how-to-fill-up-a-tableview-with-database-data
public class P06TableViewFromDB extends Application {

  private TableView<Person> tableView = new TableView<>();

  @Override
  public void start(Stage primaryStage) throws SQLException, ClassNotFoundException {
    //Show window
    buildData();
    Parent root = tableView;
    primaryStage.setScene(new Scene(root, 300, 275));
    primaryStage.show();
  }

  public void buildData() throws ClassNotFoundException, SQLException {
    Connection dbConnection;
    //SQL Database connection params
    //    String dbHost = "localhost";
    //    String dbPort = "3306";
    String dbUser = "root";
    String dbPassword = "12345";
    String dbName = "data/sql/SQLite/SQLaass.sqlite3";

    String select = "SELECT chiave, stringa, intero, prezzo, dataoggi, percento FROM prova";
    //    String connectionString = "jdbc:mysql://" + dbHost //
    //        + ":" + dbPort + "/" + dbName //
    //        + "?useLegacyDatetimeCode=false&&serverTimezone=" + TimeZone.getDefault().getID();
    String connectionString = String.format("jdbc:sqlite:%s", dbName);
    // Class.forName("com.mysql.cj.jdbc.Driver");
    //Connecting to Database
    dbConnection = DriverManager.getConnection(connectionString, dbUser, dbPassword);
    //Extracting data from Databasee
    ResultSet resultSet = null;
    try {
      PreparedStatement preparedStatement = dbConnection.prepareStatement(select);
      resultSet = preparedStatement.executeQuery();
    } catch (SQLException e) {
      e.printStackTrace();
      return;
    }
    ObservableList<Person> dbData = FXCollections.observableArrayList(dataBaseArrayList(resultSet));
    //Giving readable names to columns
    int qta = resultSet.getMetaData().getColumnCount();
    for (int i = 0; i < qta; i++) {
      TableColumn<Person, String> column = new TableColumn<>();
      switch (resultSet.getMetaData().getColumnName(i + 1)) {
        case "id":
          column.setText("ID #");
          break;
        case "name":
          column.setText("Person Name");
          break;
        case "married":
          column.setText("Marital Status");
          break;
        default:
          column.setText(resultSet.getMetaData().getColumnName(i + 1)); //if column name in SQL Database is not found, then TableView column receive SQL Database current column name (not readable)
          break;
      }
      column.setCellValueFactory(new PropertyValueFactory<>(resultSet.getMetaData().getColumnName(i + 1))); //Setting cell property value to correct variable from Person class.
      tableView.getColumns().add(column);
    }
    //Filling up tableView with data
    tableView.setItems(dbData);
  }

  public class Person {
    IntegerProperty id      = new SimpleIntegerProperty(); //variable names should be exactly as column names in SQL Database Table. In case if you want to use  type instead of , then you need to use getter/setter procedures instead of xxxProperty() below
    StringProperty  name    = new SimpleStringProperty();
    BooleanProperty married = new SimpleBooleanProperty();

    public IntegerProperty idProperty() { //name should be exactly like this [IntegerProperty variable name (id) + (Property) = idProperty] (case sensitive)
      return id;
    }

    public StringProperty nameProperty() {
      return name;
    }

    public BooleanProperty marriedProperty() {
      return married;
    }

    public Person(int idValue, String nameValue, boolean marriedValue) {
      id.set(idValue);
      name.set(nameValue);
      married.set(marriedValue);
    }

    Person() {
    }
  }

  //extracting data from ResulSet to ArrayList
  private ArrayList<Person> dataBaseArrayList(ResultSet resultSet) throws SQLException {
    ArrayList<Person> data = new ArrayList<>();
    while (resultSet.next()) {
      Person person = new Person();
      person.id.set(resultSet.getInt("id"));
      person.name.set(resultSet.getString("name"));
      person.married.set(resultSet.getBoolean("married"));
      data.add(person);
    }
    return data;
  }

  public static void main(String[] args) {
    Application.launch(args);
  }
}
