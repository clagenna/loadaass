package prova.javafx.updtab;

import javafx.beans.property.SimpleStringProperty;
import sm.clagenna.stdcla.sql.DtsRow;

public class P04Intesta {

  private SimpleStringProperty idIntesta;
  private SimpleStringProperty nomeIntesta;
  private SimpleStringProperty dirFatture;

  public P04Intesta(String p_id, String p_no, String p_dir) {
    idIntesta = new SimpleStringProperty(p_id);
    nomeIntesta = new SimpleStringProperty(p_no);
    dirFatture = new SimpleStringProperty(p_dir);
  }

  public P04Intesta(DtsRow rec) {
    Object vv = rec.get("idIntesta");
    idIntesta = new SimpleStringProperty(String.valueOf(vv));
    vv = rec.get("nomeIntesta");
    nomeIntesta = new SimpleStringProperty((String) vv);
    vv = rec.get("dirFatture");
    dirFatture = new SimpleStringProperty((String) vv);
  }

  public String getIdIntesta() {
    return idIntesta.get();
  }

  public void setIdIntesta(String v) {
    idIntesta.set(v);
  }

  public String getNomeIntesta() {
    return nomeIntesta.get();
  }

  public void setNomeIntesta(String v) {
    nomeIntesta.set(v);
  }

  public String getDirFatture() {
    return dirFatture.get();
  }

  public void setDirFatture(String v) {
    dirFatture.set(v);
  }

}
