package sm.clagenna.loadaass.data;

public enum ETipoConsumo {
  Energia1S("E1", "Corrispettivo energia"), //
  Energia2S("E2", "Corrispettivo energia"), //
  Energia3S("E3", "Corrispettivo energia"), //
  PotenzaImpegnata("P", "Potenza impegnata"), //
  RaccRifiuti("R", "Raccolta rifiuti");

  private String sigla;
  private String dicitura;

  public String getSigla() {
    return sigla;
  }

  public String getDicitura() {
    return dicitura;
  }

  private ETipoConsumo(String p_si, String p_dic) {
    sigla = p_si;
    dicitura = p_dic;
  }

  public static ETipoConsumo parse(String p_dic, String p_sca) {
    ETipoConsumo ret = null;
    for (ETipoConsumo vv : ETipoConsumo.values()) {
      if (p_dic.toLowerCase().contains(vv.dicitura.toLowerCase())) {
        ret = vv;
        switch (vv) {
          case Energia1S:
            String sz = p_sca != null ? p_sca.substring(0, 1) : "*";
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
          default:
            break;
        }
        break;
      }
    }
    return ret;
  }

}
