package sm.clagenna.loadaass.dbsql;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.enums.EServerId;

public class DBConnSQL extends DBConn {

  private static final Logger s_log = LogManager.getLogger(DBConnSQL.class);

  //  private static final String CSZ_DBNAME  = "aass";
  //  private static final String CSZ_SQLUSER = "sqlgianni";
  //  private static final String CSZ_SQLPSWD = "sicuelserver";
  //  private static final int    CN_SERVICE  = 1433;

  // "com.microsoft.sqlserver.jdbc.SQLServerDriver"
  // "com.mysql.cj.jdbc.Driver";

  private static final String CSZ_DRIVER   = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
  private static final String CSZ_URL      = "jdbc:sqlserver://%s:%d;"                      //
      + "database=%s;"                                                                      //
      + "user=%s;"                                                                          //
      + "password=%s;"                                                                      //
      + "encrypt=false;"                                                                    //
      + "trustServerCertificate=false;"                                                     //
      + "loginTimeout=10;";
  private static final String QRY_LASTID   = "select @@identity";
  private static final String QRY_ALLVIEWS = ""                                             //
      + "SELECT name FROM sys.views";

  private PreparedStatement m_stmt_lastid;

  public DBConnSQL() {
    //
  }

  @Override
  public String getURL() {
    try {
      Class.forName(CSZ_DRIVER);
    } catch (ClassNotFoundException e) {
      s_log.error("Driver SQL Server \"{}\" not found", CSZ_DRIVER, e);
    }
    String szUrl = String.format(CSZ_URL, "localhost", //
        getService(), //
        getDbname(), //
        getUser(), //
        getPasswd());
    return szUrl;
  }

  @Override
  public EServerId getServerId() {
    return EServerId.SqlServer;
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

  @Override
  public void setStmtDate(PreparedStatement p_stmt, int p_index, Object p_dt) throws SQLException {
    java.sql.Date dt = null;
    if (p_dt instanceof java.sql.Date) {
      dt = (java.sql.Date) p_dt;
    } else if (p_dt instanceof java.util.Date) {
      java.util.Date udt = (java.util.Date) p_dt;
      dt = new java.sql.Date(udt.getTime());
    }
    if (dt != null)
      p_stmt.setDate(p_index, dt);
    else
      p_stmt.setNull(p_index, Types.DATE);
  }

  @Override
  public Logger getLog() {
    return s_log;
  }

  @Override
  public String getQueryListViews() {
    return QRY_ALLVIEWS;
  }
}
