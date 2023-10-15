package sm.clagenna.loadaass.dbsql;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class SqlServIntest {

  private static final Logger s_log           = LogManager.getLogger(SqlServIntest.class);
  private static final String QRY_sel_intesta = ""                                        //
      + "SELECT idIntesta"                                                                //
      + "      ,NomeIntesta"                                                              //
      + "      ,dirfatture"                                                               //
      + "  FROM dbo.Intesta";

  public record RecIntesta(int idIntesta, String nome, Path dirFatture) {
    @Override
    public String toString() {
      return nome;
    }
  }

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
        RecIntesta rec = new RecIntesta(id, no, pth);
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
        .filter(s -> s.idIntesta == 1) //
        .collect(Collectors.toList());
    if (li != null && li.size() > 0)
      rec = li.get(0);
    return rec;
  }

}
