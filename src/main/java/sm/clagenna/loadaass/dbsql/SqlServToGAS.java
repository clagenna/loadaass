package sm.clagenna.loadaass.dbsql;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.TaggedValue;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.dbsql.SqlServIntest.RecIntesta;
import sm.clagenna.loadaass.enums.ETipoGASConsumo;
import sm.clagenna.loadaass.enums.ETipoLettProvvenienza;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class SqlServToGAS extends SqlServBase {

  private static final Logger s_log             = LogManager.getLogger(SqlServToGAS.class);

  private static final String QRY_ins_Fattura   = ""                                       //
      + "INSERT INTO GASFattura"                                                       //
      + "           (idIntesta"                                                            //
      + "           ,annoComp"                                                             //
      + "           ,DataEmiss"                                                            //
      + "           ,fattNrAnno"                                                           //
      + "           ,fattNrNumero"                                                         //
      + "           ,periodFattDtIniz"                                                     //
      + "           ,periodFattDtFine"                                                     //
      + "           ,periodCongDtIniz"                                                     //
      + "           ,periodCongDtFine"                                                     //
      + "           ,periodEffDtIniz"                                                      //
      + "           ,periodEffDtFine"                                                      //
      + "           ,periodAccontoDtIniz"                                                  //
      + "           ,periodAccontoDtFine"                                                  //
      + "           ,accontoBollPrec"                                                      //
      + "           ,addizFER"                                                             //
      + "           ,impostaQuiet"                                                         //
      + "           ,TotPagare)"                                                           //
      + "     VALUES (?,? ,? ,? ,?,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,?)";
  private PreparedStatement   m_stmt_ins_fattura;

  private static final String QRY_Fattura       = ""                                       //
      + "SELECT idGASFattura   FROM GASFattura"                                        //
      + " WHERE DataEmiss = ?" + "   AND idIntesta = ?";
  private PreparedStatement   m_stmt_cerca_fattura;

  private static final String QRY_ins_Lettura   = ""                                       //
      + "INSERT INTO GASLettura"                                                       //
      + "           (idGASFattura"                                                         //
      + "           ,lettQtaMc"                                                            //
      + "           ,LettData"                                                             //
      + "           ,TipoLett"                                                             //
      + "           ,Consumofatt)"                                                         //
      + "     VALUES (?,?,?,?,?)";                                                         //

  private PreparedStatement   m_stmt_ins_Lettura;

  private static final String QRY_cerca_Lettura = ""                                       //
      + "SELECT idLettura"                                                                 //
      + " FROM GASLettura"                                                             //
      + " WHERE idGASFattura = ?"                                                          //
      + " AND lettData = ?";                                                               //
  private PreparedStatement   m_stmt_cerca_Lettura;

  private static final String QRY_ins_Consumo   = "INSERT INTO GASConsumo"             //
      + "           (idGASFattura"                                                         //
      + "           ,tipoSpesa"                                                            //
      + "           ,dtIniz"                                                               //
      + "           ,dtFine"                                                               //
      + "           ,prezzoUnit"                                                           //
      + "           ,quantita"                                                             //
      + "           ,importo)"                                                             //
      + "     VALUES"                                                                      //
      + "           (?"                                                                    // <idGASFattura, int,>"
      + "           ,?"                                                                    // <tipoSpesa, nvarchar(2),>"
      + "           ,?"                                                                    // <dtIniz, date,>"
      + "           ,?"                                                                    // <dtFine, date,>"
      + "           ,?"                                                                    // <prezzoUnit, decimal(10,6),>"
      + "           ,?"                                                                    // <quantita, decimal(8,2),>"
      + "           ,?)";                                                                  // <importo, money,>)";
  private PreparedStatement   m_stmt_ins_Consumo;

  private static final String QRY_cerca_Consumo = ""                                       //
      + "SELECT idConsumo  "                                                               //
      + " FROM GASConsumo"                                                             //
      + " WHERE idGASFattura = ?"                                                          //
      + "  AND DtIniz = ?";
  private PreparedStatement   m_stmt_cerca_consumo;

  public SqlServToGAS() {
    //
  }

  public SqlServToGAS(TagValFactory p_fact, DBConn p_con) {
    super(p_fact, p_con);
  }

  @Override
  public void init() {
    Connection conn = getConnSql().getConn();
    try {
      m_stmt_cerca_fattura = conn.prepareStatement(QRY_Fattura);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", QRY_Fattura, e);
    }
    try {
      m_stmt_ins_fattura = conn.prepareStatement(QRY_ins_Fattura);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", QRY_ins_Fattura, e);
    }
    try {
      m_stmt_cerca_Lettura = conn.prepareStatement(QRY_cerca_Lettura);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", QRY_cerca_Lettura, e);
    }
    try {
      m_stmt_ins_Lettura = conn.prepareStatement(QRY_ins_Lettura);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", QRY_ins_Lettura, e);
    }
    try {
      m_stmt_cerca_consumo = conn.prepareStatement(QRY_cerca_Consumo);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", QRY_cerca_Consumo, e);
    }
    try {
      m_stmt_ins_Consumo = conn.prepareStatement(QRY_ins_Consumo);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", QRY_ins_Consumo, e);
    }
  }

  @Override
  public Logger getLog() {
    return s_log;
  }

  @Override
  public boolean fatturaExist() throws SQLException {
    Date dtEmiss = (Date) getValore(Consts.TGV_DataEmiss);
    // String sz = (String) getValore("FattNr");
    // String[] arr = sz.split("/");
    // int annoComp = Integer.parseInt(arr[0]);
    // String fattNumero = arr[1];

    int k = 1;
    RecIntesta reci = getRecIntesta();
    // m_stmt_cerca_fattura.set D a t e(k++, new java.sql.Date(dtEmiss.getTime()));
    DBConn conn = getConnSql();
    conn.setStmtDate(m_stmt_cerca_fattura, k++, dtEmiss);

    m_stmt_cerca_fattura.setInt(k++, reci.idIntesta());
    setIdFattura(null);
    try (ResultSet res = m_stmt_cerca_fattura.executeQuery()) {
      while (res.next()) {
        setIdFattura(res.getInt(1));

      }
    }
    return getIdFattura() != null;
  }

  @Override
  public boolean letturaExist() throws SQLException {
    java.sql.Date dtLett = getValoreDt(Consts.TGV_LettData, 0);
    if (dtLett == null)
      return false;
    int k = 1;
    int idLettura = -1;
    m_stmt_cerca_Lettura.setInt(k++, getIdFattura());
    // m_stmt_cerca_Lettura.set D a t e(k++, dtLett);
    DBConn conn = getConnSql();
    conn.setStmtDate(m_stmt_cerca_Lettura, k++, dtLett);

    try (ResultSet res = m_stmt_cerca_Lettura.executeQuery()) {
      while (res.next()) {
        idLettura = res.getInt(1);
      }
    }
    return idLettura >= 0;
  }

  @Override
  public boolean consumoExist() throws SQLException {
    Integer idFattura = getIdFattura();
    java.sql.Date dtIni = getValoreDt(Consts.TGV_periodoDa, 0);
    int idConsumo = -1;
    int k = 1;
    m_stmt_cerca_consumo.setInt(k++, idFattura);
    // m_stmt_cerca_consumo.set D a t e(k++, dtIni);
    DBConn conn = getConnSql();
    conn.setStmtDate(m_stmt_cerca_consumo, k++, dtIni);

    try (ResultSet res = m_stmt_cerca_consumo.executeQuery()) {
      while (res.next())
        idConsumo = res.getInt(1);
    }
    return idConsumo >= 0;
  }

  @Override
  public void insertNewFattura() throws SQLException {
    RecIntesta reci = getRecIntesta();
    Integer annoComp = null;
    java.sql.Date dataEmiss = null;
    Integer fattNrAnno = null;
    String fattNrNumero = null;
    BigDecimal impostaQuiet = new BigDecimal(0.36);
    Calendar cal = Calendar.getInstance();

    String sz = (String) getValore(Consts.TGV_FattNr);
    if (sz != null) {
      String[] arr = sz.split("/");
      fattNrAnno = Integer.parseInt(arr[0]);
      fattNrNumero = arr[1];
    }
    dataEmiss = getValoreDt(Consts.TGV_DataEmiss);
    if (fattNrAnno != null)
      annoComp = fattNrAnno;
    else {
      cal.setTime(dataEmiss);
      annoComp = cal.get(Calendar.YEAR);
    }

    int k = 1;
    
    /*
     *+ "           ,periodFattDtIniz"                                                     //
      + "           ,periodFattDtFine"                                                     //
      + "           ,periodCongDtIniz"                                                     //
      + "           ,periodCongDtFine"                                                     //
      + "           ,periodEffDtIniz"                                                      //
      + "           ,periodEffDtFine"                                                      //
      + "           ,periodAccontoDtIniz"                                                  //
      + "           ,periodAccontoDtFine"                                                  //

     */
    
    setVal(reci.idIntesta(), m_stmt_ins_fattura, k++, Types.INTEGER);
    setVal(annoComp, m_stmt_ins_fattura, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_DataEmiss, 0, k++, Types.DATE);
    setVal(fattNrAnno, m_stmt_ins_fattura, k++, Types.INTEGER);
    setVal(fattNrNumero, m_stmt_ins_fattura, k++, Types.VARCHAR);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodFattDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodFattDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodCongDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodCongDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodEffDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodEffDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodAccontoDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodAccontoDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_accontoBollPrec, 0, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_addizFER, 0, k++, Types.INTEGER);
    setVal(impostaQuiet, m_stmt_ins_fattura, k++, Types.DECIMAL);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_TotPagare, 0, k++, Types.DECIMAL);
    m_stmt_ins_fattura.executeUpdate();
    setIdFattura(getConnSql().getLastIdentity());
  }

  @Override
  public void insertNewLettura() throws SQLException {
    String szMsg = null;
    Integer idGASFattura = getIdFattura();

    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_TipoLett);
      @SuppressWarnings("unchecked") List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.warn("Sembra non ci siano letture di GAS!");
      return;
    }

    for (int riga = 0; riga < QtaRighe; riga++) {
      int k = 1;
      Object obj = getValore(Consts.TGV_TipoLett, riga);
      ETipoLettProvvenienza tp = ETipoLettProvvenienza.parse(obj.toString());
      if (tp == null) {
        szMsg = "GAS Letture, Non decodifico tipo lettura:" + obj;
        throw new SQLException(szMsg);
      }
      setVal(idGASFattura, m_stmt_ins_Lettura, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_lettQtaMc, riga, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_LettData, riga, k++, Types.DATE);
      setVal(tp.getSigla(), m_stmt_ins_Lettura, k++, Types.VARCHAR);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_Consumofatt, riga, k++, Types.DECIMAL);

      m_stmt_ins_Lettura.executeUpdate();
    }
    Object obj = getValore(Consts.TGV_DataEmiss);
    s_log.info("Inserito {} righe di lettura GAS per Fattura del {}", QtaRighe, TaggedValue.fmtData.format((Date) obj));

  }

  @Override
  public void insertNewConsumo() throws SQLException {
    Integer idGASFattura = null;
    ETipoGASConsumo tipoCausale = null;
    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_TipoCausale);
      @SuppressWarnings("unchecked") List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.warn("Sembra non ci siano righe di consumi di GAS!");
      return;
    }
    idGASFattura = getIdFattura();
    for (int riga = 0; riga < QtaRighe; riga++) {
      Object obj = getValore(Consts.TGV_TipoCausale, riga);
      tipoCausale = ETipoGASConsumo.parse(obj.toString());
      if (tipoCausale == null) {
        String szMsg = "GAS Consumi, Non decodifico causale consumo:" + obj;
        throw new SQLException(szMsg);
      }
      int k = 1;
      setVal(idGASFattura, m_stmt_ins_Consumo, k++, Types.INTEGER);
      setVal(tipoCausale.getSigla(), m_stmt_ins_Consumo, k++, Types.VARCHAR);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_periodoDa, riga, k++, Types.DATE);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_periodoA, riga, k++, Types.DATE);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_lettPrezzoU, riga, k++, Types.DECIMAL);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_LettQta, riga, k++, Types.DECIMAL);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_LettImp, riga, k++, Types.DECIMAL);

      m_stmt_ins_Consumo.executeUpdate();
    }
    Object obj = getValore(Consts.TGV_DataEmiss);
    s_log.info("Inserito {} righe di consumo GAS per Fattura del {}", QtaRighe, TaggedValue.fmtData.format((Date) obj));

  }

}
