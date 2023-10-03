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
import sm.clagenna.loadaass.data.ETipoConsumo;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class SqlServToEEConsumo extends SqlServBase {

  private static final Logger s_log             = LogManager.getLogger(SqlServToEEConsumo.class);

  private static final String QRY_ins_Consumo   = "INSERT INTO dbo.EEConsumo"                    //
      + "           (idEEFattura"                                                                //
      + "           ,tipoSpesa"                                                                  //
      + "           ,dtIniz"                                                                     //
      + "           ,dtFine"                                                                     //
      + "           ,prezzoUnit"                                                                 //
      + "           ,quantita"                                                                   //
      + "           ,importo)"                                                                   //
      + "     VALUES"                                                                            //
      + "           (?"                                                                          // <idEEFattura, int,>"
      + "           ,?"                                                                          // <tipoSpesa, nvarchar(2),>"
      + "           ,?"                                                                          // <dtIniz, date,>"
      + "           ,?"                                                                          // <dtFine, date,>"
      + "           ,?"                                                                          // <prezzoUnit, decimal(10,6),>"
      + "           ,?"                                                                          // <quantita, decimal(8,2),>"
      + "           ,?)";                                                                        // <importo, money,>)";
  private PreparedStatement   m_stmt_ins_Consumo;

  private static final String QRY_cerca_Consumo = ""                                             //
      + "SELECT idEEConsumo  "                                                                   //
      + " FROM dbo.EEConsumo"                                                                    //
      + " WHERE idEEFattura = ?"                                                                 //
      + "  AND DtIniz = ?";
  private PreparedStatement   m_stmt_cerca_consumo;

  @Getter @Setter
  private SqlServToEEFattura  masterFattura;

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
  public SqlServToEEConsumo(TagValFactory p_fact, DBConn p_con) {
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

  public void insertConsumo() throws SQLException {
    Integer idEEFattura = null;
    ETipoConsumo tipoSpesa = null;
    BigDecimal quantita = null;
    int QtaRighe = -1;
    try {
      ValoreByTag vtag = getTagFactory().get(Consts.TGV_PotCostUnit);
      @SuppressWarnings("unchecked") List<Object> li = (List<Object>) vtag.getValore();
      QtaRighe = li.size();
    } catch (ReadFattValoreException e) {
      s_log.error("Impossibile trovare li.size() per i consumi");
      return;
    }

    idEEFattura = masterFattura.getIdFattura();
    for (int riga = 0; riga < QtaRighe; riga++) {
      String sz = (String) getValore(Consts.TGV_tipoPotImpegn, riga);
      Object obj = getValore(Consts.TGV_tipoScaglione, riga);
      String sca = obj != null && obj instanceof String ? obj.toString() : "*";
      // System.out.printf("Consumo tipo = %s -- %s\n", sz, sca);
      tipoSpesa = ETipoConsumo.parse(sz, sca);
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
  }

  @Override
  protected Logger getLog() {
    return s_log;
  }

}
