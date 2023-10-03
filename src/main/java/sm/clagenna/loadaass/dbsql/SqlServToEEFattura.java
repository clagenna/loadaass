package sm.clagenna.loadaass.dbsql;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Calendar;
import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.TagValFactory;

public class SqlServToEEFattura extends SqlServBase {
  private static final Logger s_log           = LogManager.getLogger(SqlServToEEFattura.class);

  private static final String QRY_ins_Fattura = ""                                             //
      + "INSERT INTO dbo.EEFattura"                                                            //
      + "           (annoComp"                                                                 //
      + "           ,DataEmiss"                                                                //
      + "           ,fattNrAnno"                                                               //
      + "           ,fattNrNumero"                                                             //
      + "           ,periodFattDtIniz"                                                         //
      + "           ,periodFattDtFine"                                                         //
      + "           ,CredPrecKwh"                                                              //
      + "           ,CredAttKwh"                                                               //
      + "           ,addizFER"                                                                 //
      + "           ,impostaQuiet"                                                             //
      + "           ,TotPagare)"                                                               //
      + "     VALUES"                                                                          //
      + "           (?"                                                                        // <annoComp, int,>"
      + "           ,?"                                                                        // <DataEmiss, date,>"
      + "           ,?"                                                                        // <fattNrAnno, int,>"
      + "           ,?"                                                                        // <fattNrNumero, nvarchar(50),>"
      + "           ,?"                                                                        // <periodFattDtIniz, date,>"
      + "           ,?"                                                                        // <periodFattDtFine, date,>"
      + "           ,?"                                                                        // <CredPrecKwh, int,>"
      + "           ,?"                                                                        // <CredAttKwh, int,>"
      + "           ,?"                                                                        // <addizFER, money,>"
      + "           ,?"                                                                        // <impostaQuiet, money,>"
      + "           ,?)";                                                                      // <TotPagare, money,>)"
  private PreparedStatement   m_stmt_ins_fattura;

  private static final String QRY_Fattura     = ""                                             //
      + "SELECT idEEFattura   FROM dbo.EEFattura"                                              //
      + " WHERE DataEmiss = ?";
  private PreparedStatement   m_stmt_cerca_fattura;
  @Getter @Setter
  private Integer             idFattura;

  public SqlServToEEFattura(TagValFactory p_fact, DBConn p_con) {
    super(p_fact, p_con);
  }

  @Override
  protected void init() {
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
  }

  public boolean fatturaExist() throws SQLException {
    Date dtEmiss = (Date) getValore(Consts.TGV_DataEmiss);
    // String sz = (String) getValore("FattNr");
    // String[] arr = sz.split("/");
    // int annoComp = Integer.parseInt(arr[0]);
    // String fattNumero = arr[1];

    int k = 1;
    m_stmt_cerca_fattura.setDate(k++, new java.sql.Date(dtEmiss.getTime()));
    setIdFattura(null);
    try (ResultSet res = m_stmt_cerca_fattura.executeQuery()) {
      while (res.next()) {
        idFattura = res.getInt(1);
        setIdFattura(idFattura);
      }
    }
    return idFattura != null;
  }

  public Integer insertNewFattura() throws SQLException {
    Integer annoComp = null;
    java.sql.Date dataEmiss = null;
    Integer fattNrAnno = null;
    String fattNrNumero = null;
    BigDecimal impostaQuiet = new BigDecimal(0.16);
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
    setVal(annoComp, m_stmt_ins_fattura, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_DataEmiss, 0, k++, Types.DATE);
    setVal(fattNrAnno, m_stmt_ins_fattura, k++, Types.INTEGER);
    setVal(fattNrNumero, m_stmt_ins_fattura, k++, Types.VARCHAR);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodFattDtIniz, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_PeriodFattDtFine, 0, k++, Types.DATE);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_CredPrecKwh, 0, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_CredAttKwh, 0, k++, Types.INTEGER);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_addizFER, 0, k++, Types.INTEGER);
    setVal(impostaQuiet, m_stmt_ins_fattura, k++, Types.DECIMAL);
    setValTgv(m_stmt_ins_fattura, Consts.TGV_TotPagare, 0, k++, Types.DECIMAL);
    m_stmt_ins_fattura.executeUpdate();
    idFattura = getConnSql().getLastIdentity();

    return idFattura;
  }

  @Override
  protected Logger getLog() {
    return s_log;
  }

}
