package sm.clagenna.loadaass.enums;

public enum ETipoEEConsumo {
  EnergiaPUN("PU", "Ener. PUN"), //
  EnergiaSpread1S("S1", "Spread Sc.1"), //
  EnergiaSpread2S("S2", "Spread Sc.2"), //
  Energia1S("E1", "Ener. Scgl.1"), //
  Energia2S("E2", "Ener. Scgl.2"), //
  Energia3S("E3", "Ener. Scgl.3"), //
  PotenzaImpegnata("P", "Potenza imp."), //
  RaccRifiuti("R", "Rifiuti");

  private String sigla;
  private String dicitura;

  public String getSigla() {
    return sigla;
  }

  public String getDicitura() {
    return dicitura;
  }

  private ETipoEEConsumo(String p_si, String p_dic) {
    sigla = p_si;
    dicitura = p_dic;
  }

  public static ETipoEEConsumo parse(String p_dic, String p_sca) {
    ETipoEEConsumo ret = null;
    String sz = null;
    for (ETipoEEConsumo vv : ETipoEEConsumo.values()) {
      if (p_dic.toLowerCase().contains(vv.dicitura.toLowerCase())) {
        ret = vv;
        switch (vv) {
          case Energia1S:
            sz = p_sca != null ? p_sca.substring(0, 1) : "*";
            switch (sz) {
              case "1":
                ret = Energia1S;
                break;
              case "2":
                ret = Energia2S;
                break;
              case "3":
                ret = Energia3S;
                break;
            }
            return ret;
          case EnergiaSpread1S:
            sz = p_sca != null ? p_sca.substring(0, 1) : "*";
            switch (sz) {
              case "1":
                ret = EnergiaSpread1S;
                break;
              case "2":
                ret = EnergiaSpread2S;
                break;
            }
            return ret;
          default:
            break;
        }
        break;
      }
    }
    return ret;
  }

}
