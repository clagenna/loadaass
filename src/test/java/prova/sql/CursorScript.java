package prova.sql;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CursorScript {

  @SuppressWarnings("unused")
  public static void main(String[] args) {
    String motorePort = "localhost";
    String dbname = "aass";
    String schemaNam = "dbo";
    String taboview = "GASFattura";
    boolean chToVarch = true;
    String usr = "sqlgianni";
    String psw = "sicuelserver";

    // Prompt for input if not provided
    //        if (args.length < 3) {
    //            // Prompt for Motore SQL e port
    //            motorePort = askParam("Motore SQL e port", true, false);
    //
    //            // Prompt for Database name
    //            dbname = askParam("Dammi il nome DataBase", true, false);
    //
    //            // Prompt for Tabella o View name
    //            taboview = askParam("Nome Tabella o View", true, false);
    //        } else {
    //            motorePort = args[0];
    //            dbname = args[1];
    //            taboview = args[2];
    //        }

    // Prompt for Trasformo i char in varchar
    // String chToVarchInput = CursorScript.askParam("Trasformo i char in varchar", true, false);
    // if (chToVarchInput.equalsIgnoreCase("false")) {
    chToVarch = true;
    // }

    String dbUser = CursorScript.decryptPassword(usr);
    String dbPass = CursorScript.decryptPassword(psw);

    String sqlFile = "c:\\temp\\Cursor_" + dbname + "_" + taboview + ".sql";

    if (CursorScript.fileExists(sqlFile)) {
      System.out.println("Esiste il file: " + sqlFile);
      System.out.println("Lo Cancello !");
      CursorScript.deleteFile(sqlFile);
    }

    String qryPK = "SELECT syscolumns.name AS colonna, " //
        + "systypes.name AS tipo, " //
        + "systypes.length AS LenTipo, " //
        + "syscolumns.length AS lung, " //
        + "syscolumns.colid, " //
        + "sysindexes.name AS KeyName " //
        + "FROM syscolumns " //
        + "INNER JOIN sysindexkeys " //
        + "ON syscolumns.id = sysindexkeys.id " //
        + "AND syscolumns.colid = sysindexkeys.colid " + "INNER JOIN systypes " //
        + "ON syscolumns.xtype = systypes.xtype " //
        + "INNER JOIN sysobjects " //
        + "ON syscolumns.id = sysobjects.id " //
        + "INNER JOIN sysindexes " //
        + "ON syscolumns.id = sysindexes.id " //
        + "WHERE 1=1 " //
        + "AND sysindexkeys.indid = 1 " //
        + "AND sysindexes.indid = 1 " //
        + "AND systypes.xusertype < 256 " //
        + "AND sysobjects.name = '" + taboview + "' " //
        + "ORDER BY sysobjects.name, syscolumns.colid";

    String sqlCols = "SELECT syscolumns.name AS colonna, " //
        + "systypes.name AS tipo, " //
        + "systypes.length AS LenTipo, " //
        + "syscolumns.length AS lung, " //
        + "syscolumns.colid " //
        + "FROM syscolumns " //
        + "INNER JOIN systypes " //
        + "ON syscolumns.xtype = systypes.xtype " //
        + "INNER JOIN sysobjects " //
        + "ON syscolumns.id = sysobjects.id " //
        + "WHERE systypes.xusertype < 256 " //
        + "AND sysobjects.name = '" + taboview + "' " //
        + "ORDER BY syscolumns.colid";

    sqlCols = "SELECT * " //
        + "FROM INFORMATION_SCHEMA.COLUMNS " //
        + "WHERE 1=1 " //
        + "AND TABLE_SCHEMA=N'" + schemaNam + "' " //
        + "AND TABLE_NAME=N'" + taboview + "'";

    try {
      String szURL = "jdbc:sqlserver://" + motorePort // 
          + ";databaseName=" + dbname + ";" // 
          + "encrypt=false;" //
          + "trustServerCertificate=false;" //
          + "loginTimeout=10;";

      Connection conn = DriverManager.getConnection(szURL, dbUser, dbPass);
      Statement stmt = conn.createStatement();

      ResultSet rs = stmt.executeQuery(qryPK);
      String primKey = "";
      while (rs.next()) {
        String colonna = rs.getString("colonna");
        String tipo = rs.getString("tipo");
        primKey += "\t" + colonna + "\t" + tipo + "\n";
      }
      rs.close();

      rs = stmt.executeQuery(sqlCols);
      String allCols = "";
      String allColsVar = "";
      while (rs.next()) {
        String colonna = rs.getString("COLUMN_NAME");
        String tipo = rs.getString("DATA_TYPE");
        allCols += colonna + ",\n";
        allColsVar += "@" + colonna + ",\n";
      }
      rs.close();

      stmt.close();
      conn.close();

      String script = "USE " + dbname + "\n\n" //
          + "-- =============================================\n" //
          + "-- Metti una descrizione qui\n" //
          + "-- =============================================\n" //
          + "SET NOCOUNT ON\n\n" //
          + "DECLARE curs_" + taboview + " CURSOR READ_ONLY FOR\n" //
          + "SELECT " + allCols + "\n" //
          + "FROM " + schemaNam + "." + taboview + "\n" //
          + "WHERE 1=1\n\n" //
          + "OPEN curs_" + taboview + "\n\n" //
          + "FETCH NEXT FROM curs_" + taboview + " INTO " + allColsVar + "\n\n" //
          + "WHILE (@@fetch_status <> -1)\n" //
          + "BEGIN\n" //
          + "\tIF (@@fetch_status <> -2)\n" //
          + "\tBEGIN\n" + "\t\t-- Metti il codice cursore qui !\n" //
          + "\t\tPRINT 'Rigo letto '\n" //
          + "\tEND\n\n" //
          + "\tFETCH NEXT FROM curs_" + taboview + " INTO " + allColsVar + "\n" //
          + "END\n\n" //
          + "CLOSE curs_" + taboview + "\n" //
          + "DEALLOCATE curs_" + taboview + "\n\n" //
          + "GO";

      CursorScript.writeToFile(sqlFile, script);
      System.out.println("Scritto file: " + sqlFile);
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public static String askParam(String message, boolean mandatory, boolean defaultValue) {
    // Prompt for input and return the value
    return null;
  }

  public static String decryptPassword(String password) {
    return password;
  }

  public static boolean fileExists(String filePath) {
    return Files.exists(Paths.get(filePath));
  }

  public static void deleteFile(String filePath) {
    System.out.println("CursorScript.deleteFile()=" + filePath);
  }

  public static void writeToFile(String filePath, String content) {
    System.out.println(content);
  }
}
