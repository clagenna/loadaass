package prova.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;

import org.junit.Test;
import org.sqlite.SQLiteConfig;
import org.sqlite.SQLiteConfig.Pragma;

import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.DBConnSQLite;
import sm.clagenna.loadaass.sys.AppProperties;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

public class ProvaSQLite {

  private AppProperties m_prop;
  private DBConn        m_db;
  private Connection    m_conn;

  public ProvaSQLite() {
    //
  }

  @Test
  public void doTheJob() throws ReadFattPropsException, SQLException {
    m_prop = new AppProperties();
    m_prop.leggiPropertyFile("loadAASS.properties");
    apriDbSqlite();
    // changePragma();
    leggiRighe();
  }

  private void apriDbSqlite() {
    m_db = new DBConnSQLite();
    m_conn = m_db.doConn();
  }

  @SuppressWarnings("unused")
  private void changePragma() throws SQLException {
    SQLiteConfig conf = new SQLiteConfig();
    Properties prop = conf.toProperties();
    prop.setProperty(Pragma.DATE_STRING_FORMAT.pragmaName, "yyyy-MM-dd");
    String szUrl = m_db.getURL();
    m_conn = DriverManager.getConnection(szUrl, prop);
  }

  private void leggiRighe() throws SQLException {
    String szQry = "SELECT idEEConsumo," //
        + "       idEEFattura," //
        + "       tipoSpesa," //
        + "       dtIniz," //
        + "       dtFine," //
        + "       prezzoUnit," //
        + "       quantita," //
        + "       importo" //
        + "  FROM EEConsumo;";
    PreparedStatement m_stmt_cerca_consumo = m_conn.prepareStatement(szQry);
    System.out.println("idEEConsumo\tidEEFattura\ttipoSpesa\tdtIniz\tdtFine\tprezzoUnit\tquantita\timporto");
    try (ResultSet res = m_stmt_cerca_consumo.executeQuery()) {
      while (res.next()) {
        int k = 1;
        int idConsumo = res.getInt(k++);
        int idEEFattura = res.getInt(k++);
        String sztipoSpesa = res.getString(k++);
        Date dtIniz = res.getDate(k++);
        Date dtFine = res.getDate(k++);
        Double prezzoUnit = res.getDouble(k++);
        int quantita = res.getInt(k++);
        float importo = res.getFloat(k++);
        System.out.printf("%d\t%d\t%s\t%s\t%s\t%f\t%d\t%f\n" //
            , idConsumo //
            , idEEFattura //
            , sztipoSpesa //
            , dtIniz //
            , dtFine//
            , prezzoUnit //
            , quantita //
            , importo //
        );
      }

    }
  }
}
