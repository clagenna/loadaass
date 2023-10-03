package sm.clagenna.loadaass.data;

public enum ETipoFatt {
  GAS("GAS"), //
  EnergiaElettrica("EE"), //
  Acqua("H2O");

  private String titolo;

  private ETipoFatt(String tit) {
    titolo = tit;
  }

  public String getTitolo() {
    return titolo;
  }

  public static ETipoFatt parse(String p_sz) {
    ETipoFatt ret = null;
    if (p_sz == null || p_sz.length() < 3)
      return ret;
    for (ETipoFatt t : ETipoFatt.values()) {
      if (t.titolo.equals(p_sz)) {
        ret = t;
        break;
      }
    }
    return ret;
  }
}
