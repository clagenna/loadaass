package sm.clagenna.loadaass.data;

import java.io.Serializable;
import java.text.DecimalFormat;

public class MyDouble implements Serializable, Comparable<MyDouble> {
  private static final long          serialVersionUID = -8520062318181572258L;
  private static final DecimalFormat s_fmt            = new DecimalFormat("#0.00");

  private Double        val;
  private DecimalFormat l_fmt;

  public MyDouble(double vv) {
    val = vv;
  }

  public static MyDouble valueOf(Double vv) {
    return new MyDouble(vv);
  }

  public static Object valueOf(float pv) {
    return new MyDouble(pv);
  }

  public void setFormat(String f) {
    l_fmt = new DecimalFormat(f);
  }

  @Override
  public String toString() {
    if (val == null || val == 0)
      return "";
    if (l_fmt != null)
      return l_fmt.format(val);
    return s_fmt.format(val);
  }

  @Override
  public int compareTo(MyDouble o) {
    if (val == null)
      return 0;
    if (o instanceof MyDouble l_o)
      return val.compareTo(l_o.val);
    return 0;
  }
}
