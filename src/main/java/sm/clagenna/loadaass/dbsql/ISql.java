package sm.clagenna.loadaass.dbsql;

import java.sql.SQLException;

import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.data.TagValFactory;

public interface ISql {

  void init(TagValFactory p_fact, DBConn p_con);

  Logger getLog();

  void setRecIntesta(RecIntesta reci);

  boolean fatturaExist() throws SQLException;

  boolean letturaExist() throws SQLException;

  boolean consumoExist() throws SQLException;

  void deleteFattura() throws SQLException;

  void insertNewFattura() throws SQLException;

  void insertNewLettura() throws SQLException;

  void insertNewConsumo() throws SQLException;

}
