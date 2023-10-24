package sm.clagenna.loadaass.main;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.LoggerContext;
import org.apache.logging.log4j.core.config.Configuration;
import org.apache.logging.log4j.core.config.LoggerConfig;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.DBConnSQL;
import sm.clagenna.loadaass.dbsql.SqlServIntest;
import sm.clagenna.loadaass.dbsql.SqlServIntest.RecIntesta;
import sm.clagenna.loadaass.sys.ILog4jReader;
import sm.clagenna.loadaass.sys.MioAppender;
import sm.clagenna.loadaass.sys.ex.ReadFattException;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

public class ReadFattHTMLMain implements ILog4jReader {

  private static final Logger s_log = LogManager.getLogger(ReadFattHTMLMain.class);
  @SuppressWarnings("unused")
  private static Level        s_logLev;

  private ParseCmdLine        m_cmdParse;
  @Getter @Setter
  private Level               logLevel;
  @SuppressWarnings("unused")
  private String              m_lastLogMessage;
  private SqlServIntest       recintesta;

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
    changeLogLevel();
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
    gpdf.setOverwrite(m_cmdParse.isOverwrite());

    try (DBConn connSQL = new DBConnSQL()) {
      connSQL.doConn();
      gpdf.setConnSql(connSQL);
      recintesta = new SqlServIntest(connSQL);
      RecIntesta intes = recintesta.get(m_cmdParse.getIntesta());
      if (intes == null)
        throw new ReadFattPropsException(String.format("L'intestatario \"%s\" non esiste nel DB", m_cmdParse.getIntesta()));
      gpdf.setRecIntesta(intes);
      gpdf.convertiPDF();
    } catch (IOException e) {
      s_log.error("Errore di conversione {}", gpdf.getPdfFile(), e);
      // e.printStackTrace();
    }
    // System.out.println(gpdf.toString());
  }

  @Override
  public void addLog(String[] p_arr) {
    // arr[0] - class triggering log + [rowNumber]
    // arr[1] - datetime of log
    // arr[2] - tipo log {DEBUG,INFO,..}
    // arr[3] - message to log
    m_lastLogMessage = p_arr[3];
  }

  /**
   * Vedi StackOverflow
   * {@linkplain https://stackoverflow.com/questions/23434252/programmatically-change-log-level-in-log4j2}
   */
  private void changeLogLevel() {
    ParseCmdLine cmd = ParseCmdLine.getInst();
    if (cmd.getLogLevel() == null)
      setLogLevel(Level.DEBUG);
    else
      setLogLevel(cmd.getLogLevel());
    LoggerContext ctx = (LoggerContext) LogManager.getContext(false);
    Configuration config = ctx.getConfiguration();
    LoggerConfig loggerConfig = config.getLoggerConfig(LogManager.ROOT_LOGGER_NAME);
    s_log.warn("Setto il Log Level a {}", logLevel.toString());
    loggerConfig.setLevel(logLevel);
    ctx.updateLoggers(); // This causes all Loggers to refetch information from their LoggerConfig.
  }

}
