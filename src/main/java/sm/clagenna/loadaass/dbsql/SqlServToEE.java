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

import sm.clagenna.loadaass.data.ETipoEEConsumo;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.TaggedValue;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.dbsql.SqlServIntest.RecIntesta;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class SqlServToEE extends SqlServBase {

  private static final Logger s_log             = LogManager.getLogger(SqlServToEE.class);

  private static final String QRY_ins_Fattura   = ""                                      //
      + "INSERT INTO dbo.EEFattura"                                                       //
      + "           (idIntesta"                                                           //
      + "           ,annoComp"                                                            //
      + "           ,DataEmiss"                                                           //
      + "           ,fattNrAnno"                                                          //
      + "           ,fattNrNumero"                                                        //
      + "           ,periodFattDtIniz"                                                    //
      + "           ,periodFattDtFine"                                                    //
      + "           ,CredPrecKwh"                                                         //
      + "           ,CredAttKwh"                                                          //
      + "           ,addizFER"                                                            //
      + "           ,impostaQuiet"                                                        //
      + "           ,TotPagare)"                                                          //
      + "     VALUES"                                                                     //
      + "           (?"                                                                   // <annoComp, int,>"
      + "           ,?"                                                                   // <DataEmiss, date,>"
      + "           ,?"                                                                   // <DataEmiss, date,>"
      + "           ,?"                                                                   // <fattNrAnno, int,>"
      + "           ,?"                                                                   // <fattNrNumero, nvarchar(50),>"
      + "           ,?"                                                                   // <periodFattDtIniz, date,>"
      + "           ,?"                                                                   // <periodFattDtFine, date,>"
      + "           ,?"                                                                   // <CredPrecKwh, int,>"
      + "           ,?"                                                                   // <CredAttKwh, int,>"
      + "           ,?"                                                                   // <addizFER, money,>"
      + "           ,?"                                                                   // <impostaQuiet, money,>"
      + "           ,?)";                                                                 // <TotPagare, money,>)"
  private PreparedStatement   m_stmt_ins_fattura;

  private static final String QRY_Fattura       = ""                                      //
      + "SELECT idEEFattura   FROM dbo.EEFattura"                                         //
      + " WHERE DataEmiss = ?"                                                            //
      + "   AND idIntesta = ?";
  private PreparedStatement   m_stmt_cerca_fattura;

  private static final String QRY_ins_Consumo   = ""                                      //
      + "INSERT INTO dbo.EEConsumo"                                                       //
      + "           (idEEFattura"                                                         //
      + "           ,tipoSpesa"                                                           //
      + "           ,dtIniz"                                                              //
      + "           ,dtFine"                                                              //
      + "           ,prezzoUnit"                                                          //
      + "           ,quantita"                                                            //
      + "           ,importo)"                                                            //
      + "     VALUES"                                                                     //
      + "           (?"                                                                   // <idEEFattura, int,>"
      + "           ,?"                                                                   // <tipoSpesa, nvarchar(2),>"
      + "           ,?"                                                                   // <dtIniz, date,>"
      + "           ,?"                                                                   // <dtFine, date,>"
      + "           ,?"                                                                   // <prezzoUnit, decimal(10,6),>"
      + "           ,?"                                                                   // <quantita, decimal(8,2),>"
      + "           ,?)";                                                                 // <importo, money,>)";
  private PreparedStatement   m_stmt_ins_Consumo;

  private static final String QRY_cerca_Consumo = ""                                      //
      + "SELECT idEEConsumo  "                                                            //
      + " FROM dbo.EEConsumo"                                                             //
      + " WHERE idEEFattura = ?"                                                          //
      + "  AND DtIniz = ?";
  private PreparedStatement   m_stmt_cerca_consumo;

  private static final String QRY_ins_Lettura   = ""                                      //
      + "INSERT INTO dbo.EELettura"                                                       //
      + "           (idEEFattura"                                                         //
      + "           ,LettDtPrec"                                                          //
      + "           ,LettPrec"                                                            //
      + "           ,LettDtAttuale"                                                       //
      + "           ,LettAttuale"                                                         //
      + "           ,LettConsumo)"                                                        //
      + "     VALUES"                                                                     //
      + "           (?"                                                                   // <idEEFattura, int,>"
      + "           ,?"                                                                   // <LettDtPrec, date,>"
      + "           ,?"                                                                   // <LettPrec, int,>"
      + "           ,?"                                                                   // <LettDtAttuale, date,>"
      + "           ,?"                                                                   // <LettAttuale, int,>"
      + "           ,?)";                                                                 // <LettConsumo, float,>)";
  private PreparedStatement   m_stmt_ins_Lettura;

  private static final String QRY_cerca_Lettura = ""                                      //
      + "SELECT idLettura"                                                                //
      + " FROM dbo.EELettura"                                                             //
      + " WHERE idEEFattura = ?"                                                          //
      + " AND lettDtAttuale = ?";                                                         //
  private PreparedStatement   m_stmt_cerca_Lettura;

  public SqlServToEE() {
    //
  }

  public SqlServToEE(TagValFactory p_fact, DBConn p_con) {
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
      m_stmt_cerca_consumo = conn.prepareStatement(QRY_cerca_Consumo);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", QRY_cerca_Consumo, e);
    }
    try {
      m_stmt_ins_Consumo = conn.prepareStatement(QRY_ins_Consumo);
    } catch (SQLException e) {
      s_log.error("Error prep stmt: %s", QRY_ins_Consumo, e);
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
    m_stmt_cerca_fattura.setDate(k++, new java.sql.Date(dtEmiss.getTime()));
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
    java.sql.Date dtLett = getValoreDt(Consts.TGV_LettDtAttuale, 0);
    if (dtLett == null)
      return false;
    int k = 1;
    int idLettura = -1;
    m_stmt_cerca_Lettura.setInt(k++, getIdFattura());
    m_stmt_cerca_Lettura.setDate(k++, dtLett);
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
    java.sql.Date dtIni = getValoreDt(Consts.TGV_LettDtAttuale, 0);
    int idConsumo = -1;
    int k = 1;
    m_stmt_cerca_consumo.setInt(k++, idFattura);
    m_stmt_cerca_consumo.setDate(k++, dtIni);
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
    BigDecimal impostaQuiet = new BigDecimal(0.16);
    Calendar cal = Calendar.getInstance();
    int credAnnoPrec = 0;
    int credAnnoAtt = 0;

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
    for (int i = 0; i < 3; i++) {
      Object obj = getValore(Consts.TGV_CredPrecKwh, i);
      if (obj != null && obj instanceof Integer)
        credAnnoPrec += ((Integer) obj);
      obj = getValore(Consts.TGV_CredAttKwh, i);
      if (obj != null && obj instanceof Integer)
        credAnnoAtt += ((Integer) obj);
    }

    int k = 1;
    setVal(reci.idIntesta(), m_stmt_ins_fattura, k++, Types.INTEGER);
    setVal(annoComp, m_stmt_ins_fattura, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_DataEmiss, 0, k++, Types.DATE);
    setVal(fattNrAnno, m_stmt_ins_fattura, k++, Types.INTEGER);
    setVal(fattNrNumero, m_stmt_ins_fattura, k++, Types.VARCHAR);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodFattDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodFattDtFine, 0, k++, Types.DATE);
    setVal(credAnnoPrec, m_stmt_ins_fattura, k++, Types.INTEGER);
    setVal(credAnnoAtt, m_stmt_ins_fattura, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_addizFER, 0, k++, Types.INTEGER);
    setVal(impostaQuiet, m_stmt_ins_fattura, k++, Types.DECIMAL);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_TotPagare, 0, k++, Types.DECIMAL);
    m_stmt_ins_fattura.executeUpdate();
    setIdFattura(getConnSql().getLastIdentity());
  }

  @Override
  public void insertNewLettura() throws SQLException {
    Integer idEEFattura = getIdFattura();

    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_LettDtPrec);
      @SuppressWarnings("unchecked") List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.error("Impossibile trovare li.size() per la Lettura", e);
      return;
    }

    for (int riga = 0; riga < QtaRighe; riga++) {
      int k = 1;
      setVal(idEEFattura, m_stmt_ins_Lettura, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_LettDtPrec, riga, k++, Types.DATE);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_LettPrec, riga, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_LettDtAttuale, riga, k++, Types.DATE);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_LettAttuale, riga, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_LettConsumo, riga, k++, Types.DECIMAL);

      m_stmt_ins_Lettura.executeUpdate();
    }
    Object obj = getValore(Consts.TGV_DataEmiss);
    s_log.info("Inserito {} righe di lettura EE per Fattura del {}", QtaRighe, TaggedValue.fmtData.format((Date) obj));
  }

  @Override
  public void insertNewConsumo() throws SQLException {
    Integer idEEFattura = null;
    ETipoEEConsumo tipoSpesa = null;
    BigDecimal quantita = null;
    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_PotCostUnit);
      @SuppressWarnings("unchecked") List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.error("Impossibile trovare li.size() per i consumi", e);
      return;
    }

    idEEFattura = getIdFattura();
    for (int riga = 0; riga < QtaRighe; riga++) {
      String sz = (String) getValore(Consts.TGV_tipoPotImpegn, riga);
      Object obj = getValore(Consts.TGV_tipoScaglione, riga);
      String sca = obj != null && obj instanceof String ? obj.toString() : "*";
      // System.out.printf("Consumo tipo = %s -- %s\n", sz, sca);
      tipoSpesa = ETipoEEConsumo.parse(sz, sca);
      obj = getValore(Consts.TGV_PotConsumo, riga);
      Integer vv = obj != null && obj instanceof Integer ? (Integer) obj : null;
      if (vv != null)
        quantita = new BigDecimal(vv);
      else
        quantita = (BigDecimal) getValore(Consts.TGV_PotConsumo2, riga);
      int k = 1;

      setVal(idEEFattura, m_stmt_ins_Consumo, k++, Types.INTEGER);
      setVal(tipoSpesa.getSigla(), m_stmt_ins_Consumo, k++, Types.VARCHAR);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_PotDtDa, riga, k++, Types.DATE);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_PotDtA, riga, k++, Types.DATE);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_PotCostUnit, riga, k++, Types.DECIMAL);
      setVal(quantita, m_stmt_ins_Consumo, k++, Types.DECIMAL);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_PotTotale, riga, k++, Types.DECIMAL);

      m_stmt_ins_Consumo.executeUpdate();

    }
    Object obj = getValore(Consts.TGV_DataEmiss);
    s_log.info("Inserito {} righe di Consumo EE per Fattura del {}", QtaRighe, TaggedValue.fmtData.format((Date) obj));
  }

}
