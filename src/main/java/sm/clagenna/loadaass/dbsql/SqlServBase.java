package sm.clagenna.loadaass.dbsql;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import org.apache.logging.log4j.Logger;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.ValoreByTag;

public abstract class SqlServBase {

  @Getter @Setter
  private TagValFactory tagFactory;
  @Getter @Setter
  private DBConn        connSql;

  public SqlServBase() {
    //
  }

  public SqlServBase(TagValFactory p_fact, DBConn p_con) {
    tagFactory = p_fact;
    setConnSql(p_con);
    init();
  }

  protected abstract void init();

  protected abstract Logger getLog();

  public Object getValore(String fldNam) {
    return getValore(fldNam, 0);
  }

  public Object getValore(String fldNam, int nRow) {
    ValoreByTag vtag = getTagFactory().get(fldNam);
    Object vv = null;
    vv = vtag.getValoreNoEx(nRow);
    return vv;
  }

  public java.sql.Date getValoreDt(String fldNam) {
    return getValoreDt(fldNam, 0);
  }

  public java.sql.Date getValoreDt(String fldNam, int nRow) {
    Object obj = getValore(fldNam, nRow);
    if (obj == null)
      return null;
    java.util.Date dtu = (Date) obj;
    java.sql.Date dtq = new java.sql.Date(dtu.getTime());
    return dtq;
  }

  protected void setValTgv(PreparedStatement p_stmt, String p_tgvf, int riga, int p_indxStmt, int p_sqlType) throws SQLException {
    ValoreByTag vtag = getTagFactory().get(p_tgvf);
    if (vtag == null) {
      getLog().error("Non esiste il campo \"{}\"", p_tgvf);
      return;
    }
    Object vv = vtag.getValoreNoEx(riga);
    setVal(vv, p_stmt, p_indxStmt, p_sqlType);
  }

  protected void setVal(Object vv, PreparedStatement p_stmt, int p_indxStmt, int p_sqlType) throws SQLException {
    String szClsNam = vv != null ? vv.getClass().getSimpleName() : null;
    if (szClsNam == null) {
      p_stmt.setNull(p_indxStmt, p_sqlType);
      return;
    }
    switch (szClsNam) {
      case "String":
        p_stmt.setString(p_indxStmt, vv.toString());
        break;
      case "Date":
        p_stmt.setDate(p_indxStmt, (java.sql.Date) vv);
        break;
      case "Double":
        p_stmt.setDouble(p_indxStmt, (Double) vv);
        break;
      case "BigDecimal":
        p_stmt.setBigDecimal(p_indxStmt, (BigDecimal) vv);
        break;
      default:
        getLog().error("Il campo {} non ha tipo riconosciuto \"{}\"", p_indxStmt, szClsNam);
        break;
    }
  }

}
