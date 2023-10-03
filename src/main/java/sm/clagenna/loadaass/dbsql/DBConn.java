package sm.clagenna.loadaass.dbsql;

import java.io.Closeable;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import lombok.Getter;
import lombok.Setter;

public abstract class DBConn implements Closeable {

  public enum ServerID {
    SqlServer, HSqlDB
  }

  @Getter @Setter
  private String     host;
  @Getter @Setter
  private int        service;
  @Getter @Setter
  private String     dbname;
  @Getter @Setter
  private String     user;
  @Getter @Setter
  private String     passwd;
  @Getter
  private Connection conn;

  public DBConn() {
    //
  }

  public abstract String getURL();
  
  public abstract ServerID getServerId();

  public abstract int getLastIdentity() throws SQLException;

  public Connection doConn() {
    String szUrl = getURL();
    try {
      conn = DriverManager.getConnection(szUrl, user, passwd);
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return conn;
  }

  @Override
  public void close() throws IOException {
    try {
      if (conn != null)
        conn.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    conn = null;
  }

}
