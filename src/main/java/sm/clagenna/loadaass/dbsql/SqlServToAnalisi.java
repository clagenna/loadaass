package sm.clagenna.loadaass.dbsql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.data.EsSang;
import sm.clagenna.stdcla.sql.DBConn;

public class SqlServToAnalisi extends SqlServBase {
  private static final Logger s_log         = LogManager.getLogger(SqlServToAnalisi.class);
  private static final String QRY_ins_esame = ""                                           //
      + "INSERT INTO dbo.EsamiSangue"                                                      //
      + "           (codiss"                                                               //
      + "           ,dtExam"                                                               //
      + "           ,esame"                                                               //
      + "           ,esito"                                                                //
      + "           ,unMisura"                                                             //
      + "           ,valRifMin"                                                            //
      + "           ,valRifMax"                                                            //
      + "           ,valMinMax"                                                            //
      + "           ,allarme)"                                                             //
      + "     VALUES"                                                                      //
      + "           (?"                                                                    //
      + "           ,?"                                                                    //
      + "           ,?"                                                                    //
      + "           ,?"                                                                    //
      + "           ,?"                                                                    //
      + "           ,?"                                                                    //
      + "           ,?"                                                                    //
      + "           ,?"                                                                    //
      + "           ,?)";
  private PreparedStatement   m_stmt_ins_esame;
  private static final String QRY_sel_esame = ""                                           //
      + "SELECT COUNT(*)"                                                                  //
      + "  FROM dbo.EsamiSangue"                                                           //
      + "  WHERE codiss = ?"                                                               //
      + "    AND dtExam = ?";
  private PreparedStatement   m_stmt_sel_esame;
  private static final String QRY_del_esame = ""                                           //
      + "DELETE  FROM dbo.EsamiSangue"                                                     //
      + "  WHERE codiss = ?"                                                               //
      + "    AND dtExam = ?";
  private PreparedStatement   m_stmt_del_esame;

  @Override
  public Logger getLog() {
    return s_log;
  }

  @Override
  public void init() {
    Connection conn = getConnSql().getConn();
    String szQry = null;
    try {
      szQry = QRY_ins_esame;
      m_stmt_ins_esame = conn.prepareStatement(szQry);

      szQry = QRY_sel_esame;
      m_stmt_sel_esame = conn.prepareStatement(QRY_sel_esame);

      szQry = QRY_del_esame;
      m_stmt_del_esame = conn.prepareStatement(QRY_del_esame);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", szQry, e);
    }
  }

  public int esameExist(EsSang es) throws SQLException {
    int k = 1;
    int nRet = -1;
    DBConn conn = getConnSql();
    m_stmt_sel_esame.setInt(k++, es.getCodiss());
    conn.setStmtDate(m_stmt_sel_esame, k++, es.getDtExam());
    try (ResultSet res = m_stmt_sel_esame.executeQuery()) {
      while (res.next()) {
        nRet = res.getInt(1);
      }
    }
    return nRet;
  }

  public int esameDelete(EsSang es) throws SQLException {
    int k = 1;
    int nRet = -1;
    DBConn conn = getConnSql();
    m_stmt_del_esame.setInt(k++, es.getCodiss());
    conn.setStmtDate(m_stmt_del_esame, k++, es.getDtExam());
    nRet = m_stmt_del_esame.executeUpdate();
    return nRet;
  }

  public void esameInsert(EsSang es) throws SQLException {
    int k = 1;
    DBConn conn = getConnSql();
    conn.setStmtInt(m_stmt_ins_esame, k++, es.getCodiss());
    conn.setStmtDate(m_stmt_ins_esame, k++, es.getDtExam());
    conn.setStmtString(m_stmt_ins_esame, k++, es.getEsame());
    conn.setStmtDouble(m_stmt_ins_esame, k++, es.getEsito());
    conn.setStmtString(m_stmt_ins_esame, k++, es.getUnMisura());
    conn.setStmtDouble(m_stmt_ins_esame, k++, es.getValRifMin());
    conn.setStmtDouble(m_stmt_ins_esame, k++, es.getValRifMax());
    conn.setStmtString(m_stmt_ins_esame, k++, es.getValMinMax());
    conn.setStmtInt(m_stmt_ins_esame, k++, es.isAlarme() ? 1 : 0);
    m_stmt_ins_esame.executeUpdate();
  }

  @Override
  public boolean fatturaExist() throws SQLException {
    //
    return false;
  }

  @Override
  public boolean letturaExist() throws SQLException {
    return false;
  }

  @Override
  public boolean consumoExist() throws SQLException {
    return false;
  }

  @Override
  public void insertNewFattura() throws SQLException {
    //
  }

  @Override
  public void insertNewLettura() throws SQLException {
    //
  }

  @Override
  public void insertNewConsumo() throws SQLException {
    // TODO Auto-generated method stub

  }

}
