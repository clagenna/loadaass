package sm.clagenna.loadaass.dbsql;

import java.nio.file.Path;
import java.sql.SQLException;

import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.enums.ETipoFatt;

public interface ISql {

  void init(TagValFactory p_fact, DBConn p_con, Path p_path);

  Logger getLog();

  void setTipoFatt(ETipoFatt p_tipoFatt);

  void setRecIntesta(RecIntesta reci);

  boolean fatturaExist() throws SQLException;

  boolean letturaExist() throws SQLException;

  boolean consumoExist() throws SQLException;

  void deleteFattura() throws SQLException;

  void insertNewFattura() throws SQLException;

  void insertNewLettura() throws SQLException;

  void insertNewConsumo() throws SQLException;

}
