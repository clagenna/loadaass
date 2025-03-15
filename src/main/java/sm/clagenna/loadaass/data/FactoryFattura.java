package sm.clagenna.loadaass.data;

import sm.clagenna.loadaass.dbsql.ISql;
import sm.clagenna.loadaass.dbsql.SqlServToAnalisi;
import sm.clagenna.loadaass.dbsql.SqlServToEE;
import sm.clagenna.loadaass.dbsql.SqlServToGAS;
import sm.clagenna.loadaass.dbsql.SqlServToH2O;
import sm.clagenna.loadaass.enums.ETipoFatt;

public class FactoryFattura {

  public FactoryFattura() {
    //
  }

  public static ISql getFatturaInserter(ETipoFatt ptp) {
    ISql ret = null;
    switch (ptp) {
      case Acqua:
        ret = new SqlServToH2O();
        break;
      case EnergiaElettrica:
        ret = new SqlServToEE();
        break;
      case GAS:
        ret = new SqlServToGAS();
        break;
      case Analisi:
        ret = new SqlServToAnalisi();
      default:
        break;
    }
    return ret;
  }

}
