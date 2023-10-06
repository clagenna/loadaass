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
import sm.clagenna.loadaass.data.ETipoGASConsumo;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.TaggedValue;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class SqlServToGASConsumo extends SqlServBase {

  private static final Logger s_log             = LogManager.getLogger(SqlServToGASConsumo.class);

  private static final String QRY_ins_Consumo   = "INSERT INTO dbo.GASConsumo"                    //
      + "           (idGASFattura"                                                                //
      + "           ,tipoSpesa"                                                                   //
      + "           ,dtIniz"                                                                      //
      + "           ,dtFine"                                                                      //
      + "           ,prezzoUnit"                                                                  //
      + "           ,quantita"                                                                    //
      + "           ,importo)"                                                                    //
      + "     VALUES"                                                                             //
      + "           (?"                                                                           // <idGASFattura, int,>"
      + "           ,?"                                                                           // <tipoSpesa, nvarchar(2),>"
      + "           ,?"                                                                           // <dtIniz, date,>"
      + "           ,?"                                                                           // <dtFine, date,>"
      + "           ,?"                                                                           // <prezzoUnit, decimal(10,6),>"
      + "           ,?"                                                                           // <quantita, decimal(8,2),>"
      + "           ,?)";                                                                         // <importo, money,>)";
  private PreparedStatement   m_stmt_ins_Consumo;

  private static final String QRY_cerca_Consumo = ""                                              //
      + "SELECT idConsumo  "                                                                      //
      + " FROM dbo.GASConsumo"                                                                    //
      + " WHERE idGASFattura = ?"                                                                 //
      + "  AND DtIniz = ?";
  private PreparedStatement   m_stmt_cerca_consumo;

  @Getter @Setter
  private SqlServToGASFattura masterFattura;

  /**
   * <pre>
   *  PotConsumo          PotConsumo2         PotCostUnit         PotDtA              PotDtDa             potImpUnit          PotTotale           tipoPotImpegn       tipoScaglione
   *  158                 *---*               0,089450            30/09/2019          01/09/2019          "€/kWh"             14,13               "Corrispettivo energ"1° scaglione"
   *  111                 *---*               0,189510            30/09/2019          01/09/2019          "€/kWh"             21,04               "Corrispettivo energ"2° scaglione"
   *  *---*               4,50                0,867978            30/09/2019          01/09/2019          "€/KW"              3,91                "Corrispettivo poten*---*pegnata"
   *  etc ...
   * </pre>
   *
   * @param p_fact
   * @param p_con
   */
  public SqlServToGASConsumo(TagValFactory p_fact, DBConn p_con) {
    super(p_fact, p_con);
  }

  @Override
  protected void init() {
    Connection conn = getConnSql().getConn();
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

  public boolean consumoExists() throws SQLException {
    Integer idFattura = masterFattura.getIdFattura();
    java.sql.Date dtIni = getValoreDt(Consts.TGV_periodoDa, 0);
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

  public void insertConsumo() throws SQLException {
    Integer idGASFattura = null;
    ETipoGASConsumo tipoCausale = null;
    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_TipoCausale);
      @SuppressWarnings("unchecked") List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.error("Impossibile trovare li.size() per i consumi");
      return;
    }
    idGASFattura = masterFattura.getIdFattura();
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
    s_log.info("Inserito {} righe di lettura GAS per Fattura del {}", QtaRighe, TaggedValue.fmtData.format((Date) obj));
  }

  @Override
  protected Logger getLog() {
    return s_log;
  }

}
