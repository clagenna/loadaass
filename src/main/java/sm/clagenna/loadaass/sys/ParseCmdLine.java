package sm.clagenna.loadaass.sys;

import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Paths;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.ETipoFatt;
import sm.clagenna.loadaass.sys.ex.ReadFattCmdLineException;

public class ParseCmdLine {

  private static final Logger s_log           = LogManager.getLogger(ParseCmdLine.class);
  private static ParseCmdLine s_inst;

  public static final String  CSZ_PDFINPUT    = "f";
  public static final String  CSZ_PROPERTY    = "p";
  public static final String  CSZ_TIPOFATT    = "t";
  public static final String  CSZ_GENTEXT     = "gt";
  public static final String  CSZ_GENTAGFFILE = "gg";
  public static final String  CSZ_GENHTMLFILE = "gh";
  public static final String  CSZ_LANCIAEXCEL = "e";
  public static final String  CSZ_OVERWRITE   = "o";
  public static final String  CSZ_LOGLEVEL    = "lv";

  private Options             m_opt;
  @Getter @Setter
  private String              propertyFile;
  @Getter @Setter
  private String              PDFFatt;
  @Getter @Setter
  private boolean             genPDFText;
  @Getter @Setter
  private boolean             genTagFile;
  @Getter @Setter
  private boolean             genHTMLFile;
  @Getter @Setter
  private boolean             LanciaExcel;
  @Getter @Setter
  private boolean             overwrite;
  @Getter @Setter
  private ETipoFatt           tipoFatt;
  @Getter @Setter
  private Level               logLevel;

  public ParseCmdLine() {
    s_inst = this;
    creaOtions();
  }

  public static ParseCmdLine getInst() {
    return s_inst;
  }

  private void creaOtions() {
    m_opt = new Options();
    m_opt.addOption(CSZ_PDFINPUT, true, "Il file PDF fattura ");
    m_opt.getOption(CSZ_PDFINPUT).setRequired(true);
    m_opt.addOption(CSZ_PROPERTY, true, "Il Property File per il tipo fattura");
    //    m_opt.getOption(CSZ_PROPERTY).setRequired(true);
    m_opt.addOption(CSZ_TIPOFATT, true, "Il Tipo di fattura (H2O,EE,GAS)");
    m_opt.addOption(CSZ_LOGLEVEL, true, "Il Tipo di Log Level (TRACE,DEBUG,INFO,WARN,ERROR)");

    m_opt.addOption(CSZ_GENTAGFFILE, false, "Genera il tag file");
    m_opt.addOption(CSZ_GENTEXT, false, "Genera file di testo");
    m_opt.addOption(CSZ_GENHTMLFILE, false, "Genera HTML dal PDF");

    m_opt.addOption(CSZ_LANCIAEXCEL, false, "Lancia Excel del file convertito");

    m_opt.addOption(CSZ_OVERWRITE, false, "Sovrascivi (previa cancellazione) dell'intera fattura");
  }

  public void parse(String[] p_args) throws ReadFattCmdLineException {
    CommandLineParser prs = new DefaultParser();
    try {
      CommandLine cmd = prs.parse(m_opt, p_args);
      discerniCommandi(cmd);
    } catch (ParseException e) {
      s_log.error("Parse cmd error", e);
      throw new ReadFattCmdLineException("Parse cmd line", e);
    }
  }

  private void discerniCommandi(CommandLine p_cmd) throws ReadFattCmdLineException {
    if ( !p_cmd.hasOption(CSZ_PDFINPUT)) {
      printUsage();
      throw new ReadFattCmdLineException("Il nome del file fattura e\' obbligatorio");
    }
    setPDFFatt(p_cmd.getOptionValue(CSZ_PDFINPUT));
    if (p_cmd.hasOption(CSZ_PROPERTY))
      setPropertyFile(p_cmd.getOptionValue(CSZ_PROPERTY));
    if ( !p_cmd.hasOption(CSZ_TIPOFATT))
      setTipoFatt(ETipoFatt.parse(p_cmd.getOptionValue(CSZ_TIPOFATT)));

    genPDFText = p_cmd.hasOption(CSZ_GENTEXT);
    genTagFile = p_cmd.hasOption(CSZ_GENTAGFFILE);
    genHTMLFile = p_cmd.hasOption(CSZ_GENHTMLFILE);

    LanciaExcel = p_cmd.hasOption(CSZ_LANCIAEXCEL);
    overwrite = p_cmd.hasOption(CSZ_OVERWRITE);
    String szLv = "DEBUG";
    if (p_cmd.hasOption(CSZ_LOGLEVEL)) {
      szLv = p_cmd.getOptionValue(CSZ_LOGLEVEL).toUpperCase();
    }
    logLevel = Level.getLevel(szLv);
    if (logLevel == null)
      throw new ReadFattCmdLineException("Non interpreto il Log Level=" + szLv);
    if ( !Files.exists(Paths.get(getPDFFatt()), LinkOption.NOFOLLOW_LINKS))
      throw new ReadFattCmdLineException("Non esiste PDF =" + PDFFatt);
    //    if ( !Files.exists(Paths.get(getPropertyFile()), LinkOption.NOFOLLOW_LINKS))
    //      throw new ReadFattCmdLineException("Non esiste Property file=" + PDFFatt);
  }

  private void printUsage() {
    HelpFormatter fmtr = new HelpFormatter();
    fmtr.printHelp("Usage:", m_opt);
  }

}
