package sm.clagenna.loadaass.dbsql;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnSQL extends DBConn {

  private static final String CSZ_DBNAME = "aass";
  private static final String CSZ_SQLUSER = "sqlgianni";
  private static final String CSZ_SQLPSWD = "sicuelserver";
  @SuppressWarnings("unused")
  private static final String CSZ_DRIVER = "com.mysql.cj.jdbc.Driver";
  private static final String CSZ_URL    = "jdbc:sqlserver://%s:%d;"   //
      + "database=%s;"                                                 //
      + "user=%s;"                                                     //
      + "password=%s;"                                                 //
      + "encrypt=false;"                                               //
      + "trustServerCertificate=false;"                                //
      + "loginTimeout=10;";
  private static final int    CN_SERVICE = 1433;
  // private static final String QRY_LASTID = "select scope_identity()";
  private static final String QRY_LASTID = "select @@identity";
  private PreparedStatement   m_stmt_lastid;

  public DBConnSQL() {
    //    if (s_inst != null)
    //      throw new UnsupportedOperationException("DBConn gia istanziata");
    //    s_inst = this;
  }

  @Override
  public String getURL() {
    String szUrl = String.format(CSZ_URL, "localhost", //
        CN_SERVICE, //
        CSZ_DBNAME, //
        CSZ_SQLUSER, //
        CSZ_SQLPSWD);
    return szUrl;
  }

  @Override
  public ServerID getServerId() {
    return ServerID.SqlServer;
  }

  @Override
  public int getLastIdentity() throws SQLException {
    if (getConn() == null)
      throw new SQLException("No connection yet");
    if (m_stmt_lastid == null)
      m_stmt_lastid = getConn().prepareStatement(QRY_LASTID);
    int retId = -1;
    try (ResultSet res = m_stmt_lastid.executeQuery()) {
      while (res.next()) {
        retId = res.getInt(1);
      }
    }
    return retId;
  }

  @Override
  public void close() throws IOException {
    try {
      if (m_stmt_lastid != null)
        m_stmt_lastid.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    m_stmt_lastid = null;
    super.close();
  }
}
