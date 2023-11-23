package sm.clagenna.loadaass.data;

import javafx.beans.property.SimpleStringProperty;
import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.dtset.DtsRow;
import sm.clagenna.loadaass.sys.Utils;

public class RecIntesta {
  public static final String COL_ID_INTESTA   = "idIntesta";
  public static final String COL_NOME_INTESTA = "nomeIntesta";
  public static final String COL_DIR_FATTURE  = "dirFatture";

  private SimpleStringProperty idIntesta;
  private SimpleStringProperty nomeIntesta;
  private SimpleStringProperty dirFatture;
  @Getter @Setter
  private boolean              changed;

  public RecIntesta(int p_id, String p_no, String p_dir) {
    idIntesta = new SimpleStringProperty(String.valueOf(p_id));
    nomeIntesta = new SimpleStringProperty(p_no);
    dirFatture = new SimpleStringProperty(p_dir);
    setChanged(false);
  }

  public RecIntesta(String p_id, String p_no, String p_dir) {
    idIntesta = new SimpleStringProperty(p_id);
    nomeIntesta = new SimpleStringProperty(p_no);
    dirFatture = new SimpleStringProperty(p_dir);
    setChanged(false);
  }

  public RecIntesta(DtsRow rec) {
    Object vv = rec.getValue(COL_ID_INTESTA);
    idIntesta = new SimpleStringProperty(String.valueOf(vv));
    vv = rec.getValue(COL_NOME_INTESTA);
    nomeIntesta = new SimpleStringProperty((String) vv);
    vv = rec.getValue(COL_DIR_FATTURE);
    dirFatture = new SimpleStringProperty((String) vv);
    setChanged(false);
  }

  public String getIdIntesta() {
    return idIntesta.get();
  }

  public Integer getIdIntestaInt() {
    String sz = idIntesta.get();
    if (sz == null)
      return null;
    Integer ii = Integer.parseInt(sz);
    return ii;
  }

  public void setIdIntestaInt(int p_maxId) {
    String sz = String.valueOf(p_maxId);
    if (Utils.isChanged(sz, getIdIntesta()))
      setChanged(true);
    idIntesta.set(sz);
  }

  public void setIdIntesta(String v) {
    if (Utils.isChanged(v, getIdIntesta())) {
      idIntesta.set(v);
      setChanged(true);
    }
  }

  public String getNomeIntesta() {
    return nomeIntesta.get();
  }

  public void setNomeIntesta(String v) {
    if (Utils.isChanged(v, getNomeIntesta())) {
      nomeIntesta.set(v);
      setChanged(true);
    }
  }

  public String getDirFatture() {
    return dirFatture.get();
  }

  public void setDirFatture(String v) {
    if (Utils.isChanged(v, getDirFatture())) {
      dirFatture.set(v);
      setChanged(true);
    }
  }

  public boolean updateOnDB(DBConn p_co) {
    boolean bRet = false;
    return bRet;
  }

  @Override
  public String toString() {
    return getNomeIntesta();
  }

}
