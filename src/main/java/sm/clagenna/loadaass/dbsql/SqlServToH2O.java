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

import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.TaggedValue;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.enums.ETipoH2OConsumo;
import sm.clagenna.loadaass.enums.ETipoLettProvvenienza;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class SqlServToH2O extends SqlServBase {

  private static final Logger s_log = LogManager.getLogger(SqlServToH2O.class);

  private static final String QRY_ins_Fattura = ""                   //
      + "INSERT INTO H2OFattura"                                     //
      + "           (idIntesta"                                      //
      + "           ,annoComp"                                       //
      + "           ,DataEmiss"                                      //
      + "           ,fattNrAnno"                                     //
      + "           ,fattNrNumero"                                   //
      + "           ,periodFattDtIniz"                               //
      + "           ,periodFattDtFine"                               //
      + "           ,periodCongDtIniz"                               //
      + "           ,periodCongDtFine"                               //
      + "           ,periodAccontoDtIniz"                            //
      + "           ,periodAccontoDtFine"                            //
      + "           ,assicurazione"                                  //
      + "           ,impostaQuiet" + "           ,RestituzAccPrec"   //
      + "           ,TotPagare)"                                     //
      + "     VALUES (?, ?, ? ,? ,? ,?, ?, ? ,? ,? ,?, ? ,?, ? ,?)";
  private PreparedStatement   m_stmt_ins_fattura;

  private static final String QRY_Fattura = ""          //
      + "SELECT idH2OFattura   FROM H2OFattura"         //
      + " WHERE DataEmiss = ?" + "   AND idIntesta = ?";
  private PreparedStatement   m_stmt_cerca_fattura;

  private static final String QRY_ins_Lettura = "" //
      + "INSERT INTO H2OLettura" //
      + "           (idH2OFattura" //
      + "           ,lettQtaMc" //
      + "           ,LettData" //
      + "           ,TipoLett" //
      + "           ,Consumofatt)" //
      + "     VALUES (?,?,?,?,?)"; //

  private PreparedStatement m_stmt_ins_Lettura;

  private static final String QRY_cerca_Lettura = ""   //
      + "SELECT idLettura"                             //
      + " FROM H2OLettura"                             //
      + " WHERE idH2OFattura = ?"                      //
      + " AND lettData = ?";                           //
  private PreparedStatement   m_stmt_cerca_Lettura;

  private static final String QRY_ins_Consumo = "INSERT INTO H2OConsumo"   //
      + "           (idH2OFattura"                                         //
      + "           ,tipoSpesa"                                            //
      + "           ,dtIniz"                                               //
      + "           ,dtFine"                                               //
      + "           ,stimato"                                              //
      + "           ,prezzoUnit"                                           //
      + "           ,quantita"                                             //
      + "           ,importo)"                                             //
      + "     VALUES  (?, ?, ?, ?, ?, ?, ?, ?)";
  private PreparedStatement   m_stmt_ins_Consumo;

  private static final String QRY_cerca_Consumo = ""   //
      + "SELECT idConsumo  "                           //
      + " FROM H2OConsumo"                             //
      + " WHERE idH2OFattura = ?"                      //
      + "  AND DtIniz = ?";
  private PreparedStatement   m_stmt_cerca_consumo;

  public SqlServToH2O() {
    //
  }

  public SqlServToH2O(TagValFactory p_fact, DBConn p_con) {
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
    RecIntesta reci = getRecIntesta();
    int k = 1;
    // m_stmt_cerca_fattura.set D a t e(k++, new java.sql.Date(dtEmiss.getTime()));
    DBConn conn = getConnSql();
    conn.setStmtDate(m_stmt_cerca_fattura, k++, dtEmiss);

    m_stmt_cerca_fattura.setInt(k++, reci.getIdIntestaInt());
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
    BigDecimal impostaQuiet = new BigDecimal(0.17);
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
    setVal(reci.getIdIntestaInt(), m_stmt_ins_fattura, k++, Types.INTEGER);
    setVal(annoComp, m_stmt_ins_fattura, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_DataEmiss, 0, k++, Types.DATE);
    setVal(fattNrAnno, m_stmt_ins_fattura, k++, Types.INTEGER);
    setVal(fattNrNumero, m_stmt_ins_fattura, k++, Types.VARCHAR);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodFattDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodFattDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodCongDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodCongDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodAccontoDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodAccontoDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_assicurazione, 0, k++, Types.INTEGER);
    setVal(impostaQuiet, m_stmt_ins_fattura, k++, Types.DECIMAL);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_RestituzAccPrec, 0, k++, Types.DECIMAL);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_TotPagare, 0, k++, Types.DECIMAL);
    m_stmt_ins_fattura.executeUpdate();
    setIdFattura(getConnSql().getLastIdentity());
  }

  @Override
  public void insertNewLettura() throws SQLException {
    String szMsg = null;
    Integer idH2OFattura = getIdFattura();

    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_TipoLett);
      @SuppressWarnings("unchecked")
      List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.warn("Sembra non ci siano letture di H2O!");
      return;
    }

    for (int riga = 0; riga < QtaRighe; riga++) {
      int k = 1;
      Object obj = getValore(Consts.TGV_TipoLett, riga);
      ETipoLettProvvenienza tp = ETipoLettProvvenienza.parse(obj.toString());
      if (tp == null) {
        szMsg = "H2O Letture, Non decodifico tipo lettura:" + obj;
        throw new SQLException(szMsg);
      }
      setVal(idH2OFattura, m_stmt_ins_Lettura, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_lettQtaMc, riga, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_LettData, riga, k++, Types.DATE);
      setVal(tp.getSigla(), m_stmt_ins_Lettura, k++, Types.VARCHAR);
      setValTgv(m_stmt_ins_Lettura, Consts.TGV_Consumofatt, riga, k++, Types.DECIMAL);

      m_stmt_ins_Lettura.executeUpdate();
    }
    Object obj = getValore(Consts.TGV_DataEmiss);
    s_log.info("Inserito {} righe di consumo H2O per Fattura del {}", QtaRighe, TaggedValue.fmtData.format((Date) obj));
  }

  @Override
  public void insertNewConsumo() throws SQLException {
    Integer idH2OFattura = null;
    ETipoH2OConsumo tipoCausale = null;
    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_TipoCausale);
      @SuppressWarnings("unchecked")
      List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.warn("Sembra non ci siano letture di H2O!");
      return;
    }
    idH2OFattura = getIdFattura();
    for (int riga = 0; riga < QtaRighe; riga++) {
      Object obj = getValore(Consts.TGV_TipoCausale, riga);
      tipoCausale = ETipoH2OConsumo.parse(obj.toString());
      if (tipoCausale == null) {
        String szMsg = "H2O Consumi, Non decodifico causale consumo:" + obj;
        throw new SQLException(szMsg);
      }
      int k = 1;
      setVal(idH2OFattura, m_stmt_ins_Consumo, k++, Types.INTEGER);
      setVal(tipoCausale.getSigla(), m_stmt_ins_Consumo, k++, Types.VARCHAR);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_periodoDa, riga, k++, Types.DATE);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_periodoA, riga, k++, Types.DATE);
      setStimato(m_stmt_ins_Consumo, Consts.TGV_periodoA, riga, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_lettPrezzoU, riga, k++, Types.DECIMAL);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_LettQta, riga, k++, Types.DECIMAL);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_LettImp, riga, k++, Types.DECIMAL);

      /* int retsql = */ m_stmt_ins_Consumo.executeUpdate();
      // System.out.println("SqlServToH2O.insertNewConsumo() ret=" + retsql);
    }
    Object obj = getValore(Consts.TGV_DataEmiss);
    s_log.info("Inserito {} righe di lettura H2O per Fattura del {}", QtaRighe, TaggedValue.fmtData.format((Date) obj));
  }

}
