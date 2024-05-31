package sm.clagenna.loadaass.enums;

import java.util.HashMap;
import java.util.Map;

import sm.clagenna.loadaass.dbsql.dtset.Dataset;
import sm.clagenna.loadaass.dbsql.dtset.DtsCol;

/**
 * Enumerato dei tipi di dato che si possono incontrare nelle fatture. Ogni tipo
 * di dato ha la sua RegEx di identificazione. Questa RegEx è utilizzata nel
 * {@link Dataset} su ogni {@link DtsCol} per <i>parse-are<i> il valore.
 *
 * @author claudio
 *
 */
public enum ETipiDato {
  IntN15("i15", "(\\d{15})", true), //
  Intero("i", "(-{0,1}\\d+[\\.]*\\d*)", true), //
  Float("f", "(-{0,1}[\\d\\.]*\\d+[,]\\d+)", true), //
  Importo("cy", "(-{0,1}[\\d\\.]*\\d+,\\d{2})", true), //
  Barrato("br", "(\\d+/\\d+)", false), //
  Stringa("s", "([a-zA-Z]+)", false), //
  Data("d", "(\\d{2}/\\d{2}/\\d{4})", false);

  private String                        cod;
  private String                        regex;
  private boolean                       numeric;
  private static Map<String, ETipiDato> map;

  static {
    map = new HashMap<String, ETipiDato>();
    for (ETipiDato tp : ETipiDato.values()) {
      map.put(tp.cod, tp);
    }
  }

  private ETipiDato(String p_cod, String p_rex, boolean p_num) {
    cod = p_cod;
    regex = p_rex;
    numeric = p_num;
  }

  public String getCod() {
    return cod;
  }

  public String getRegex() {
    return regex;
  }

  public boolean isNumeric() {
    return numeric;
  }

  public static ETipiDato decode(String pcod) {
    return map.get(pcod);
  }

  public boolean isCompatible(ETipiDato p_altro) {
    boolean bRet = false;
    if (null == p_altro)
      return bRet;
    switch (this) {
      case Barrato:
        bRet = p_altro.equals(Barrato);
        break;
      case Data:
        bRet = p_altro.equals(Data);
        break;
      case Float:
      case Importo:
        bRet = p_altro.equals(Float) || //
            p_altro.equals(Importo) ||
            p_altro.equals(Intero);
        break;
      case IntN15:
      case Intero:
        bRet = p_altro.equals(IntN15) || //
            p_altro.equals(Intero);
        break;
      case Stringa:
        bRet = p_altro.equals(Stringa);
        break;
      default:
        break;
    }
    return bRet;
  }

}
