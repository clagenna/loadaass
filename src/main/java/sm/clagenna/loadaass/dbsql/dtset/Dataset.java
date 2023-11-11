package sm.clagenna.loadaass.dbsql.dtset;

import java.io.Closeable;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.enums.EServerId;
import sm.clagenna.loadaass.sys.ex.DatasetException;

public class Dataset implements IDataset, Closeable {
  private static final Logger       s_log = LogManager.getLogger(Dataset.class);
  @Getter @Setter private EServerId tipoServer;
  private DtsCols                   columns;
  @Getter @Setter private DBConn    db;

  @Getter private List<DtsRow> righe;
  private int                  nCurrRow;

  public Dataset() {
    setTipoServer(EServerId.SqlServer);
  }

  public Dataset(EServerId p_serverId) {
    setTipoServer(p_serverId);
  }

  public Dataset(DBConn p_con) {
    setDb(p_con);
    setTipoServer(p_con.getServerId());
  }

  public boolean executeQuery(String p_qry) {
    boolean bRet = false;
    nCurrRow = 0;
    Connection conn = db.getConn();
    try (PreparedStatement stmt = conn.prepareStatement(p_qry); //
        ResultSet res = stmt.executeQuery()) {
      creaCols(stmt);
      addRows(res);
      bRet = true;
    } catch (SQLException | DatasetException e) {
      s_log.error("Error execute Query, err={}", e.getMessage());
    }
    return bRet;
  }

  public void creaCols(PreparedStatement p_stmt) throws DatasetException {
    columns = new DtsCols(this);
    columns.parseColsStatement(p_stmt);
  }

  public int addRows(ResultSet p_stmt) throws DatasetException {
    int nRet = -1;
    try {
      while (p_stmt.next()) {
        DtsRow row = new DtsRow(this);
        row.addRow(p_stmt);
//        if (s_log.isTraceEnabled()) {
//          System.out.printf("%s\n%s\n", columns.getIntestazione(), row.toString());
//        }
        addRow(row);
      }
      if (righe != null)
        nRet = righe.size();
    } catch (SQLException e) {
      s_log.error("Errore in addRow(resultset), msg={}", e.getMessage());
      throw new DatasetException("Errore in addRow(resultset)", e);
    }
    return nRet;
  }

  public int addRow(DtsRow p_r) {
    if (righe == null)
      righe = new ArrayList<>();
    righe.add(p_r);
    return righe.size();
  }

  public int getQtaCols() throws DatasetException {
    return columns.size();
  }

  @Override
  public DtsCols getColumns() {
    return columns;
  }

  public int getColumNo(String p_nam) {
    return columns.getColIndex(p_nam);
  }

  @Override
  public void close() throws IOException {
    //
  }

  public void clear() {
    righe.clear();
    righe = null;
  }

  @Override
  public void restart() {
    nCurrRow = 0;
  }

  @Override
  public DtsRow getRow() {
    return righe.get(nCurrRow);
  }

  @Override
  public boolean hasNext() {
    return nCurrRow < righe.size();
  }

  @Override
  public int next() {
    if (nCurrRow < righe.size() - 1)
      nCurrRow++;
    return nCurrRow;
  }

  @Override
  public Object getValue(String p_colNam) {
    DtsRow riga = getRow();
    return riga.getValue(p_colNam);
  }

  @Override
  public int getRowNumber() {
    return nCurrRow;
  }

}
