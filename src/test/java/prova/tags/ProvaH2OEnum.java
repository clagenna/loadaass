package prova.tags;

import org.junit.Test;

import sm.clagenna.loadaass.enums.ETipoH2OConsumo;

public class ProvaH2OEnum {
  public ProvaH2OEnum() {
    //
  }

  @Test
  public void provalo() {
    String[] arr = { "I Scaglione", //
        "II Scaglione", //
        "III Scaglione", //
        "IV Scaglione", //
        "Tariffa Ambientale I Scaglione", //
        "Tariffa Ambientale II Scaglione", //
        "Tariffa Ambientale III Scaglione", //
        "Tariffa Ambientale IV Scaglione", //
        "Quota Fissa" };
    for (String sz : arr) {
      ETipoH2OConsumo h2o = ETipoH2OConsumo.parse(sz);
      System.out.printf("\"%s\" => %s\n", sz, h2o);
    }
  }

}
