package sm.clagenna.loadaass.dbsql;

import java.io.IOException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.sqlite.SQLiteConfig;
import org.sqlite.SQLiteConfig.Pragma;

import sm.clagenna.loadaass.enums.EServerId;
import sm.clagenna.loadaass.sys.ParseData;
import sm.clagenna.loadaass.sys.Utils;

public class DBConnSQLite extends DBConn {
  private static final Logger s_log = LogManager.getLogger(DBConnSQLite.class);
  // private static final String CSZ_DBNAME = "data/sql/SQLite/SQLaass.sqlite3";
  private static final String CSZ_URL = "jdbc:sqlite:%s";

  private static final String QRY_LASTID = "select last_insert_rowid()";
  private PreparedStatement   m_stmt_lastid;

  public DBConnSQLite() {
    //    if (s_inst != null)
    //      throw new UnsupportedOperationException("DBConn gia istanziata");
    //    s_inst = this;
  }

  @Override
  public String getURL() {
    String szUrl = String.format(CSZ_URL, getDbname());
    return szUrl;
  }

  @Override
  public EServerId getServerId() {
    return EServerId.SQLite;
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
  public void changePragma() {
    SQLiteConfig conf = new SQLiteConfig();
    Properties prop = conf.toProperties();
    prop.setProperty(Pragma.DATE_STRING_FORMAT.pragmaName, "yyyy-MM-dd");
  }

  /**
   * SQLite preferisce le date in
   * <a href="https://en.wikipedia.org/wiki/ISO_8601}">ISO 8601 Date Format</a>
   * e Data Type <code>String</code>. Per la discussione sul formato delle date
   * in SQLite3 <a href="https://github.com/xerial/sqlite-jdbc/issues/88">vedi
   * il sito GitHub</a> <br/>
   * per un elenco delle funzioni in SQLite
   * <a href="https://sqlite.org/lang_datefunc.html">vedere sito SQLite</a><br/>
   *
   * @param p_stmt
   *          lo statement SQl su cui applicare il valore
   * @param p_index
   *          index della colonna nello statement
   * @param p_dt
   *          il valore da settare
   *
   * @see <a href="https://en.wikipedia.org/wiki/ISO_8601}">ISO 8601 Date
   *      Format</a>
   * @see <a href="https://sqlite.org/datatype3.html">SQLite data Types</a>
   */
  @Override
  public void setStmtDate(PreparedStatement p_stmt, int p_index, Object p_dt) throws SQLException {
    // String sz = Utils.s_fmtY4MD.format(p_dt);
    // String sz = Utils.s_fmtY4MDHMS.format(p_dt);
    // p_stmt.setString(p_index, sz);
    java.sql.Date dt = null;
    if (p_dt instanceof java.sql.Date) {
      dt = (java.sql.Date) p_dt;
    } else if (p_dt instanceof java.util.Date) {
      java.util.Date udt = (java.util.Date) p_dt;
      dt = new java.sql.Date(udt.getTime());
    }
    if (dt != null) {
      String sz = Utils.s_fmtY4MD.format(dt);
      p_stmt.setString(p_index, sz);
    }
  }

  @Override
  public Date getDate(ResultSet p_res, int nCol) throws SQLException {
    Date dtRet = null;
    String sz = p_res.getString(nCol);
    if (sz == null)
      return dtRet;
    ParseData pdt = new ParseData();
    LocalDateTime ldt = pdt.parseData(sz);
    dtRet = java.sql.Date.valueOf(ldt.toLocalDate());
    return dtRet;
  }

  @Override
  public Logger getLog() {
    return s_log;
  }
}
