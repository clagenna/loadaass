package prova.javafx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Narayan
 */
public class P07ConnectDB {

  private static Connection conn;
  private static String     user = "root";
  private static String     pass = "rootp@$$";

  public static Connection connect() throws SQLException {
    String dbName = "data/sql/SQLite/SQLaass.sqlite3";
    String url = String.format("jdbc:sqlite:%s", dbName);
    conn = DriverManager.getConnection(url, user, pass);
    return conn;
  }

  public static Connection getConnection() throws SQLException, ClassNotFoundException {
    if (conn != null && !conn.isClosed())
      return conn;
    P07ConnectDB.connect();
    return conn;

  }
}
