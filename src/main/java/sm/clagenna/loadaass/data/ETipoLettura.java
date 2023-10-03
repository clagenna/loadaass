package sm.clagenna.loadaass.data;

public enum ETipoLettura {
  Attiva("A", "Energia Attiva");

  private String sigla;
  private String dicitura;

  private ETipoLettura(String p_sigla, String p_dicitura) {
    sigla = p_sigla;
    dicitura = p_dicitura;
  }

  public String getSigla() {
    return sigla;
  }

  public static ETipoLettura parse(String p_dici) {
    ETipoLettura ret = null;
    for (ETipoLettura val : ETipoLettura.values()) {
      if (val.dicitura.toLowerCase().contains(p_dici.toLowerCase())) {
        ret = val;
        break;
      }
    }
    return ret;
  }
}
