package sm.clagenna.loadaass.javafx;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URL;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.DBConnSQL;
import sm.clagenna.loadaass.dbsql.SqlServIntest;
import sm.clagenna.loadaass.sys.AppProperties;
import sm.clagenna.loadaass.sys.IStartApp;
import sm.clagenna.loadaass.sys.ex.ReadFattException;

public class LoadAassMainApp extends Application implements IStartApp {

  private static final Logger    s_log            = LogManager.getLogger(LoadAassMainApp.class);
  public static final String     CSZ_MAIN_APP_CSS = "LoadAassFX.css";
  @Getter
  private static LoadAassMainApp inst;

  @Getter @Setter
  private AppProperties          props;
  @Getter @Setter
  private Stage                  primaryStage;
  @Getter @Setter
  private IStartApp              controller;
  @Getter @Setter
  private DBConn                 connSQL;
  @Getter
  private SqlServIntest          intesta;

  public LoadAassMainApp() {
    //
  }

  @Override
  public void start(Stage p_primaryStage) throws Exception {
    setPrimaryStage(p_primaryStage);
    LoadAassMainApp.inst = this;
    initApp(null);

    URL url = getClass().getResource(LoadAassController.CSZ_FXMLNAME);
    if (url == null)
      url = getClass().getClassLoader().getResource(LoadAassController.CSZ_FXMLNAME);
    if (url == null)
      throw new FileNotFoundException(String.format("Non trovo reource %s", LoadAassController.CSZ_FXMLNAME));
    Parent radice = FXMLLoader.load(url);
    Scene scene = new Scene(radice, 725, 550);

    // <a target="_blank" href="https://icons8.com/icon/Qd0k8d5D0tSe/invoice">Invoice</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
    primaryStage.getIcons().add(new Image("sm/clagenna/loadaass/icon/icona-fattura.png"));

    url = getClass().getResource(LoadAassMainApp.CSZ_MAIN_APP_CSS);
    if (url == null)
      url = getClass().getClassLoader().getResource(LoadAassMainApp.CSZ_MAIN_APP_CSS);
    scene.getStylesheets().add(url.toExternalForm());

    primaryStage.setScene(scene);
    primaryStage.show();
  }

  @Override
  public void initApp(AppProperties p_props) {
    try {
      AppProperties.setSingleton(false);
      props = new AppProperties();
      props.leggiPropertyFile(new File(AppProperties.CSZ_PROPERTIES), false, false);

      int px = props.getIntProperty(AppProperties.CSZ_PROP_POSFRAME_X);
      int py = props.getIntProperty(AppProperties.CSZ_PROP_POSFRAME_Y);
      int dx = props.getIntProperty(AppProperties.CSZ_PROP_DIMFRAME_X);
      int dy = props.getIntProperty(AppProperties.CSZ_PROP_DIMFRAME_Y);
      if ( (px * py) != 0) {
        primaryStage.setX(px);
        primaryStage.setY(py);
        primaryStage.setWidth(dx);
        primaryStage.setHeight(dy);
      }
    } catch (ReadFattException l_e) {
      LoadAassMainApp.s_log.error("Errore in main initApp: {}", l_e.getMessage(), l_e);
      System.exit(1957);
    }
    try {
      connSQL = new DBConnSQL();
      connSQL.doConn();
      intesta = new SqlServIntest(connSQL);
    } catch (Exception e) {
      s_log.error("Errore apertura DB, error={}", e.getMessage(), e);
    }
  }

  @Override
  public void stop() throws Exception {
    AppProperties prop = getProps();
    closeApp(prop);
    super.stop();
  }

  public static void main(String[] args) {
    Application.launch(args);
  }

  @Override
  public void closeApp(AppProperties prop) {
    Scene sce = primaryStage.getScene();
    double px = sce.getWindow().getX();
    double py = sce.getWindow().getY();
    double dx = sce.getWindow().getWidth();
    double dy = sce.getWindow().getHeight();

    prop.setProperty(AppProperties.CSZ_PROP_POSFRAME_X, (int) px);
    prop.setProperty(AppProperties.CSZ_PROP_POSFRAME_Y, (int) py);
    prop.setProperty(AppProperties.CSZ_PROP_DIMFRAME_X, (int) dx);
    prop.setProperty(AppProperties.CSZ_PROP_DIMFRAME_Y, (int) dy);

    if (controller != null)
      controller.closeApp(prop);

    prop.salvaSuProperties();
  }

}
