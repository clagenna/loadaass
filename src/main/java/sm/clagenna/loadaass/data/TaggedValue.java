package sm.clagenna.loadaass.data;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.enums.ETipiDato;
import sm.clagenna.loadaass.sys.Utils;

public class TaggedValue implements Comparable<TaggedValue> {

  private static final Logger s_log = LogManager.getLogger(TaggedValue.class);

  private double fx;
  private double fy;
  private int    left;
  private int    top;
  private int    page;
  private String txt;

  private ETipiDato  m_ETipiDato;
  private Date       vData;
  private Double     vDbl;
  private Integer    vInt;
  private BigDecimal vImporto;
  private String     vFattNo;
  private String     vInt15;

  public static DateFormat fmtData = new SimpleDateFormat("dd/MM/yyyy");

  private static Pattern patInt15   = Pattern.compile(ETipiDato.IntN15.getRegex());
  private static Pattern patBarrato = Pattern.compile(ETipiDato.Barrato.getRegex());
  private static Pattern patData    = Pattern.compile(ETipiDato.Data.getRegex());
  private static Pattern patReal    = Pattern.compile(ETipiDato.Float.getRegex());
  private static Pattern patImpor   = Pattern.compile(ETipiDato.Importo.getRegex());
  private static Pattern patNum     = Pattern.compile(ETipiDato.Intero.getRegex());
  // per suplire all'anno nel txt:  "Credito attuale anno 2022:"
  private static Pattern patNum2p = Pattern.compile("(\\d+):");

  public TaggedValue(double p_x, double p_y, int page, String txt) {
    setFx(p_x);
    setFy(p_y);
    setPage(page);
    setTxt(txt);
    calcola();
  }

  private void calcola() {
    int px = (int) Math.round(getFx() / Utils.DBL_XMAX * Utils.F_XCharMax);
    int py = (int) Math.round(getFy() / Utils.DBL_YMAX * Utils.F_YRigheMax);
    // salto alla pagina
    py += (int) ( (getPage() - 1) * Utils.F_YRigheMax);
    setLeft(px);
    setTop(py);
  }

  public boolean isNbsp() {
    return txt.indexOf("&nbsp;") >= 0;
  }

  public double getFx() {
    return fx;
  }

  public final void setFx(double p_fx) {
    fx = p_fx;
  }

  public double getFy() {
    return fy;
  }

  public final void setFy(double p_fy) {
    fy = p_fy;
  }

  public int getLeft() {
    return left;
  }

  public void setLeft(int p_left) {
    left = p_left;
  }

  public int getTop() {
    return top;
  }

  public void setTop(int p_top) {
    top = p_top;
  }

  public int getPage() {
    return page;
  }

  /**
   * I set <code>final</code> because of compile error:
   * <code>[this-escape] possible 'this' escape before subclass is fully initialized</code><br/>
   * I'm using this mehod on constructor and compiler complains about the fact
   * that some child class may override it.
   *
   * @param p_page
   */
  public final void setPage(int p_page) {
    page = p_page;
  }

  public String getTxt() {
    return txt;
  }

  public ETipiDato getTipo() {
    return m_ETipiDato;
  }

  public String getFattNo() {
    return vFattNo;
  }

  public BigDecimal getImporto() {
    return vImporto;
  }

  public String getContatore() {
    return vInt15;
  }

  public void setTxt(String p_txt) {
    txt = p_txt;
    discerni();
  }

