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
      if (vv.dicitura.toLowerCase().contains(p_dic.toLowerCase())) {
        ret = vv;
        break;
      }
    }
    return ret;
  }

}
