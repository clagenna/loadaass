package sm.clagenna.loadaass.sys;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.Date;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

public class AppProperties {
  private static final Logger  s_log               = LogManager.getLogger(AppProperties.class);
  private static boolean       s_singleton         = true;
  private static AppProperties s_inst;
  public static final String   CSZ_PROPERTIES      = "LoadAass.properties";

  public static final String   CSZ_PROP_LASTDIR    = "last.dir";
  public static final String   CSZ_PROP_LASTFIL    = "last.fil";
  public static final String   CSZ_PROP_DIMFRAME_X = "frame.dimx";
  public static final String   CSZ_PROP_DIMFRAME_Y = "frame.dimy";
  public static final String   CSZ_PROP_POSFRAME_X = "frame.posx";
  public static final String   CSZ_PROP_POSFRAME_Y = "frame.posy";

  public static final String   CSZ_PROP_DB_Type    = "DB.Type";
  public static final String   CSZ_PROP_DB_Host    = "DB.Host";
  public static final String   CSZ_PROP_DB_name    = "DB.name";
  public static final String   CSZ_PROP_DB_user    = "DB.user";
  public static final String   CSZ_PROP_DB_passwd  = "DB.passwd";
  public static final String   CSZ_PROP_DB_service = "DB.service";

  private Properties           properties;
  private File                 propertyFile;
  /**
   * codoe X email di servizio, non pertinenti ad un OE specifico ma prettamente
   * applicativo. Numero fittizio di OE *non* ESISTENTE
   */
  public static final String   PROP_BASE_DIR       = "app.basedir";

  public AppProperties() throws ReadFattPropsException {
    if (AppProperties.isSingleton()) {
      if (AppProperties.s_inst == null)
        AppProperties.s_inst = this;
      else {
        throw new ReadFattPropsException("App Prop. gia istanziato !");
      }
    } /*
       * else AppProperties.s_inst = this;
       */
  }

  public static AppProperties getInstance() {
    if ( !AppProperties.isSingleton())
      throw new UnsupportedOperationException("AppProperties *NON* è singleton!");
    return AppProperties.s_inst;
  }

  public static void setSingleton(boolean bv) {
    s_singleton = bv;
  }

  public static boolean isSingleton() {
    return s_singleton;
  }

  public Properties getProperties() {
    if (properties == null)
      properties = new Properties();
    return properties;
  }

  /**
   * @see #getPropertyFile()
   */
  public void setPropertyFile(File p_fiProp) {
    if (Utils.isChanged(p_fiProp, propertyFile)) {
      propertyFile = p_fiProp;
    }
  }

  public Properties leggiPropertyFile() throws ReadFattPropsException {
    return leggiPropertyFile(getPropertyFile(), true, true);
  }

  public Properties leggiPropertyFile(Path p_fiProp) throws ReadFattPropsException {
    return leggiPropertyFile(p_fiProp.toFile(), true, true);
  }

  public Properties leggiPropertyFile(String p_fiProp) throws ReadFattPropsException {
    return leggiPropertyFile(new File(p_fiProp), true, true);
  }

  public Properties leggiPropertyFile(String p_fiProp, boolean bForce) throws ReadFattPropsException {
    return leggiPropertyFile(new File(p_fiProp), bForce, true);
  }

