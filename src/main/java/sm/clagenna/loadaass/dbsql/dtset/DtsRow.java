package sm.clagenna.loadaass.dbsql.dtset;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.data.MyDate;
import sm.clagenna.loadaass.data.MyDouble;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.sys.ParseData;
import sm.clagenna.loadaass.sys.ex.DatasetException;

public class DtsRow {
  private static final Logger     s_log     = LogManager.getLogger(DtsRow.class);
  private static SimpleDateFormat s_fmtY4MD = new SimpleDateFormat("yyyy-MM-dd");
  private List<Object>            valori;
  private Dataset                 dataset;
  private ParseData               parsedt;

  public DtsRow(Dataset p_dts) throws DatasetException {
    dataset = p_dts;
    List<Object> li = Collections.nCopies(dataset.getQtaCols(), (Object) null);
    valori = new ArrayList<>(li);
    if (dataset.getTipoServer().isDateAsString())
      parsedt = new ParseData();
  }

  public void addRow(ResultSet p_res) throws DatasetException {
    for (DtsCol col : dataset.getColumns().getColumns()) {
      int nCol = col.getIndex() + 1;
      Object val = null;
      try {
        switch (col.getType()) {
          case NCHAR:
          case NVARCHAR:
          case VARCHAR:
          case LONGVARCHAR:
          case CHAR:
            val = p_res.getString(nCol);
            if (val != null && dataset.getTipoServer().isDateAsString()) {
              val = provaSeData(val);
              col.setInferredDate(val != null);
            }
            break;

          case BIGINT:
          case INTEGER:
          case SMALLINT:
          case TINYINT:
            val = p_res.getInt(nCol);
            break;
          case DECIMAL:
            val = MyDouble.valueOf(p_res.getDouble(nCol));
            break;
          case FLOAT:
            val = MyDouble.valueOf(p_res.getFloat(nCol));
            break;
          case DOUBLE:
            val = MyDouble.valueOf(p_res.getDouble(nCol));
            break;
          case DATE:
            DBConn ldb = dataset.getDb();
            val = ldb.getDate(p_res, nCol);
            val = MyDate.valueOf((Date) val);
            break;
          case TIMESTAMP:
            val = p_res.getTimestamp(nCol);
            if (val instanceof Timestamp ts)
              val = new MyDate(ts);
            break;
          case REAL:
            val = MyDouble.valueOf(p_res.getDouble(nCol));
            break;
          case NUMERIC:
            val = MyDouble.valueOf(p_res.getDouble(nCol));
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
      // s_log.trace("Convertito {} in Timestamp {}", szVal, ParseData.s_fmtDtExif.format(dt));
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
    for (DtsCol col : dataset.getColumns().getColumns()) {
      Object vv = valori.get(col.getIndex());
      String szv = String.format(DtsCols.getColFmtL(), "*null*");
      if (vv != null) {
        //        if (vv instanceof LocalDateTime) {
        //          szv = ParseData.s_fmtDtExif.format((TemporalAccessor) vv);
        //          szv = szv.replace(" 00:00:00", "");
        //        } else
        //          szv = String.format(col.getFormat(), vv);
        //
        //        szv = switch ( vv) {
        //          case Integer i ->  String.format(col.getFormat(), i);
        //          case Timestamp ts -> ParseData.s_fmtDtExif.format(ts.toInstant());
        //          default String.format(col.getFormat(), vv);
        //        };
        String szClss = vv != null ? vv.getClass().getSimpleName() : "Object";
        switch (szClss) {

          case "LocalDateTime":
            szv = ParseData.s_fmtDtExif.format((LocalDateTime) vv);
            szv = szv.replace(" 00:00:00", "");
            szv = String.format(DtsCols.getColFmtR(), szv);
            break;

          case "Timestamp":
            szv = ParseData.s_fmtDtDate.format((Timestamp) vv);
            szv = szv.replace(" 00:00:00", "");
            szv = String.format(DtsCols.getColFmtR(), szv);
            break;

          default:
            szv = String.format(col.getFormat(), vv);
            break;
        }

      }
      sb.append(szv);
    }
    return sb.toString();
  }

  public Object getValue(String p_colNam) {
    DtsCols cols = dataset.getColumns();
    int indx = cols.getColIndex(p_colNam);
    return valori.get(indx);
  }

  public List<Object> getValues() {
    return valori;
  }

  public List<Object> getValues(boolean bEdit) {
    if ( !bEdit)
      return valori;
    List<Object> loc = new ArrayList<Object>();
    for (Object o : valori) {
      Object ret = o;
      String szcls = null != o ? o.getClass().getSimpleName() : "*NULL*";
      switch (szcls) {
        case "Timestamp":
          ret = s_fmtY4MD.format(o);
          break;
        default:
          break;
      }
      // String sz = null != o ? o.toString() : "";
      // System.out.printf("DtsRow.getValues([%s]=\"%s\")\n", szcls, sz);
      loc.add(ret);
    }
    return loc;
  }
}
