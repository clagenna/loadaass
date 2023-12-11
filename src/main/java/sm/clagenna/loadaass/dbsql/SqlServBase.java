package sm.clagenna.loadaass.dbsql;

import java.math.BigDecimal;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.Valore;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.enums.ETipoFatt;
import sm.clagenna.loadaass.sys.ex.ReadFattSQLException;

public abstract class SqlServBase implements ISql {
  @Getter @Setter
  private Path          pdfFileName;
  @Getter @Setter
  private TagValFactory tagFactory;
  @Getter @Setter
  private DBConn        connSql;
  @Getter @Setter
  private ETipoFatt     tipoFatt;
  @Getter @Setter
  private RecIntesta    recIntesta;

  private List<Integer> listIdFattura;

  private static final String QRY_del_Fattura = "" //
      + "DELETE  FROM %s WHERE idEEFattura = ?";

  public SqlServBase() {
    //
  }

  public SqlServBase(TagValFactory p_fact, DBConn p_con, Path p_pdf) {
    this.init(p_fact, p_con, p_pdf);
  }

  @Override
  public void init(TagValFactory p_fact, DBConn p_con, Path p_pdf) {
    tagFactory = p_fact;
    setConnSql(p_con);
    setPdfFileName(p_pdf);
    init();
  }

  public abstract void init();

  public List<Integer> getListFatture() {
    return listIdFattura;
  }

  protected boolean existFattDaCancellare() {
    if (listIdFattura == null || listIdFattura.size() == 0)
      return false;
    return true;
  }

  @Override
  public void deleteFattura() throws SQLException {
    String tpf = tipoFatt.getTitolo();
    if (listIdFattura == null || listIdFattura.size() == 0) {
      getLog().warn("Nessuna fattura {} da cancellale", tpf);
      return;
    }
    String[] arrtabs = { "Consumo", "Lettura", "Fattura" };
    Connection conn = getConnSql().getConn();

    String qry = null;
    for (Integer iidFatt : listIdFattura) {
      for (String tab : arrtabs) {
        String nomeTab = tpf + tab;
        qry = String.format(QRY_del_Fattura, nomeTab);
        try (PreparedStatement stmt = conn.prepareStatement(qry)) {
          stmt.setInt(1, iidFatt);
          int qtaDel = stmt.executeUpdate();
          getLog().debug("Cancellato {} righe da {}", qtaDel, nomeTab);
        } catch (SQLException e) {
          getLog().error("Errore per stmt {}", qry, e);
        }
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

  public void clearIdFattura() {
    if (listIdFattura != null)
      listIdFattura.clear();
    listIdFattura = null;
  }

  public void addIdFattura(Integer p_id) {
    if (listIdFattura == null)
      listIdFattura = new ArrayList<>();
    if ( !listIdFattura.contains(p_id))
      listIdFattura.add(p_id);
  }

  public Integer getIdFattura() throws ReadFattSQLException {
    if (listIdFattura == null || listIdFattura.size() == 0)
      throw new ReadFattSQLException("Non ci sono idFattura!");
    if (listIdFattura.size() > 1)
      throw new ReadFattSQLException("Ci sono troppe idFattura!");
    return listIdFattura.get(0);
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

  /**
   * Va a verificare se il {@link Valore#isStimato(int)} alla riga {riga} ha
   * impostato il flag di <b>Stimato</b> e lo imposta sullo statement
   *
   * @param p_stmt
   *          statement della query
   * @param p_tgvf
   *          il nome del campo {@ValoreByTag}
   * @param riga
   *          riga del array da testare
   * @param p_indxStmt
   *          numero della colonna all'interno dello statement
   * @param p_sqlType
   *          typo SQL da aggiornare
   * @throws SQLException
   */
  protected void setStimato(PreparedStatement p_stmt, String p_tgvf, int riga, int p_indxStmt, int p_sqlType) throws SQLException {
    ValoreByTag vtag = getTagFactory().get(p_tgvf);
    if (vtag == null) {
      getLog().error("Non esiste il campo \"{}\"", p_tgvf);
      return;
    }
    int bv = vtag.isStimato(riga) ? 1 : 0;
    setVal(bv, p_stmt, p_indxStmt, p_sqlType);
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
        connSql.setStmtDate(p_stmt, p_indxStmt, vv);
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
