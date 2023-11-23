package sm.clagenna.loadaass.dbsql;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.enums.ETipoFatt;

public abstract class SqlServBase implements ISql {

  @Getter @Setter
  private TagValFactory       tagFactory;
  @Getter @Setter
  private DBConn              connSql;
  @Getter @Setter
  private ETipoFatt           tipoFatt;
  @Getter @Setter
  private RecIntesta          recIntesta;
  @Getter @Setter
  private Integer             idFattura;

  private static final String QRY_del_Fattura = ""   //
      + "DELETE  FROM %s WHERE idEEFattura = ?";

  public SqlServBase() {
    //
  }

  public SqlServBase(TagValFactory p_fact, DBConn p_con) {
    init(p_fact, p_con);
  }

  @Override
  public void init(TagValFactory p_fact, DBConn p_con) {
    tagFactory = p_fact;
    setConnSql(p_con);
    init();
  }

  public abstract void init();

  @Override
  public void deleteFattura() throws SQLException {
    String[] arrtabs = { "EEConsumo", "EELettura", "EEFattura" };
    Connection conn = getConnSql().getConn();
    int idFatt = getIdFattura();
    String qry = null;
    for (String tab : arrtabs) {
      qry = String.format(QRY_del_Fattura, tab);
      try (PreparedStatement stmt = conn.prepareStatement(qry)) {
        stmt.setInt(1, idFatt);
        int qtaDel = stmt.executeUpdate();
        getLog().debug("Cancellato {} righe da {}", qtaDel, tab);
      } catch (SQLException e) {
        getLog().error("Errore per stmt {}", qry, e);
      }
    }

  }

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
//    java.sql.Date dt = null;
    String szClsNam = vv != null ? vv.getClass().getSimpleName() : null;
    if (szClsNam == null || vv == null) {
      p_stmt.setNull(p_indxStmt, p_sqlType);
      return;
    }
    switch (szClsNam) {
      case "String":
        p_stmt.setString(p_indxStmt, vv.toString());
        break;
      case "Integer":
        p_stmt.setInt(p_indxStmt, (Integer) vv);
        break;
      case "Date":
//        if (vv instanceof java.util.Date) {
//          dt = new java.sql.Date( ((java.util.Date) vv).getTime());
//          p_stmt.setDate(p_indxStmt, dt);
//        } else
//          p_stmt.setDate(p_indxStmt, (java.sql.Date) vv);
        connSql.setStmtDate(p_stmt, p_indxStmt, (java.util.Date) vv);
        break;
      case "Double":
        p_stmt.setDouble(p_indxStmt, (Double) vv);
        break;
      case "BigDecimal":
        p_stmt.setBigDecimal(p_indxStmt, (BigDecimal) vv);
        break;
      case "Object":
        p_stmt.setNull(p_indxStmt, p_sqlType);
        break;
      default:
        getLog().error("Il campo {} ha tipo non riconosciuto \"{}\"", p_indxStmt, szClsNam);
        break;
    }
  }

}
