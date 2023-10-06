package sm.clagenna.loadaass.data;

public enum ETipoGASLettura {
  Stimata("Stim", "STIMATA"), //
  Effettiva("Eff", "EFFETTIVA"), //
  Totale("Tot", "Totale Consumi mc");

  private String sigla;
  private String dicitura;

  public String getSigla() {
    return sigla;
  }

  public String getDicitura() {
    return dicitura;
  }

  private ETipoGASLettura(String p_si, String p_dic) {
    sigla = p_si;
    dicitura = p_dic;
  }

  public static ETipoGASLettura parse(String p_dic) {
    ETipoGASLettura ret = null;
    for (ETipoGASLettura vv : ETipoGASLettura.values()) {
      if (p_dic.toLowerCase().contains(vv.dicitura.toLowerCase())) {
        ret = vv;
        break;
      }
    }
    return ret;
  }

}
