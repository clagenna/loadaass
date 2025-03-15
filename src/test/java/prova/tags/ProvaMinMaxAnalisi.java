package prova.tags;

import org.junit.Test;

import sm.clagenna.loadaass.data.HtmlValue;

public class ProvaMinMaxAnalisi {
  private static final String[] MIN_MAX = { "[0,7 - 1,2]", //
      "[1 - 40]", //
      "[4,8 - 8,7]", //
      "[100 - 200]", //
      "<100", //
      "< 129", //
      "130-159", //
      "> 160", //
      "136", //
      "[< 150]", //
      "[136 - 144]", //
      "[3,6 - 5,1]", //
      "[4,4 - 5,15]", //
      "[23,9 - 336,0]", //
      "[0,00 - 1,00]", //
      "[< 3.1]" //
  };

  @Test
  public void doTheJob() {
    int kk = 0;
    for (String szmm : MIN_MAX) {
      HtmlValue tag = new HtmlValue(1, kk++, 1, szmm, "xx");
      System.out.printf("%s\t%s\n", szmm, tag.toString());
    }
  }
}
