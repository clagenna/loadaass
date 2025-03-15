package prova.pdf;

import lombok.Data;
import lombok.Getter;
import sm.clagenna.stdcla.utils.Utils;

@Data
public class TagVal implements Comparable<TagVal> {
  private static int s_lastId = 0;

  @Getter
  private int    id;
  private int    page;
  private double fx;
  private double fy;
  private int    left;
  private int    top;
  private String txt;
  private String rigaHtml;

  public TagVal(double nLe, double nTo, int nPa, String szTx, String szHtm) {
    setFx(nLe);
    setFy(nTo);
    setPage(nPa);
    setTxt(szTx);
    setRigaHtml(szHtm);
    calcola();
  }

  private void calcola() {
    int px = (int) Math.round(getFx() / Utils.DBL_XMAX * Utils.F_XCharMax);
    int py = (int) Math.round(getFy() / Utils.DBL_YMAX * Utils.F_YRigheMax);
    // salto alla pagina
    py += (int) ( (getPage() - 1) * Utils.F_YRigheMax);
    setLeft(px);
    setTop(py);
    id = TagVal.s_lastId++;
  }

  /**
   * Verifico se e' un testo accodabile al precedente
   *
   * @param p_succ
   * @return
   */
  public boolean isConsecutivo(TagVal p_succ) {
    double diffX = Math.abs(p_succ.left - left);
    double diffY = Math.abs(top - p_succ.top);
    double dimChMax = 7.0;
    double dimCh = 999.9F;
    if (txt != null)
      dimCh = diffX / txt.length();
    if (diffY >= 1 || //
        left > p_succ.left || //
        dimCh > dimChMax) {
      return false;
    }
    return true;
  }

  public void append(String tx) {
    if (null == txt)
      txt = tx;
    else
      txt += " " + tx;
  }

  public void append(TagVal rec) {
    txt += " " + rec.getTxt();
  }

  @Override
  public int compareTo(TagVal p_o) {
    if (getTop() < p_o.getTop())
      return -1;
    if (getTop() > p_o.getTop())
      return 1;
    if (getLeft() < p_o.getLeft())
      return -1;
    if (getLeft() > p_o.getLeft())
      return 1;
    return 0;
  }

  @Override
  public String toString() {
    String sz = String.format("(%d;%s;%s)\t%d, %d\t\"%s\"", //
        getPage(), //
        Utils.formatDouble(getFy()), Utils.formatDouble(getFx()), //
        getTop(), getLeft(), getTxt());
    return sz;
  }

}
