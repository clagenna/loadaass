package sm.clagenna.loadaass.dbsql;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.OptionalInt;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.data.RecIntesta;

public class SqlServIntest {

  private static final Logger s_log           = LogManager.getLogger(SqlServIntest.class);
  private static final String QRY_sel_intesta = ""                                        //
      + "SELECT idIntesta"                                                                //
      + "      ,NomeIntesta"                                                              //
      + "      ,dirfatture"                                                               //
      + "  FROM Intesta";
  private static final String QRY_upd_intesta = ""                                        //
      + "UPDATE intesta SET "                                                             //
      + " NomeIntesta=?"                                                                  //
      + " ,dirfatture=?"                                                                  //
      + " WHERE  idIntesta=?";
  private static final String QRY_ins_intesta = ""                                        //
      + "INSERT INTO dbo.Intesta"                                                         //
      + " (idIntesta"                                                                     //
      + " ,NomeIntesta"                                                                   //
      + " ,dirfatture)"                                                                   //
      + " VALUES ( ?, ?, ? )";

  //  public record RecIntesta(int idIntesta, String nome, Path dirFatture) {
  //    @Override
  //    public String toString() {
  //      return nome;
  //    }
  //  }

  private Map<String, RecIntesta> m_map;
  private DBConn                  connSql;

  public SqlServIntest(DBConn p_conn) {
    connSql = p_conn;
    readIntesta();
  }

  private void readIntesta() {
    m_map = new TreeMap<>(String.CASE_INSENSITIVE_ORDER);
    Connection conn = connSql.getConn();
    try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(QRY_sel_intesta)) {
      while (rs.next()) {
        int id = rs.getInt(1);
        String no = rs.getString(2);
        Path pth = Paths.get(rs.getString(3));
        RecIntesta rec = new RecIntesta(id, no, pth.toString());
        m_map.put(no, rec);
      }
    } catch (SQLException e) {
      s_log.error("Query dbo.intesta; err={}", e.getMessage(), e);
    }
  }

  public RecIntesta get(String nome) {
    return m_map.get(nome);
  }

  public List<RecIntesta> getList() {
    return new ArrayList<RecIntesta>(m_map.values());
  }

  public RecIntesta get(int p_i) {
    RecIntesta rec = null;
    List<RecIntesta> li = getList() //
        .stream() //
        .filter(s -> s.getIdIntestaInt() == 1) //
        .collect(Collectors.toList());
    if (li != null && li.size() > 0)
      rec = li.get(0);
    return rec;
  }

  public int addNewRec(RecIntesta p_newRec) {
    int nRet = 0;
    OptionalInt omaxid = getList() //
        .stream() //
        .mapToInt(r -> r.getIdIntestaInt()) //
        .max();
    int maxId = omaxid.getAsInt() + 1;
    p_newRec.setIdIntestaInt(maxId);
    m_map.put(p_newRec.getIdIntesta(), p_newRec);
    Connection conn = connSql.getConn();
    int k = 1;
    try (PreparedStatement stmt = conn.prepareStatement(QRY_ins_intesta)) {
      stmt.setInt(k++, p_newRec.getIdIntestaInt());
      stmt.setString(k++, p_newRec.getNomeIntesta());
      stmt.setString(k++, p_newRec.getDirFatture());
      nRet = stmt.executeUpdate();
      s_log.debug("ret code={} for Insert", k);
    } catch (SQLException e) {
      s_log.error("Errore insert di {}, err={}", p_newRec.getNomeIntesta(), e.getMessage(), e);
    }
    return k;
  }

  public boolean isValidRecord(RecIntesta p_newRec) {
    boolean bRet = false;
    bRet = !m_map.containsKey(p_newRec.getNomeIntesta());
    return bRet;
  }

  public int saveUpdates() {
    int nRet = 0;
    Connection conn = connSql.getConn();
    List<RecIntesta> li = getList();
    for (RecIntesta rec : li) {
      if ( !rec.isChanged())
        continue;
      int k = 1;
      try (PreparedStatement stmt = conn.prepareStatement(QRY_upd_intesta)) {
        stmt.setString(k++, rec.getNomeIntesta());
        stmt.setString(k++, rec.getDirFatture());
        stmt.setInt(k++, rec.getIdIntestaInt());
        int ret = stmt.executeUpdate();
        nRet += ret;
        s_log.debug("ret code={} for updates", ret);
        if (ret == 1)
          rec.setChanged(false);
      } catch (SQLException e) {
        s_log.error("Errore update di {}, err={}", rec.getNomeIntesta(), e.getMessage(), e);
      }
    }
    return nRet;
  }

}
