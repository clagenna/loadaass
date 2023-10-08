package sm.clagenna.loadaass.data;

public enum ETipoH2OLettura {
  Stimata("Stim", "STIMATA"), //
  Effettiva("Eff", "EFFETTIVA"), //
  Autolettura("Auto", "AUTOLETTURA"), //
  Totale("Tot", "Totale Consumi mc");

  private String sigla;
  private String dicitura;

  public String getSigla() {
    return sigla;
  }

  public String getDicitura() {
    return dicitura;
  }

  private ETipoH2OLettura(String p_si, String p_dic) {
    sigla = p_si;
    dicitura = p_dic;
  }

  public static ETipoH2OLettura parse(String p_dic) {
    ETipoH2OLettura ret = null;
    for (ETipoH2OLettura vv : ETipoH2OLettura.values()) {
      if (p_dic.toLowerCase().contains(vv.dicitura.toLowerCase())) {
        ret = vv;
        break;
      }
    }
    return ret;
  }

}
