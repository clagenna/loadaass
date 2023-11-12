package sm.clagenna.loadaass.data;

import java.io.Serializable;
import java.util.Date;

import sm.clagenna.loadaass.sys.Utils;

public class MyDate implements Serializable, Comparable<MyDate> {
  private static final long serialVersionUID = -5243862236495832695L;

  private Date dt;

  public MyDate(Date pv) {
    dt = pv;
  }

  public static MyDate valueOf(Date pv) {
    return new MyDate(pv);
  }

  @Override
  public String toString() {
    if (dt == null)
      return "";
    String sz = Utils.s_fmtDMY4_HMS.format(dt);
    sz = sz.replace(" 00:00:00", "");
    return sz;
  }

  @Override
  public int compareTo(MyDate o) {
    if (dt == null)
      return 0;
    if (o instanceof MyDate d)
      return dt.compareTo(o.dt);
    return 0;
  }
}
