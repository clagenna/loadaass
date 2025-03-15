package prova.sql;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.text.ParseException;
import java.util.Date;
import java.util.Properties;

import org.junit.Test;
import org.sqlite.SQLiteConfig;
import org.sqlite.SQLiteConfig.Pragma;

import sm.clagenna.stdcla.sql.DBConn;
import sm.clagenna.stdcla.sql.DBConnFactory;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.loadaass.dbsql.SqlServIntest;
import sm.clagenna.stdcla.utils.AppProperties;
import sm.clagenna.stdcla.utils.Utils;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;

public class ProvaSQLiteMetadata {

  private AppProperties m_prop;
  private DBConn        m_db;
  private Connection    m_conn;
  @SuppressWarnings("unused")
  private SqlServIntest intesta;
  private int           widthCh = 12;

  public ProvaSQLiteMetadata() {
    //
  }

  @Test
  public void doTheJob() throws ReadFattPropsException, SQLException, ParseException, AppPropsException {
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
    intesta = new SqlServIntest(m_db);
  }

  @SuppressWarnings("unused")
  private void changePragma() throws SQLException {
    SQLiteConfig conf = new SQLiteConfig();
    Properties prop = conf.toProperties();
    prop.setProperty(Pragma.DATE_STRING_FORMAT.pragmaName, "yyyy-MM-dd");
    String szUrl = m_db.getURL();
    m_conn = DriverManager.getConnection(szUrl, prop);
  }

  private void leggiRighe() throws SQLException, ParseException {
    String szQry = "SELECT idEEConsumo," //
        + "       idEEFattura," //
        + "       tipoSpesa," //
        + "       dtIniz," //
        + "       dtFine," //
        + "       prezzoUnit," //
        + "       quantita," //
        + "       importo" //
        + "  FROM EEConsumo;";
    szQry = "SELECT chiave," + "       stringa," + "       intero," + "       prezzo," + "       dataoggi," + "       percento"
        + "  FROM prova;";

    PreparedStatement m_stmt_cerca_consumo = m_conn.prepareStatement(szQry);
    String szIntest = provaMetadata(m_stmt_cerca_consumo);
    String[] szInt = szIntest.split(";");
    // System.out.println("idEEConsumo\tidEEFattura\ttipoSpesa\tdtIniz\tdtFine\tprezzoUnit\tquantita\timporto");
    System.out.println(szInt[0]);
    try (ResultSet res = m_stmt_cerca_consumo.executeQuery()) {
      while (res.next()) {
        int k = 1;
        int idConsumo = res.getInt(k++);
        int idEEFattura = res.getInt(k++);
        String sztipoSpesa = res.getString(k++);
        Date dtIniz = Utils.s_fmtY4MD.parse(res.getString(k++));
        Date dtFine = Utils.s_fmtY4MD.parse(res.getString(k++));
        Double prezzoUnit = res.getDouble(k++);
        int quantita = res.getInt(k++);
        float importo = res.getFloat(k++);
        try {
          System.out.printf(szInt[1] + "\n" //
              , idConsumo //
              , idEEFattura //
              , sztipoSpesa //
              , dtIniz //
              , dtFine//
              , prezzoUnit //
              , quantita //
              , importo //
          );
        } catch (Exception e) {
          System.err.println(szInt[1]);
          e.printStackTrace();
        }
      }
    }
  }

  private String provaMetadata(PreparedStatement p_stmt) throws SQLException {
    StringBuilder sb = new StringBuilder();
    StringBuilder sbFmt = new StringBuilder();
    String szVirg = "";
    int decplace = 6;
    ResultSetMetaData rsmd = p_stmt.getMetaData();
    int colCount = rsmd.getColumnCount();
    String szFmtNam = String.format("%%-%ds", widthCh);
    for (int i = 1; i <= colCount; i++) {
      String szNam = String.format(szFmtNam, rsmd.getColumnName(i));
      int nTyp = rsmd.getColumnType(i);
      String szTyp = "";
      String szFmt = "";
      switch (nTyp) {
        case Types.INTEGER:
          szFmt = String.format("%%%dd", widthCh);
          szTyp = "INTEGER";
          break;
        case Types.VARCHAR:
          szFmt = String.format("%%-%ds", widthCh);
          szTyp = "VARCHAR";
          break;
        case Types.NUMERIC:
          szFmt = String.format("%%-%ds", widthCh);
          szTyp = "NUMERIC";
          break;
        case Types.DECIMAL:
          szFmt = String.format("%%%d.%df", widthCh, decplace);
          szTyp = "DECIMAL";
          break;
        case Types.FLOAT:
          szFmt = String.format("%%%d.%df", widthCh, decplace);
          szTyp = "FLOAT";
          break;
        case Types.DOUBLE:
          szFmt = String.format("%%%d.%df", widthCh, decplace);
          szTyp = "DOUBLE";
          break;
        case Types.REAL:
          szFmt = String.format("%%%d.%df", widthCh, decplace);
          szTyp = "REAL";
          break;
        case Types.DATE:
          szFmt = String.format("%%%ds", 30);
          szTyp = "DATE";
          break;
        default:
          System.err.printf("Non interpreto tipo %d per col %s\n", nTyp, szNam);
          break;
      }
      System.out.printf("%16s{%s}=%s\n", szNam, szTyp, szFmt);
      sb.append(szVirg).append(szNam);
      sbFmt.append(szVirg).append(szFmt);
      szVirg = szVirg.length() == 0 ? "\t" : szVirg;
    }
    return sb.toString() + ";" + sbFmt.toString();
  }
}
