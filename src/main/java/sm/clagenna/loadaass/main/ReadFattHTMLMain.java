package sm.clagenna.loadaass.main;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.DBConnSQL;
import sm.clagenna.loadaass.sys.ILog4jReader;
import sm.clagenna.loadaass.sys.MioAppender;
import sm.clagenna.loadaass.sys.ParseCmdLine;
import sm.clagenna.loadaass.sys.ex.ReadFattException;

public class ReadFattHTMLMain implements ILog4jReader {

  private static final Logger s_log = LogManager.getLogger(ReadFattHTMLMain.class);
  @SuppressWarnings("unused")
  private static Level        s_logLev;

  private ParseCmdLine        m_cmdParse;
  @SuppressWarnings("unused")
  private String              m_lastLogMessage;

  static {
    s_logLev = s_log.getLevel();
  }

  public ReadFattHTMLMain() {
    //
  }

  public static void main(String[] args) {
    ReadFattHTMLMain app = new ReadFattHTMLMain();
    try {
      MioAppender.setLogReader(app);
      app.initCmdline(args);
      app.vaiColTango();
    } catch (ReadFattException e) {
      s_log.error("Parse cmd error", e);
    }
  }

  private void initCmdline(String[] p_args) throws ReadFattException {
    m_cmdParse = new ParseCmdLine();
    m_cmdParse.parse(p_args);
    // String fiProp = m_cmdParse.getPropertyFile();
  }

  public void vaiColTango() throws ReadFattException {
    Path pth = null;

    GestPDFFatt gpdf = new GestPDFFatt(m_cmdParse.getPDFFatt());
    String szPropFi = m_cmdParse.getPropertyFile();
    if (szPropFi != null) {
      pth = Paths.get(szPropFi);
      gpdf.setPropertyFile(pth);
    }

    gpdf.setGenPDFText(m_cmdParse.isGenPDFText());
    gpdf.setGenTagFile(m_cmdParse.isGenTagFile());
    gpdf.setGenHTMLFile(m_cmdParse.isGenHTMLFile());
    gpdf.setLanciaExcel(m_cmdParse.isLanciaExcel());
    try (DBConn connSQL = new DBConnSQL()) {
      connSQL.doConn();
      gpdf.setConnSql(connSQL);
      gpdf.convertiPDF();
    } catch (IOException e) {
      e.printStackTrace();
    }
    System.out.println(gpdf.toString());
  }

  @Override
  public void addLog(String[] p_arr) {
    // arr[0] - class triggering log + [rowNumber]
    // arr[1] - datetime of log
    // arr[2] - tipo log {DEBUG,INFO,..}
    // arr[3] - message to log
    m_lastLogMessage = p_arr[3];
  }
}
