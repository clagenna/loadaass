package sm.clagenna.loadaass.dbsql.dtset;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javafx.scene.control.Alert.AlertType;
import sm.clagenna.loadaass.javafx.LoadAassMainApp;

public class Dts2Csv {
  private static final Logger s_log = LogManager.getLogger(Dts2Csv.class);

  private static String s_flds;
  private Dataset       m_dts;
  private StringBuffer  m_sb;

  static {
    s_flds = ";";
  }

  public Dts2Csv(Dataset p_d) {
    m_dts = p_d;
    initBuffer();
  }

  public static void setFldSep(String p_s) {
    s_flds = p_s;
  }

  private void initBuffer() {
    String lNl = System.lineSeparator();
    m_sb = new StringBuffer();
    // creo l'header
    m_sb.append("sep=").append(s_flds).append(lNl);
    for (DtsCol col : m_dts.getColumns().getColumns()) {
      m_sb.append(col.getName()).append(s_flds);
    }
    m_sb.append(lNl);
    // creo le righe
    for (DtsRow rig : m_dts.getRighe()) {
      for (Object val : rig.getValues()) {
        if (val != null)
          m_sb.append(val.toString().replace(",", "."));
        m_sb.append(s_flds);
      }
      m_sb.append(lNl);
    }
  }

  public void saveFile(String p_szFilNam) {
    try {
      Files.write(Paths.get(p_szFilNam), m_sb.toString().getBytes(StandardCharsets.UTF_8));
      String szMsg =String.format( "Scritto il file CSV: <b>%s</b>", p_szFilNam);
      LoadAassMainApp.getInst().messageDialog(AlertType.INFORMATION, szMsg);
    } catch (IOException e) {
      String szMsg = String.format("Errore scrittura %s, err=%s", p_szFilNam, e.getMessage());
      LoadAassMainApp.getInst().messageDialog(AlertType.ERROR, szMsg);
      s_log.error(szMsg, e);
    }
  }

}
