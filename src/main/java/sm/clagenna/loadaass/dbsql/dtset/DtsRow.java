package sm.clagenna.loadaass.dbsql.dtset;

import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.dbsql.dtset.DtsCols.DtsCol;
import sm.clagenna.loadaass.sys.ParseData;
import sm.clagenna.loadaass.sys.ex.DatasetException;

public class DtsRow {
  private static final Logger s_log = LogManager.getLogger(DtsRow.class);
  private List<Object>        valori;
  private Dataset             dataset;
  private ParseData           parsedt;

  public DtsRow(Dataset p_dts) throws DatasetException {
    dataset = p_dts;
    List<Object> li = Collections.nCopies(dataset.getQtaCols(), (Object) null);
    valori = new ArrayList<>(li);
    if (dataset.getTipoServer().isDateAsString())
      parsedt = new ParseData();
  }

  public void addRow(ResultSet p_res) throws DatasetException {
    for (DtsCol col : dataset.getColumns()) {
      int nCol = col.getIndex() + 1;
      Object val = null;
      try {
        switch (col.getType()) {
          case NCHAR:
          case VARCHAR:
          case CHAR:
            val = p_res.getString(nCol);
            if (dataset.getTipoServer().isDateAsString())
              val = provaSeData(val);
            break;

          case BIGINT:
          case INTEGER:
          case SMALLINT:
          case TINYINT:
            val = p_res.getInt(nCol);
            break;
          case FLOAT:
            val = p_res.getFloat(nCol);
            break;
          case DOUBLE:
            val = p_res.getDouble(nCol);
            break;
          case DATE:
            val = p_res.getDate(nCol);
            break;
          case TIMESTAMP:
            val = p_res.getTimestamp(nCol);
            break;
          case REAL:
            val = p_res.getDouble(nCol);
            break;

          default:
            s_log.error("Non riconosco tipo della col {}", col);
        }
      } catch (Exception e) {
        String szMsg = String.format("Errore in lettura col \"%s\" con err=%s", col, e.getMessage());
        s_log.error(szMsg, e);
        throw new DatasetException(szMsg, e);
      }
      valori.set(nCol - 1, val);
    }
  }

  private Object provaSeData(Object p_val) {
    if (p_val == null)
      return p_val;
    String szVal = p_val.toString();
    LocalDateTime dt = parsedt.parseData(szVal);
    if (dt != null) {
      p_val = java.sql.Timestamp.valueOf(dt);
      s_log.trace("Convertito {} in Timestamp {}", szVal, ParseData.s_fmtDtExif.format(dt));
    }
    return p_val;
  }

  public void addVal(String p_nam, Object p_v) {
    int nCol = dataset.getColumNo(p_nam);
    valori.set(nCol - 1, p_v);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    for (DtsCol col : dataset.getColumns()) {
      Object vv = valori.get(col.getIndex());
      String szv = "*null*";
      if (vv != null)
        szv = String.format(col.getFormat(), vv);
      sb.append(szv).append(" ");
    }
    return sb.toString();
  }
}
