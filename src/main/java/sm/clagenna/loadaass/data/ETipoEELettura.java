package sm.clagenna.loadaass.data;

public enum ETipoEELettura {
  Attiva("A", "Energia Attiva");

  private String sigla;
  private String dicitura;

  private ETipoEELettura(String p_sigla, String p_dicitura) {
    sigla = p_sigla;
    dicitura = p_dicitura;
  }

  public String getSigla() {
    return sigla;
  }

  public static ETipoEELettura parse(String p_dici) {
    ETipoEELettura ret = null;
    for (ETipoEELettura val : ETipoEELettura.values()) {
      if (val.dicitura.toLowerCase().contains(p_dici.toLowerCase())) {
        ret = val;
        break;
      }
    }
    return ret;
  }
}
