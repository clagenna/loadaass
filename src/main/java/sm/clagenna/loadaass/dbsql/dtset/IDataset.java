package sm.clagenna.loadaass.dbsql.dtset;

public interface IDataset {
  
  DtsCols getColumns();

  void restart();

  DtsRow getRow();

  boolean hasNext();

  int next();

  Object getValue(String colNam);

  int getRowNumber();

}
