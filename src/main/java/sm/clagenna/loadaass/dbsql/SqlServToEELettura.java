package sm.clagenna.loadaass.dbsql;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class SqlServToEELettura extends SqlServBase {

  private static final Logger s_log             = LogManager.getLogger(SqlServToEELettura.class);

  private static final String QRY_ins_Lettura   = ""                                             //
      + "INSERT INTO dbo.EELettura"                                                              //
      + "           (idEEFattura"                                                                //
      + "           ,LettDtPrec"                                                                 //
      + "           ,LettPrec"                                                                   //
      + "           ,LettDtAttuale"                                                              //
      + "           ,LettAttuale"                                                                //
      + "           ,LettConsumo)"                                                               //
      + "     VALUES"                                                                            //
      + "           (?"                                                                          // <idEEFattura, int,>"
      + "           ,?"                                                                          // <LettDtPrec, date,>"
      + "           ,?"                                                                          // <LettPrec, int,>"
      + "           ,?"                                                                          // <LettDtAttuale, date,>"
      + "           ,?"                                                                          // <LettAttuale, int,>"
      + "           ,?)";                                                                        // <LettConsumo, float,>)";
  private PreparedStatement   m_stmt_ins_Lettura;

  private static final String QRY_cerca_Lettura = ""                                             //
      + "SELECT idLettura"                                                                       //
      + " FROM dbo.EELettura"                                                                    //
      + " WHERE idEEFattura = ?"                                                                 //
      + " AND lettDtAttuale = ?";                                                                //
  private PreparedStatement   m_stmt_cerca_Lettura;

  @Getter @Setter
  private SqlServToEEFattura  masterFattura;

  /**
   * Letture con le colonne:
   *
   * <pre>
   *  LettAttuale         LettCoeffK          LettConsumo         LettDtAttuale       LettDtPrec          LettPrec            LettProvv           TipoEnergia
   *  19221               1,00                269,00              30/09/2019          31/08/2019          18952               "LETTURA REALE"     "Energia Attiva"
   *  19490               1,00                269,00              31/10/2019          30/09/2019          19221               "LETTURA REALE"     "Energia Attiva"
   * </pre>
   */

  public SqlServToEELettura(TagValFactory p_fact, DBConn p_con) {
    super(p_fact, p_con);
  }

  @Override
  protected void init() {
    Connection conn = getConnSql().getConn();
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

  public boolean letturaExist() throws SQLException {
    java.sql.Date dtLett = getValoreDt(Consts.TGV_LettDtAttuale, 0);
    if (dtLett == null)
      return false;
    int k = 1;
    int idLettura = -1;
    m_stmt_cerca_Lettura.setInt(k++, getMasterFattura().getIdFattura());
    m_stmt_cerca_Lettura.setDate(k++, dtLett);
    try (ResultSet res = m_stmt_cerca_Lettura.executeQuery()) {
      while (res.next()) {
        idLettura = res.getInt(1);
      }
    }
    return idLettura >= 0;
  }

  public int insertNewLettura() throws SQLException {
    Integer idEEFattura = masterFattura.getIdFattura();
    // ETipoLettura TipoEnergia;
    java.sql.Date LettDtPrec;
    Integer LettPrec;
    java.sql.Date LettDtAttuale;
    Integer LettAttuale;
    // float LettCoeffK;
    BigDecimal LettConsumo;
    // LettProvvenienza : reale/presunta

    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_LettDtPrec);
      @SuppressWarnings("unchecked") List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.error("Impossibile trovare li.size() per la Lettura");
      return QtaRighe;
    }

    for (int riga = 0; riga < QtaRighe; riga++) {
      // String sz = (String) getValore(Consts.TGV_TipoEnergia, riga);
      // TipoEnergia = ETipoLettura.parse(sz);
      LettDtPrec = getValoreDt(Consts.TGV_LettDtPrec, riga);
      LettPrec = (Integer) getValore(Consts.TGV_LettPrec, riga);
      LettDtAttuale = getValoreDt(Consts.TGV_LettDtAttuale, riga);
      LettAttuale = (Integer) getValore(Consts.TGV_LettAttuale, riga);
      LettConsumo = (BigDecimal) getValore(Consts.TGV_LettConsumo, riga);

      /*
       * + "INSERT INTO dbo.EELettura" // + "           (idEEFattura" // +
       * "           ,LettDtPrec" // + "           ,LettPrec" // +
       * "           ,LettDtAttuale" // + "           ,LettAttuale" // +
       * "           ,LettConsumo)" //
       */
      int k = 1;
      m_stmt_ins_Lettura.setInt(k++, idEEFattura);
      //      if (TipoEnergia == null)
      //        m_stmt_ins_Lettura.setNull(k++, Types.VARCHAR);
      //      else
      //        m_stmt_ins_Lettura.setString(k++, TipoEnergia.getSigla());
      if (LettDtPrec == null)
        m_stmt_ins_Lettura.setNull(k++, Types.DATE);
      else
        m_stmt_ins_Lettura.setDate(k++, LettDtPrec);
      if (LettPrec == null)
        m_stmt_ins_Lettura.setNull(k++, Types.INTEGER);
      else
        m_stmt_ins_Lettura.setInt(k++, LettPrec);
      if (LettDtAttuale == null)
        m_stmt_ins_Lettura.setNull(k++, Types.DATE);
      else
        m_stmt_ins_Lettura.setDate(k++, LettDtAttuale);
      if (LettAttuale == null)
        m_stmt_ins_Lettura.setNull(k++, Types.INTEGER);
      else
        m_stmt_ins_Lettura.setInt(k++, LettAttuale);
      if (LettConsumo == null)
        m_stmt_ins_Lettura.setNull(k++, Types.DECIMAL);
      else
        m_stmt_ins_Lettura.setBigDecimal(k++, LettConsumo);

      m_stmt_ins_Lettura.executeUpdate();
      // Integer idLettura = getConnSql().getLastIdentity();
    }
    return QtaRighe;
  }

  @Override
  protected Logger getLog() {
    return s_log;
  }

}
