package prova.pdf;

import sm.clagenna.loadaass.data.HtmlValue;
import sm.clagenna.loadaass.enums.ETipiDato;

public class TagVal2 extends HtmlValue {

  public TagVal2(double p_x, double p_y, int page, String txt, String szRiHtml) {
    super(p_x, p_y, page, txt, szRiHtml);
  }
  
  @Override
  protected void discerni() {
    super.discerni();
    String sz = getTxt();
    switch (sz) {
      case "-":
        setTipo(ETipiDato.Minus);
        break;
      case "*":
        setTipo(ETipiDato.Aster);
        break;
      case "%":
        setTipo(ETipiDato.Perc);
        break;
    }
  }

}
