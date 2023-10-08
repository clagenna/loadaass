package sm.clagenna.loadaass.data;

public enum ETipoH2OConsumo {
  Scagl1S("S1", "Gas I scaglione"), //
  Scagl2S("S2", "Gas II scaglione"), //
  Scagl3S("S3", "Gas III scaglione"), //
  Scagl4S("S4", "Gas IV scaglione"), //
  
  TariffaAmb1S("TA1", "Tariffa Ambientale"), //
  TariffaAmb2S("TA2", "Tariffa Ambientale"), //
  TariffaAmb3S("TA3", "Tariffa Ambientale"), //
  TariffaAmb4S("TA4", "Tariffa Ambientale"), //
  
  QuotaFissa("F", "Quota Fissa");
  
  private String sigla;
  private String dicitura;

  public String getSigla() {
    return sigla;
  }

  public String getDicitura() {
    return dicitura;
  }

  private ETipoH2OConsumo(String p_si, String p_dic) {
    sigla = p_si;
    dicitura = p_dic;
  }

  public static ETipoH2OConsumo parse(String p_dic) {
    ETipoH2OConsumo ret = null;
    
    if ( p_dic.toLowerCase().contains(" tariffa ambientale ")) {
      if ( p_dic.contains(" IV "))
        return TariffaAmb4S;
      if ( p_dic.contains(" III "))
        return TariffaAmb3S;
      if ( p_dic.contains(" II "))
        return TariffaAmb2S;
      if ( p_dic.contains(" I "))
        return TariffaAmb4S;
    }
    if ( p_dic.toLowerCase().contains(" scaglione")) {
      if ( p_dic.contains("IV"))
        return Scagl4S;
      if ( p_dic.contains("III"))
        return Scagl3S;
      if ( p_dic.contains("II"))
        return Scagl2S;
      if ( p_dic.contains("I "))
        return Scagl1S;
    }
    for (ETipoH2OConsumo vv : ETipoH2OConsumo.values()) {
      if (p_dic.toLowerCase().contains(vv.dicitura.toLowerCase())) {
        ret = vv;
        break;
      }
    }
    return ret;
  }

}
