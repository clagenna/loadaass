package sm.clagenna.loadaass.dbsql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.ETipoGASLettura;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.TaggedValue;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class SqlServToGASLettura extends SqlServBase {

  private static final Logger s_log             = LogManager.getLogger(SqlServToGASLettura.class);

  private static final String QRY_ins_Lettura   = ""                                              //
      + "INSERT INTO dbo.GASLettura"                                                              //
      + "           (idGASFattura"                                                                //
      + "           ,lettQtaMc"                                                                   //
      + "           ,LettData"                                                                    //
      + "           ,TipoLett"                                                                    //
      + "           ,Consumofatt)"                                                                //
      + "     VALUES (?,?,?,?,?)";                                                                //

  private PreparedStatement   m_stmt_ins_Lettura;

  private static final String QRY_cerca_Lettura = ""                                              //
      + "SELECT idLettura"                                                                        //
      + " FROM dbo.GASLettura"                                                                    //
      + " WHERE idGASFattura = ?"                                                                 //
      + " AND lettData = ?";                                                                      //
  private PreparedStatement   m_stmt_cerca_Lettura;

  @Getter @Setter
  private SqlServToGASFattura masterFattura;

  /**
   * Letture con le colonne:
   *
   * <pre>
   *  LettAttuale         LettCoeffK          LettConsumo         LettDtAttuale       LettDtPrec          LettPrec            LettProvv           TipoEnergia
   *  19221               1,00                269,00              30/09/2019          31/08/2019          18952               "LETTURA REALE"     "Energia Attiva"
   *  19490               1,00                269,00              31/10/2019          30/09/2019          19221               "LETTURA REALE"     "Energia Attiva"
   * </pre>
   */

  public SqlServToGASLettura(TagValFactory p_fact, DBConn p_con) {
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
    java.sql.Date dtLett = getValoreDt(Consts.TGV_LettData, 0);
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
    String szMsg = null;
    Integer idGASFattura = masterFattura.getIdFattura();

    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_TipoLett);
      @SuppressWarnings("unchecked") List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.error("Impossibile trovare li.size() per la Lettura GAS");
      return QtaRighe;
    }

    for (int riga = 0; riga < QtaRighe; riga++) {
      int k = 1;
      Object obj = getValore(Consts.TGV_TipoLett, riga);
      ETipoGASLettura tp = ETipoGASLettura.parse(obj.toString());
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
    s_log.info("Inserito {} righe di consumo GAS per Fattura del {}", QtaRighe, TaggedValue.fmtData.format((Date) obj));
    return QtaRighe;
  }

  @Override
  protected Logger getLog() {
    return s_log;
  }

}