  @SuppressWarnings("unused")
  public Properties leggiPropertyFile(File p_fiProp, boolean bForce, boolean bResJar) throws ReadFattPropsException {
    properties = new Properties();
    if ( !bResJar) {
      if (p_fiProp == null || !p_fiProp.exists()) {
        if (bForce)
          throw new ReadFattPropsException(
              "Il file properties non esiste:" + (p_fiProp != null ? p_fiProp.getAbsolutePath() : "*NULL*"));
        else
          return properties;
      }
    }
    // System.out.println("Apro il file di  properties:" + p_fiProp.getAbsolutePath());
    s_log.info("Apro il file di  properties: {}", p_fiProp.getAbsolutePath());
    propertyFile = p_fiProp;
    setPropertyFile(p_fiProp);
    if ( !bResJar) {
      // leggo dal direttorio
      try (InputStream is = new FileInputStream(p_fiProp)) {
        if (is != null)
          properties.load(is);
        else
          s_log.error("property file {} null!", p_fiProp.getAbsolutePath());
        setPropertyFile(p_fiProp);
      } catch (IOException e) {
        s_log.error("Errore apertura property file {}", p_fiProp.getAbsolutePath(), e);
      }
    } else {
      // leggo come risorsa intena al JAR
      String szFi = String.format("/%s", p_fiProp.getName());
      try (InputStream is = AppProperties.class.getResourceAsStream(szFi)) {
        if (is != null)
          properties.load(is);
        else
          s_log.error("property file {} null!", p_fiProp.getAbsolutePath());
        setPropertyFile(p_fiProp);
      } catch (IOException e) {
        s_log.error("Errore apertura property file {}", p_fiProp.getAbsolutePath(), e);
      }
    }
    // e.printStackTrace();
    // System.err.println("Errore apertura property file:" + p_fiProp.getAbsolutePath() + " " + e);
    return properties;
  }

  public void salvaSuProperties() {
    if (propertyFile == null)
      propertyFile = new File(CSZ_PROPERTIES);
    try (FileOutputStream fos = new FileOutputStream(getPropertyFile())) {
      properties.store(fos, Utils.s_fmtY4MDHMS.format(new Date()));
      s_log.info("salvato properties sul file:{}", getPropertyFile().getAbsolutePath());
    } catch (IOException e) {
      s_log.error("Errore in salvataggio delle properties:{} err={}", getPropertyFile().getAbsolutePath(), e.getMessage());
    }
  }

  public String getProperty(String p_propName) {
    String szValue = null;
    Object obj = getProperties().get(p_propName);
    if (obj != null)
      szValue = obj.toString().trim();
    else
      s_log.trace("La property {} torna valore *NULL*", p_propName);
    return szValue;
  }

  public void setProperty(String p_propName, String p_value) {
    getProperties();
    if (Utils.isValue(p_value))
      properties.setProperty(p_propName, p_value);
    else
      properties.remove(p_propName);
  }

  public void setProperty(String p_name, int p_width) {
    setProperty(p_name, String.valueOf(p_width));
  }

  public int getIntProperty(String p_propName, int p_defVal) {
    int ret = getIntProperty(p_propName);
    if (ret == -1)
      ret = p_defVal;
    return ret;
  }
  
  public int getIntProperty(String p_propName) {
    int nRet = -1;
    String sz = getProperty(p_propName);
    try {
      if ( sz != null) 
        nRet = Integer.parseInt(sz);
    } catch (NumberFormatException e) {
      // 
    }
    return nRet;
  }

  public boolean getBooleanProperty(String p_prop) {
    boolean bRet = false;
    String sz = getProperty(p_prop);
    if (sz != null) {
      switch (sz) {
        case "0":
        case "n":
        case "no":
          bRet = false;
          break;
        case "-1":
        case "1":
        case "s":
        case "y":
        case "si":
        case "yes":
          bRet = true;
          break;
        default:
          bRet = Boolean.parseBoolean(sz);
          break;
      }
    }
    return bRet;
  }

  public File getPropertyFile() {
    return this.propertyFile;
  }

  public void reset() {
    if (properties != null)
      properties.clear();
    properties = null;
    propertyFile = null;
  }

  public String getLastFile() {
    getProperties();
    return properties.getProperty(CSZ_PROP_LASTFIL);
  }

  public void setLastFile(String p_last) {
    getProperties();
    properties.setProperty(CSZ_PROP_LASTFIL, p_last);
  }

  public String getLastDir() {
    getProperties();
    return properties.getProperty(CSZ_PROP_LASTDIR);
  }

  public void setLastDir(String p_last) {
    getProperties();
    properties.setProperty(CSZ_PROP_LASTDIR, p_last);
  }

}