  private void discerni() {
    m_ETipiDato = ETipiDato.Stringa;
    vData = null;
    vDbl = null;
    vInt = null;
    vImporto = null;
    vInt15 = null;
    // ------------- DATA ------------------
    if (txt == null || txt.length() == 0)
      return;
    if (patData.matcher(txt).matches()) {
      try {
        vData = fmtData.parse(getTxt());
        m_ETipiDato = ETipiDato.Data;
      } catch (Exception e) {
        s_log.error("Parse data:" + txt, e);
      }
      return;
    }
    // -------------- IMPORTO ----------------
    if (patImpor.matcher(txt).matches()) {
      try {
        String szV = txt.replace(".", "");
        szV = szV.replace(',', '.');
        vImporto = new BigDecimal(Double.parseDouble(szV));
        vImporto = vImporto.setScale(2, RoundingMode.HALF_DOWN);
        m_ETipiDato = ETipiDato.Importo;
      } catch (NumberFormatException e) {
        // e.printStackTrace();
        s_log.error("Parse real:" + txt, e);
      }
      return;
    }
    // -------------- FLOAT ----------------
    if (patReal.matcher(txt).matches()) {
      try {
        vDbl = Double.parseDouble(txt.replace(',', '.'));
        m_ETipiDato = ETipiDato.Float;
      } catch (NumberFormatException e) {
        // e.printStackTrace();
        s_log.error("Parse real:" + txt, e);
      }
      return;
    }
    // ------------- CONTATORE (int15) -------------------
    if (patInt15.matcher(txt).matches()) {
      try {
        vInt15 = txt;
        m_ETipiDato = ETipiDato.IntN15;
      } catch (Exception e) {
        // e.printStackTrace();
        s_log.error("Parse Fatt. No:" + txt, e);
      }
      return;
    }
    // ------------- INTERO ---------------
    if (patNum.matcher(txt).matches()) {
      try {
        long ll = Long.MAX_VALUE;
        if (txt.length() <= 10)
          ll = Long.parseLong(txt.replace(".", ""));
        if (ll < Integer.MAX_VALUE) {
          vInt = (int) ll;
          m_ETipiDato = ETipiDato.Intero;
        }
      } catch (NumberFormatException e) {
        s_log.error("Parse number:" + txt, e);
      }
      return;
    }
    // ------------- INTERO con ':' ---------------
    if (patNum2p.matcher(txt).matches()) {
      try {
        long ll = Long.MAX_VALUE;
        String sza2p = txt.substring(0, txt.length() - 1);
        if (sza2p.length() <= 10)
          ll = Long.parseLong(sza2p);
        if (ll < Integer.MAX_VALUE) {
          vInt = (int) ll;
          m_ETipiDato = ETipiDato.Intero;
        }
      } catch (NumberFormatException e) {
        s_log.error("Parse number:" + txt, e);
      }
      return;
    }
    // ------------- Num Fattura (xxx/yyyyyy) -------------------
    if (patBarrato.matcher(txt).matches()) {
      try {
        vFattNo = txt;
        m_ETipiDato = ETipiDato.Barrato;
      } catch (Exception e) {
        s_log.error("Parse Fatt. No:" + txt, e);
      }
      return;
    }
  }

  public boolean isNumero() {
    return m_ETipiDato == ETipiDato.Intero || m_ETipiDato == ETipiDato.Float;
  }

  public boolean isIntero() {
    return m_ETipiDato == ETipiDato.Intero;
  }

  public boolean isReale() {
    return m_ETipiDato == ETipiDato.Float;
  }

  public boolean isData() {
    return m_ETipiDato == ETipiDato.Data;
  }

  public boolean isFattNo() {
    return m_ETipiDato == ETipiDato.Barrato;
  }

  public boolean isText() {
    return m_ETipiDato == ETipiDato.Stringa;
  }

  public Date getvData() {
    return vData;
  }

  public Double getvDbl() {
    return vDbl;
  }

  public Integer getvInt() {
    return vInt;
  }

  @Override
  public int compareTo(TaggedValue p_o) {
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
    String szIs = "txt";
    switch (m_ETipiDato) {
      case Data:
        szIs = "Dta";
        break;
      case Barrato:
        szIs = "FatN";
        break;
      case Intero:
        szIs = "Int";
        break;
      case Float:
        szIs = "Rea";
        break;
      case Stringa:
        szIs = "txt";
        break;
      case Importo:
        szIs = "Imp";
        break;
      case IntN15:
        szIs = "n15";
        break;
      default:
        break;
    }
    //    String sz = String.format("Top:%d(%d)\tleft:%d, %s=\"%s\"", //
    //        getTop(), getPage(), getLeft(), szIs, getTxt());
    String sz = String.format("(%.2f,%.2f)\t%d(%d), %d\t%s=\"%s\"", //
        getFy(), getFx(), //
        getTop(), getPage(), getLeft(), szIs, getTxt());
    return sz;
  }

  /**
   * Verifico se e' un testo accodabile al precedente
   *
   * @param p_succ
   * @return
   */
  public boolean isConsecutivo(TaggedValue p_succ) {
    double diffX = Math.abs(p_succ.left - left);
    double diffY = Math.abs(top - p_succ.top);
    double dimChMax = 7.0;
    double dimCh = 999.9F;
    if (txt != null)
      dimCh = diffX / txt.length();
    if ( !isText() || //
        !p_succ.isText() || //
        diffY >= 1 || //
        left > p_succ.left || //
        dimCh > dimChMax) {
      return false;
    }
    return true;
  }

  public void append(TaggedValue p_rec) {
    txt += " " + p_rec.txt;
  }
}
