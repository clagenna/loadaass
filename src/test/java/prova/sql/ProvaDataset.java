package prova.sql;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Properties;

import org.junit.Test;
import org.sqlite.SQLiteConfig;
import org.sqlite.SQLiteConfig.Pragma;

import sm.clagenna.stdcla.sql.DBConn;
import sm.clagenna.stdcla.sql.DBConnFactory;
import sm.clagenna.stdcla.sql.Dataset;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.stdcla.utils.AppProperties;
import sm.clagenna.loadaass.sys.ex.DatasetException;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

public class ProvaDataset {

  private AppProperties m_prop;
  private DBConn        m_db;
  @SuppressWarnings("unused")
  private Connection    m_conn;

  public ProvaDataset() {
    //
  }

  @Test
  public void doTheJob() throws ReadFattPropsException, SQLException, ParseException, DatasetException, IOException, AppPropsException {
    m_prop = new AppProperties();
    m_prop.leggiPropertyFile(new File("loadAass.properties"), true, false);
    apriDbSqlite();
    // changePragma();
    leggiRighe();
  }

  private void apriDbSqlite() {
    DBConnFactory conFact = new DBConnFactory();
    String szDbType = m_prop.getProperty(AppProperties.CSZ_PROP_DB_Type);
    m_db = conFact.get(szDbType);
    m_db.readProperties(m_prop);
    m_conn = m_db.doConn();
    // intesta = new SqlServIntest(m_db);
  }

  @SuppressWarnings("unused")
  private void changePragma() throws SQLException {
    SQLiteConfig conf = new SQLiteConfig();
    Properties prop = conf.toProperties();
    prop.setProperty(Pragma.DATE_STRING_FORMAT.pragmaName, "yyyy-MM-dd");
    String szUrl = m_db.getURL();
    m_conn = DriverManager.getConnection(szUrl, prop);
  }

  private void leggiRighe() throws SQLException, ParseException, DatasetException, IOException {
    String szQry = "SELECT idEEConsumo," //
        + "       idEEFattura," //
        + "       tipoSpesa," //
        + "       dtIniz," //
        + "       dtFine," //
        + "       prezzoUnit," //
        + "       quantita," //
        + "       importo" //
        + "  FROM EEConsumo;";
    szQry = "SELECT chiave," //
        + "       stringa," //
        + "       intero," //
        + "       prezzo," //
        + "       dataoggi," //
        + "       percento" //
        + "  FROM prova;";

    try (Dataset dtset = new Dataset(m_db)) {
      if ( !dtset.executeQuery(szQry)) {
        System.err.println("Lettura andata male !");
      }
    }
  }

}
