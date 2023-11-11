package sm.clagenna.loadaass.dbsql.dtset;

import lombok.Getter;
import lombok.Setter;

public class DtsCol {
  /** Il nome <b>univoco</b> e <b>case insensitive</b> della colonna */
  @Getter @Setter
  private String   name;
  /** la posizione 0-based nel dataset */
  @Getter @Setter
  private int      index;
  @Getter @Setter
  private SqlTypes type;
  @Getter @Setter
  private String   format;
  @Getter
  private boolean  inferredDate;

  public DtsCol() {
    index = -1;
  }

  public void setInferredDate(boolean bv) {
    // la prima data valida inferisce
    inferredDate |= bv;
  }

  @Override
  public String toString() {
    String szRet = "col:";
    szRet += name != null ? name : "??name??";
    szRet += index >= 0 ? String.format("(%d)", index) : "(?)";
    szRet += type != null ? "[" + type + "]" : "[??type??]";
    return szRet;
  }
}
