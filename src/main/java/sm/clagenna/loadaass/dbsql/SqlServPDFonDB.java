package sm.clagenna.loadaass.dbsql;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.stdcla.sql.DBConn;

public class SqlServPDFonDB {
  private static final Logger s_log        = LogManager.getLogger(SqlServPDFonDB.class);
  private static final String QRY_sel_pdfs = ""                                         //
      + "SELECT nomeFile FROM ("                                                        //
      + " SELECT idIntesta,nomeFile FROM EEFattura WHERE nomeFile IS NOT NULL"          //
      + " UNION "                                                                       //
      + " SELECT idIntesta,nomeFile FROM GASFattura WHERE nomeFile IS NOT NULL"         //
      + " UNION "                                                                       //
      + " SELECT idIntesta,nomeFile FROM H2OFattura WHERE nomeFile IS NOT NULL"         //
      + " ) WHERE idIntesta=?";
  private Integer             idIntesta;
  private List<String>        liPdfs;
  private DBConn              connSQL;

  public SqlServPDFonDB(DBConn p_conn) {
    connSQL = p_conn;
  }

  public void aggiornaPdfs(Integer p_idIntesta) {
    if (p_idIntesta == null || p_idIntesta.equals(idIntesta))
      return;
    // System.out.println("SqlServPDFonDB.aggiornaPdfs()="+p_idIntesta);
    idIntesta = p_idIntesta;
    if (liPdfs != null)
      liPdfs.clear();
    liPdfs = new ArrayList<>();
    Connection conn = connSQL.getConn();
    String szQry = QRY_sel_pdfs.replace("?", String.valueOf(idIntesta));
    try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(szQry)) {
      while (rs.next()) {
        // vedi https://mattryall.net/blog/the-infamous-turkish-locale-bug
        String fil = rs.getString(1).toLowerCase(Locale.ITALY);
        liPdfs.add(fil);
      }
    } catch (SQLException e) {
      s_log.error("Query sel Pdfs; err={}", e.getMessage(), e);
    }
  }

  public boolean contains(String p_pdf) {
    if (p_pdf == null || liPdfs == null)
      return false;
    // vedi https://mattryall.net/blog/the-infamous-turkish-locale-bug
    return liPdfs.contains(p_pdf.toLowerCase(Locale.ITALIAN));
  }

}
