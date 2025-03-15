package sm.clagenna.loadaass.dbsql;

import java.math.BigDecimal;
import java.nio.file.Path;
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
import sm.clagenna.loadaass.data.HtmlValue;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.enums.ETipoGASConsumo;
import sm.clagenna.loadaass.enums.ETipoLettProvvenienza;
import sm.clagenna.loadaass.sys.ex.ReadFattSQLException;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;
import sm.clagenna.stdcla.sql.DBConn;

public class SqlServToGAS extends SqlServBase {

  private static final Logger s_log = LogManager.getLogger(SqlServToGAS.class);

  private static final String QRY_ins_Fattura = ""                     //
      + "INSERT INTO GASFattura"                                       //
      + "           (idIntesta"                                        //
      + "           ,annoComp"                                         //
      + "           ,DataEmiss"                                        //
      + "           ,fattNrAnno"                                       //
      + "           ,fattNrNumero"                                     //
      + "           ,periodFattDtIniz"                                 //
      + "           ,periodFattDtFine"                                 //
      + "           ,periodEffDtIniz"                                  //
      + "           ,periodEffDtFine"                                  //
      + "           ,periodAccontoDtIniz"                              //
      + "           ,periodAccontoDtFine"                              //
      + "           ,accontoBollPrec"                                  //
      + "           ,addizFER"                                         //
      + "           ,impostaQuiet"                                     //
      + "           ,TotPagare"                                        //
      + "           ,nomeFile)"                                        //
      + "     VALUES (? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,?)";
  private PreparedStatement   m_stmt_ins_fattura;

  private static final String QRY_Fattura = ""          //
      + "SELECT idGASFattura   FROM GASFattura"         //
      + " WHERE DataEmiss = ?" + "   AND idIntesta = ?";
  private PreparedStatement   m_stmt_cerca_fattura;

  private static final String QRY_ins_Lettura = "" //
      + "INSERT INTO GASLettura" //
      + "           (idGASFattura" //
      + "           ,lettQtaMc" //
      + "           ,LettData" //
      + "           ,TipoLett" //
      + "           ,Consumofatt)" //
      + "     VALUES (?,?,?,?,?)"; //

  private PreparedStatement m_stmt_ins_Lettura;

  private static final String QRY_cerca_Lettura = ""   //
      + "SELECT idLettura"                             //
      + " FROM GASLettura"                             //
      + " WHERE idGASFattura = ?"                      //
      + " AND lettData = ?";                           //
  private PreparedStatement   m_stmt_cerca_Lettura;

  private static final String QRY_ins_Consumo = "INSERT INTO GASConsumo"   //
      + "           (idGASFattura"                                         //
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
      + " FROM GASConsumo"                             //
      + " WHERE idGASFattura = ?"                      //
      + "  AND DtIniz = ?";
  private PreparedStatement   m_stmt_cerca_consumo;

  public SqlServToGAS() {
    //
  }

  public SqlServToGAS(TagValFactory p_fact, DBConn p_con, Path p_pdf) {
    super(p_fact, p_con, p_pdf);
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

    m_stmt_cerca_fattura.setInt(k++, reci.getIdIntestaInt());
    clearIdFattura();
    System.out.println(toString(m_stmt_cerca_fattura));
    try (ResultSet res = m_stmt_cerca_fattura.executeQuery()) {
      while (res.next()) {
        var idf = res.getInt(1);
        s_log.debug("Fattura GAS exist={}", idf);
        addIdFattura(idf);
      }
    }
    return existFattDaCancellare();
  }

  @Override
  public boolean letturaExist() throws SQLException {
    java.sql.Date dtLett = getValoreDt(Consts.TGV_LettData, 0);
    if (dtLett == null)
      return false;
    int idLettura = -1;
    for (Integer idFattura : getListFatture()) {
      int k = 1;
      m_stmt_cerca_Lettura.setInt(k++, idFattura);
      // m_stmt_cerca_Lettura.set D a t e(k++, dtLett);
      DBConn conn = getConnSql();
      conn.setStmtDate(m_stmt_cerca_Lettura, k++, dtLett);

      try (ResultSet res = m_stmt_cerca_Lettura.executeQuery()) {
        while (res.next()) {
          idLettura = res.getInt(1);
        }
      }
    }
    return idLettura >= 0;
  }

  @Override
  public boolean consumoExist() throws SQLException {
    java.sql.Date dtIni = getValoreDt(Consts.TGV_periodoDa, 0);
    int idConsumo = -1;
    for (Integer idFattura : getListFatture()) {
      int k = 1;
      m_stmt_cerca_consumo.setInt(k++, idFattura);
      // m_stmt_cerca_consumo.set D a t e(k++, dtIni);
      DBConn conn = getConnSql();
      conn.setStmtDate(m_stmt_cerca_consumo, k++, dtIni);

      try (ResultSet res = m_stmt_cerca_consumo.executeQuery()) {
        while (res.next())
          idConsumo = res.getInt(1);
      }
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
    String szPdfFileName = getPdfFileName().getFileName().toString();
    clearIdFattura();
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

    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodEffDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodEffDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodAccontoDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodAccontoDtFine, 0, k++, Types.DATE);

    setValTgv(m_stmt_ins_fattura, Consts.TGV_accontoBollPrec, 0, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_addizFER, 0, k++, Types.INTEGER);
    setVal(impostaQuiet, m_stmt_ins_fattura, k++, Types.DECIMAL);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_TotPagare, 0, k++, Types.DECIMAL);
    setVal(szPdfFileName, m_stmt_ins_fattura, k++, Types.VARCHAR);
    if (isShowStatement())
      s_log.info(toString(m_stmt_ins_fattura));
    m_stmt_ins_fattura.executeUpdate();
    addIdFattura(getConnSql().getLastIdentity());
  }

  @Override
  public void insertNewLettura() throws SQLException {
    String szMsg = null;
    Integer idGASFattura = null;
    try {
      idGASFattura = getIdFattura();
    } catch (ReadFattSQLException e) {
      s_log.error("Sembra non ci sia la fattura!", e);
      return;
    }
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

      if (isShowStatement())
        s_log.info(toString(m_stmt_ins_Lettura));
      m_stmt_ins_Lettura.executeUpdate();
    }
    Object obj = getValore(Consts.TGV_DataEmiss);
    s_log.info("Inserito {} righe di lettura GAS per Fattura del {}", QtaRighe, HtmlValue.fmtData.format((Date) obj));

  }

  @Override
  public void insertNewConsumo() throws SQLException {
    Integer idGASFattura = null;
    try {
      idGASFattura = getIdFattura();
    } catch (ReadFattSQLException e) {
      s_log.error("Sembra non ci sia la fattura!", e);
      return;
    }
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
      setStimato(m_stmt_ins_Consumo, Consts.TGV_periodoA, riga, k++, Types.INTEGER);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_lettPrezzoU, riga, k++, Types.DECIMAL);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_LettQta, riga, k++, Types.DECIMAL);
      setValTgv(m_stmt_ins_Consumo, Consts.TGV_LettImp, riga, k++, Types.DECIMAL);

      if (isShowStatement())
        s_log.info(toString(m_stmt_ins_Consumo));
      m_stmt_ins_Consumo.executeUpdate();
    }
    Object obj = getValore(Consts.TGV_DataEmiss);
    s_log.info("Inserito {} righe di consumo GAS per Fattura del {}", QtaRighe, HtmlValue.fmtData.format((Date) obj));

  }

}
