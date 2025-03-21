package sm.clagenna.loadaass.javafx;

import java.awt.Desktop;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.spi.StandardLevel;

import javafx.application.Platform;
import javafx.beans.Observable;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ListChangeListener;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Cursor;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.ComboBox;
import javafx.scene.control.ContextMenu;
import javafx.scene.control.Label;
import javafx.scene.control.ListCell;
import javafx.scene.control.ListView;
import javafx.scene.control.MenuItem;
import javafx.scene.control.SelectionMode;
import javafx.scene.control.SplitPane;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableRow;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.stage.DirectoryChooser;
import javafx.stage.Modality;
import javafx.stage.Stage;
import lombok.Getter;
import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.dbsql.SqlServIntest;
import sm.clagenna.loadaass.dbsql.SqlServPDFonDB;
import sm.clagenna.loadaass.main.GestPDFFatt;
import sm.clagenna.loadaass.sys.ex.ReadFattException;
import sm.clagenna.stdcla.javafx.IStartApp;
import sm.clagenna.stdcla.sql.DBConn;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.stdcla.sys.ex.Log4jException;
import sm.clagenna.stdcla.utils.AppProperties;
import sm.clagenna.stdcla.utils.ILog4jReader;
import sm.clagenna.stdcla.utils.Log4jRow;
import sm.clagenna.stdcla.utils.MioAppender;

public class LoadAassController implements Initializable, ILog4jReader, IStartApp {

  private static final Logger s_log            = LogManager.getLogger(LoadAassController.class);
  public static final String  CSZ_FXMLNAME     = "LoadAassJavaFX.fxml";
  private static final String CSZ_LOG_LEVEL    = "logLevel";
  private static final String CSZ_INTESTATARIO = "intestatario";
  private static final String CSZ_SPLITPOS     = "splitpos";
  private static final String CSS_NEW_PDF      = "newPdf";
  private static final String CSS_NEW_PDFsel   = "newPdfsel";
  private static final String CSS_OLD_PDF      = "oldPdf";

  @FXML
  private TextField txDirFatt;
  @FXML
  private Button    btCercaDir;
  @FXML
  private Button    btConvPDF;
  @FXML
  private Button    btShowResults;
  @FXML
  private CheckBox  ckGenTXT;
  @FXML
  private CheckBox  ckGenTAGs;
  @FXML
  private CheckBox  ckGenHtml;
  @FXML
  private CheckBox  ckOverwrite;
  @FXML
  private CheckBox  ckLanciaExcel;

  @FXML
  private SplitPane                     spltPane;
  @FXML
  private ListView<Path>                liPdf;
  @FXML
  private TableView<Log4jRow>           tblView;
  @FXML
  private TableColumn<Log4jRow, String> colTime;
  @FXML
  private TableColumn<Log4jRow, String> colLev;
  @FXML
  private TableColumn<Log4jRow, String> colMsg;
  @FXML
  private Button                        btClearMsg;
  @FXML
  private ComboBox<Level>               cbLevelMin;
  private Level                         levelMin;
  @FXML
  private ComboBox<RecIntesta>          cbIntesta;
  @FXML
  private Label                         lbProgressione;

  private RecIntesta     recIntesta;
  private ResultView     controller;
  private ViewRecIntesta cntrlIntesta;

  private List<Log4jRow> m_liMsgs;

  private Path           pthDirPDF;
  private AppProperties  props;
  private boolean        m_bGenTxt;
  private boolean        m_bGenTag;
  private boolean        m_bGenHtml;
  private boolean        m_bOverwrite;
  @Getter
  private boolean        lanciaExc;
  private SqlServPDFonDB sqlPdfs;
  private boolean        m_cbIntestaAdding;

  public LoadAassController() {
    //
  }

  @Override
  public void initialize(URL p_location, ResourceBundle p_resources) {
    MioAppender.setLogReader(this);
    props = LoadAassMainApp.getInst().getProps();
    levelMin = Level.INFO;
    initApp(props);
  }

  @Override
  public void initApp(AppProperties props) {
    LoadAassMainApp main = LoadAassMainApp.getInst();
    main.setController(this);
    getStage().setTitle("Caricamento delle fatture AASS su DB");
    // vedi: https://stackoverflow.com/questions/27160951/javafx-open-another-fxml-in-the-another-window-with-button
    getStage().onCloseRequestProperty().setValue(e -> Platform.exit());
    String szLastDir = props.getLastDir();
    if (szLastDir != null)
      txDirFatt.setText(szLastDir);
    txDirFatt.focusedProperty().addListener(new ChangeListener<Boolean>() {
      @Override
      public void changed(ObservableValue<? extends Boolean> p_observable, Boolean p_oldValue, Boolean p_newValue) {
        String sz = txDirFatt.getText();
        // s_log.debug("txDirFatt.focus={} text={}", p_newValue, sz);
        if ( !p_newValue) {
          if (sz != null && sz.length() > 2)
            onEnterDirPDF(null);
        }
      }
    });
    // -------- lista dei PDF  ----------------
    sqlPdfs = new SqlServPDFonDB(LoadAassMainApp.getInst().getConnSQL());
    liPdf.setOnMouseClicked(ev -> {
      if (ev.getClickCount() > 1)
        showPdfDoc();
    });
    listViewColorize();
    // -------- combo level -------
    if (props != null) {
      String sz = props.getProperty(CSZ_LOG_LEVEL);
      if (sz != null)
        levelMin = Level.toLevel(sz);
    }
    SqlServIntest intesta = aggiornaCbIntesta();
    recIntesta = intesta.get(1);
    String nomeInt = props.getProperty(CSZ_INTESTATARIO);
    if (nomeInt != null) {
      recIntesta = intesta.get(nomeInt);
      if (recIntesta != null)
        sqlPdfs.aggiornaPdfs(recIntesta.getIdIntestaInt());
    }
    cbIntesta.getSelectionModel().select(recIntesta);
    String szPos = props.getProperty(CSZ_SPLITPOS);
    if (szPos != null) {
      double dbl = Double.valueOf(szPos);
      spltPane.setDividerPositions(dbl);
    }
    ckLanciaExcel.selectedProperty().addListener(e -> ckLanciaExcelClick(e));
    initTblView();
  }

  private void listViewColorize() {
    liPdf.setCellFactory(p -> new ListCell<Path>() {
      /**
       * quando passo in hovering col mouse esce un popup
       *
       * <pre>
       * {
       *   final Popup popup = new Popup();
       *   popup.setAutoHide(true);
       *   final EventHandler<MouseEvent> hoverListener = new EventHandler<MouseEvent>() {
       *     @Override
       *     public void handle(MouseEvent event) {
       *       final Label popupContent = new Label("Mostro popup che contiene = '" + getText() + "'");
       *       popupContent.setStyle(
       *           "-fx-background-color: #64b5f6; -fx-border-color: #000000; -fx-border-width: 1px; -fx-padding: 5px; -fx-text-fill: white;");
       *       popup.getContent().clear();
       *       popup.getContent().addAll(popupContent);
       *       if (event.getEventType() == MouseEvent.MOUSE_EXITED) {
       *         popup.hide();
       *       } else if (event.getEventType() == MouseEvent.MOUSE_ENTERED) {
       *         popup.show(liPdf, event.getScreenX() + 10, event.getScreenY());
       *       }
       *     }
       *   };
       *   setOnMouseEntered(hoverListener);
       *   setOnMouseExited(hoverListener);
       * }
       * </pre>
       */

      @Override
      protected void updateItem(Path item, boolean empty) {
        super.updateItem(item, empty);
        if (item != null) {
          String szFiPdf = item.getFileName().toString();
          @SuppressWarnings("unused") String szColo = getStyleClass().toString();
          setText(item.toString());
          boolean bsel = isSelected();
          ObservableList<String> stcl = getStyleClass();
          if ( !sqlPdfs.contains(szFiPdf)) {
            //This won't work for the first time but will be the one
            //used in the next calls
            stcl.remove(CSS_OLD_PDF);
            stcl.remove(CSS_NEW_PDF);
            stcl.remove(CSS_NEW_PDFsel);
            stcl.add(bsel ? CSS_NEW_PDFsel : CSS_NEW_PDF);
            // szColo = "New PDF";
            // setTextFill(Color.DARKGREEN);
            // setFont(Font.font(16));
          } else {
            // setTextFill(Color.BLACK);
            // setFont(Font.font(13));
            // System.out.println("black=" + item.toString());
            stcl.remove(CSS_NEW_PDF);
            stcl.remove(CSS_NEW_PDFsel);
            if ( !stcl.contains(CSS_OLD_PDF))
              stcl.add(CSS_OLD_PDF);
            // szColo = "old";
          }
          // System.out.printf("updateItem(\"%s\" color=%s)\n", szFiPdf, szColo);
        }
      }

    });
  }

  public SqlServIntest aggiornaCbIntesta() {
    SqlServIntest intesta = null;
    try {
      m_cbIntestaAdding = true;
      intesta = LoadAassMainApp.getInst().getSqlIntesta();
      List<RecIntesta> liInte = intesta.getList();
      cbIntesta.getItems().clear();
      cbIntesta.getItems().addAll(liInte);
    } finally {
      m_cbIntestaAdding = false;
    }
    return intesta;
  }

  private Object ckLanciaExcelClick(Observable p_e) {
    // System.out.printf("LoadAassController.ckLanciaExcelClick(%s)\n", p_e.toString());
    lanciaExc = ckLanciaExcel.selectedProperty().get();
    return null;
  }

  private void initTblView() {
    tblView.setPlaceholder(new Label("Nessun messaggio da mostrare" + ""));
    tblView.setFixedCellSize(21.0);
    tblView.setRowFactory(row -> new TableRow<Log4jRow>() {
      @Override
      public void updateItem(Log4jRow item, boolean empty) {
        super.updateItem(item, empty);
        if (item == null || empty) {
          setStyle("");
          return;
        }
        String cssSty = "-fx-background-color: ";
        Level tip = item.getLevel();
        StandardLevel lev = tip.getStandardLevel();
        switch (lev) {
          case TRACE:
            cssSty += "beige";
            break;
          case DEBUG:
            cssSty += "silver";
            break;
          case INFO:
            cssSty = "";
            break;
          case WARN:
            cssSty += "coral";
            break;
          case ERROR:
            cssSty += "hotpink";
            break;
          case FATAL:
            cssSty += "deeppink";
            break;
          default:
            cssSty = "";
            break;
        }
        // System.out.println("stile=" + cssSty);
        setStyle(cssSty);
      }
    });

    colTime.setMaxWidth(60.);
    colTime.setCellValueFactory(new PropertyValueFactory<>("time"));
    colLev.setMaxWidth(48.0);
    colLev.setCellValueFactory(new PropertyValueFactory<>("level"));
    colMsg.setCellValueFactory(new PropertyValueFactory<>("message"));
    cbLevelMin.getItems().addAll(Level.TRACE, Level.DEBUG, Level.INFO, Level.WARN, Level.ERROR, Level.FATAL);
    cbLevelMin.getSelectionModel().select(levelMin);
    // questa
    tblView.getItems()
        .addListener((ListChangeListener<Log4jRow>) s -> Platform.runLater(() -> tblView.scrollTo(s.getList().size() - 1)));
    //    tblView.getItems().addListener(new ListChangeListener<Log4jRow>(){
    //
    //      @Override
    //      public void onChanged(ListChangeListener.Change<? extends Log4jRow> c) {
    //          // tblView.scrollTo(c.getList().size()-1);
    //        Platform.runLater( () -> tblView.scrollTo(c.getList().size()-1) );
    //      }
    //
    //  });
  }

  @Override
  public void addLog(String[] p_arr) {
    // [0] - class emitting
    // [1] - timestamp
    // [2] - Log Level
    // [3] - message
    // System.out.println("addLog=" + String.join("\t", p_arr));
    Log4jRow riga = null;
    try {
      riga = new Log4jRow(p_arr);
    } catch (Log4jException e) {
      e.printStackTrace();
    }
    if (riga != null)
      addRiga(riga);
  }

  private void addRiga(Log4jRow rig) {
    if (m_liMsgs == null)
      m_liMsgs = new ArrayList<>();
    m_liMsgs.add(rig);
    // if ( rig.getLevel().isInRange( Level.FATAL, levelMin )) // isLessSpecificThan(levelMin))
    if (rig.getLevel().intLevel() <= levelMin.intLevel())
      tblView.getItems().add(rig);
  }

  @FXML
  void btCercaClick(ActionEvent event) {
    String szMsg = null;
    LoadAassMainApp mainApp = LoadAassMainApp.getInst();
    Stage stage = mainApp.getPrimaryStage();
    DirectoryChooser filChoose = new DirectoryChooser();
    // imposto la dir precedente (se c'e')
    AppProperties props = mainApp.getProps();
    String szLastDir = props.getLastDir();
    if (szLastDir != null) {
      File fi = new File(szLastDir);
      if (fi.exists())
        filChoose.setInitialDirectory(fi);
    }

    File dirScelto = filChoose.showDialog(stage);
    if (dirScelto != null) {
      settaFileIn(dirScelto.toPath(), true, false);
    } else {
      szMsg = "Non hai scelto nessun file !!";
      s_log.warn(szMsg);
      messageDialog(AlertType.WARNING, szMsg);
    }
  }

  @FXML
  public Object premutoTasto(KeyEvent p_e) {
    // System.out.printf("LoadAassController.premutoTasto(%s)\n", p_e.toString());
    KeyCode key = p_e.getCode();
    switch (key) {
      case ENTER:
      case F5:
        Path pth = Paths.get(txDirFatt.getText());
        settaFileIn(pth, false, true);
        break;
      default:
        break;
    }
    return null;
  }

  @FXML
  void onEnterDirPDF(ActionEvent event) {
    String szMsg = null;
    String szGpx = txDirFatt.getText();
    if (szGpx == null || szGpx.length() < 3) {
      szMsg = String.format("Il direttorio \"%s\" non e' valido", szGpx);
      messageDialog(AlertType.ERROR, szMsg);
      return;
    }
    Path fi = null;
    try {
      fi = Paths.get(szGpx);
      if ( !Files.exists(fi, LinkOption.NOFOLLOW_LINKS)) {
        szMsg = String.format("Non trovo il direttorio \"%s\" oppure non e' valido", szGpx);
        messageDialog(AlertType.ERROR, szMsg);
        return;
      }
    } catch (Exception e) {
      szMsg = String.format("Non trovo il file \"%s\" oppure non e' valido", szGpx);
      messageDialog(AlertType.ERROR, szMsg);
    }
    if (fi != null) {
      settaFileIn(fi);
    }
  }

  @FXML
  void btConvPDF(ActionEvent event) {
    // System.out.println("LoadAassHTMLController.btConvPDF()");
    m_bGenTxt = ckGenTXT.isSelected();
    m_bGenTag = ckGenTAGs.isSelected();
    m_bGenHtml = ckGenHtml.isSelected();
    m_bOverwrite = ckOverwrite.isSelected();
    lanciaExc = ckLanciaExcel.isSelected();

    boolean bBackGround = true;
    if (bBackGround) {
      eseguiConversioneRunTask();
      return;
    }
    Platform.runLater(new Runnable() {
      @Override
      public void run() {
        getStage().getScene().setCursor(Cursor.WAIT);
      }
    });
    ObservableList<Path> sels = liPdf.getSelectionModel().getSelectedItems();
    for (Path pth : sels) {
      eseguiConversione(pth);
    }
    Platform.runLater(new Runnable() {
      @Override
      public void run() {
        getStage().getScene().setCursor(Cursor.DEFAULT);
      }
    });

  }

  private void eseguiConversione(Path p_pth) {
    s_log.info("Converto fatt {}", p_pth.toString());

    GestPDFFatt gpdf = null;
    try {
      gpdf = new GestPDFFatt(p_pth);
    } catch (AppPropsException | ReadFattException e) {
      s_log.error("Errore conversione PDF ist {}", p_pth.toString(), e);
      e.printStackTrace();
      return;
    }
    gpdf.setRecIntesta(recIntesta);
    gpdf.setGenPDFText(m_bGenTxt);
    gpdf.setGenTagFile(m_bGenTag);
    gpdf.setGenHTMLFile(m_bGenHtml);
    gpdf.setOverwrite(m_bOverwrite);
    gpdf.setLanciaExcel(lanciaExc);

    // try (DBConn connSQL = new DBConnSQL()) {
    //  connSQL.doConn();
    //    try {
    DBConn connSQL = LoadAassMainApp.getInst().getConnSQL();
    gpdf.setConnSql(connSQL);
    try {
      gpdf.convertiPDF();
    } catch (AppPropsException | ReadFattException e) {
      s_log.error("Errore conversione PDF {}", p_pth.toString(), e);
      e.printStackTrace();
    }
    //    } catch (Exception e) {
    //      s_log.error("Errore di conversione PDF Fattura {}", gpdf.getPdfFile(), e);
    //      throw e;
    //    }
  }

  private void eseguiConversioneRunTask()  {
    s_log.debug("Lancio la conversione in background con un thread");
    ObservableList<Path> sels = liPdf.getSelectionModel().getSelectedItems();
    ExecutorService backGrService = Executors.newFixedThreadPool(1);
    btConvPDF.setDisable(true);
    for (Path pth : sels) {
      try {
        // System.out.println("eseguiConversioneRunTask() ... new Task!");
        GestPDFFatt gpdf = new GestPDFFatt(pth);
        lbProgressione.textProperty().bind(gpdf.messageProperty());
        gpdf.setOnRunning(ev -> {
          //          lbProgressione.setText(gpdf.getValue());
          btConvPDF.setDisable(true);

          Platform.runLater(new Runnable() {
            @Override
            public void run() {
              getStage().getScene().setCursor(Cursor.WAIT);
            }
          });
        });
        gpdf.setOnSucceeded(ev -> {
          //          lbProgressione.setText(gpdf.getValue());
          btConvPDF.setDisable(false);
          Platform.runLater(new Runnable() {
            @Override
            public void run() {
              getStage().getScene().setCursor(Cursor.DEFAULT);
            }
          });
        });

        gpdf.setRecIntesta(recIntesta);
        gpdf.setGenPDFText(m_bGenTxt);
        gpdf.setGenTagFile(m_bGenTag);
        gpdf.setGenHTMLFile(m_bGenHtml);
        gpdf.setOverwrite(m_bOverwrite);
        gpdf.setLanciaExcel(lanciaExc);
        DBConn connSQL = LoadAassMainApp.getInst().getConnSQL();
        gpdf.setConnSql(connSQL);
        // gpdf.convertiPDF();
        backGrService.execute(gpdf);
        // lbProgressione.textProperty().unbind();
      } catch (ReadFattException | AppPropsException e) {
        lbProgressione.textProperty().unbind();
        s_log.error("Errore conversione PDF {}", pth.toString(), e);
      }
    }
    btConvPDF.setDisable(false);
    backGrService.shutdown();
  }

  @FXML
  void onListKeyPress(ActionEvent event) {
    System.out.println("List key pess:" + event.toString());
  }

  private Path settaFileIn(Path p_fi) {
    return settaFileIn(p_fi, true, false);
  }

  /**
   * Imposta il {@link #txDirFatt} col valore passato a meno che non sia
   * specificato p_setTx = False. Inoltre se specificato bForce = True
   * indipendentemente dal valore precedente di {@link #pthDirPDF} comunque
   * ricarica l'elenco dei files nella listView
   *
   * @param p_fi
   *          path al nuovo dir delle fatture
   * @param p_setTx
   *          se aggiornare {@link #txDirFatt} col nuovo valore
   * @param bForce
   *          ricarica l'elenco dei files nella listView
   * @return
   */
  private Path settaFileIn(Path p_fi, boolean p_setTx, boolean bForce) {
    if (p_fi == null)
      return p_fi;
    if ( !bForce)
      if (pthDirPDF != null && pthDirPDF.compareTo(p_fi) == 0)
        return pthDirPDF;
    String szFiin = p_fi.toString();
    props.setLastDir(szFiin);
    if (p_setTx)
      txDirFatt.setText(szFiin);
    pthDirPDF = p_fi;
    if ( !Files.exists(pthDirPDF, LinkOption.NOFOLLOW_LINKS)) {
      s_log.error("Il path \"{}\" non esiste !", pthDirPDF.toString());
      return p_fi;
    }
    recIntesta.setDirFatture(szFiin);
    reloadListFilesPDF();
    return p_fi;
  }

  private void reloadListFilesPDF() {
    List<Path> result = null;
    String szGlobMatch = "glob:*:/**/{EE_,GAS_,H2O_}*.pdf";
    szGlobMatch = "glob:*:/**/*.pdf";
    PathMatcher matcher = FileSystems.getDefault().getPathMatcher(szGlobMatch);
    try (Stream<Path> walk = Files.walk(pthDirPDF)) {
      result = walk.filter(p -> !Files.isDirectory(p)) //
          // not a directory
          // .map(p -> p.toString().toLowerCase()) // convert path to string
          .filter(f -> matcher.matches(f)) // check end with
          .collect(Collectors.toList()); // collect all matched to a List
    } catch (IOException e) {
      e.printStackTrace();
    }

    // DefaultListModel<Path> l1 = new DefaultListModel<>();
    ObservableList<Path> li = FXCollections.observableArrayList(result);
    liPdf.setItems(li);
    liPdf.getSelectionModel().setSelectionMode(SelectionMode.MULTIPLE);
    listViewColorize();

    MenuItem mi1 = new MenuItem("Vedi Fattura");
    mi1.setOnAction((ActionEvent ev) -> {
      showPdfDoc();
    });
    ContextMenu menu = new ContextMenu();
    menu.getItems().add(mi1);
    liPdf.setContextMenu(menu);

    s_log.debug("Ricarico la lista files dal dir \"{}\"", pthDirPDF.toString());
  }

  private void showPdfDoc() {
    Path it = liPdf.getSelectionModel().getSelectedItem();
    // System.out.println("Ctx menu: path="+it);
    try {
      if (Desktop.isDesktopSupported()) {
        s_log.info("Apro lettore PDF per {}", it.toString());
        Desktop.getDesktop().open(it.toFile());
      } else {
        s_log.error("Desktop not supported");
      }
    } catch (IOException e) {
      s_log.error("Desktop PDF launch error:" + e.getMessage(), e);
    }
  }

  public void messageDialog(AlertType typ, String p_msg) {
    LoadAassMainApp.getInst().messageDialog(typ, p_msg);
    //    Alert alert = new Alert(typ);
    //    switch (typ) {
    //      case INFORMATION:
    //        alert.setTitle("Informa");
    //        alert.setHeaderText("Ok !");
    //        break;
    //
    //      case WARNING:
    //        alert.setTitle("Attenzione");
    //        alert.setHeaderText("Fai Attenzione !");
    //        break;
    //
    //      case ERROR:
    //        alert.setTitle("Errore !");
    //        alert.setHeaderText("Ahi ! Ahi !");
    //        break;
    //
    //      default:
    //        break;
    //    }
    //    alert.setContentText(p_msg);
    //    alert.showAndWait();
  }

  public Stage getStage() {
    Stage stg = LoadAassMainApp.getInst().getPrimaryStage();
    return stg;
  }

  public boolean isGenTags() {
    return m_bGenTag;
  }

  @FXML
  void btClearMsgClick(ActionEvent event) {
    // System.out.println("ReadFattHTMLController.btClearMsgClick()");
    tblView.getItems().clear();
    if (m_liMsgs != null)
      m_liMsgs.clear();
    m_liMsgs = null;
  }

  @FXML
  void cbIntesta(ActionEvent event) {
    if (m_cbIntestaAdding)
      return;
    recIntesta = cbIntesta.getSelectionModel().getSelectedItem();
    s_log.info("Selezionato intestatario: {}", recIntesta.getNomeIntesta());
    Path pth = Paths.get(recIntesta.getDirFatture());
    sqlPdfs.aggiornaPdfs(recIntesta.getIdIntestaInt());
    settaFileIn(pth, true, true);
  }

  @FXML
  void cbLevelMinSel(ActionEvent event) {
    levelMin = cbLevelMin.getSelectionModel().getSelectedItem();
    // System.out.println("ReadFattHTMLController.cbLevelMinSel():" + levelMin.name());
    tblView.getItems().clear();
    if (m_liMsgs == null || m_liMsgs.size() == 0)
      return;
    // List<Log4jRow> li = m_liMsgs.stream().filter(s -> s.getLevel().isInRange(Level.FATAL, levelMin )).toList(); // !s.getLevel().isLessSpecificThan(levelMin)).toList();
    List<Log4jRow> li = m_liMsgs.stream().filter(s -> s.getLevel().intLevel() <= levelMin.intLevel()).toList();
    tblView.getItems().addAll(li);
  }

  /**
   * Mostra la forma modeless per la visualizzazione dei dati presenti nel DB
   *
   * @param event
   * @throws IOException
   */
  @FXML
  void btShowResults(ActionEvent event) {
    LoadAassMainApp mainApp = LoadAassMainApp.getInst();
    Stage primaryStage = mainApp.getPrimaryStage();

    URL url = getClass().getResource(ResultView.CSZ_FXMLNAME);
    if (url == null)
      url = getClass().getClassLoader().getResource(ResultView.CSZ_FXMLNAME);
    Parent radice;
    controller = null;
    FXMLLoader fxmlLoad = new FXMLLoader(url);
    try {
      // radice = FXMLLoader.load(url);
      radice = fxmlLoad.load();
      controller = fxmlLoad.getController();
    } catch (IOException e) {
      s_log.error("Errore caricamento FXML {}", ResultView.CSZ_FXMLNAME, e);
      return;
    }
    //    Node nod = radice;
    //    do {
    //      controller = (ResultView) nod.getProperties().get("refToCntrl");
    //      nod = nod.getParent();
    //    } while (controller == null && nod != null);

    Stage stageResults = new Stage();
    Scene scene = new Scene(radice, 600, 440);
    stageResults.setScene(scene);
    stageResults.setWidth(800);
    stageResults.setHeight(600);
    stageResults.initOwner(primaryStage);
    stageResults.initModality(Modality.NONE);
    stageResults.setTitle("Visualizza dati del DB");
    // verifica che nel FXML ci sia la dichiarazione:
    // <userData> <fx:reference source="controller" /> </userData>
    if (controller != null) {
      controller.setMyScene(scene);
      controller.initApp(props);
    }
    stageResults.show();
  }

  @FXML
  void mnuEditIntestaClick(ActionEvent event) {
    // System.out.println("LoadAassController.mnuEditIntestaClick()");
    LoadAassMainApp mainApp = LoadAassMainApp.getInst();
    Stage primaryStage = mainApp.getPrimaryStage();

    URL url = getClass().getResource(ViewRecIntesta.CSZ_FXMLNAME);
    if (url == null)
      url = getClass().getClassLoader().getResource(ViewRecIntesta.CSZ_FXMLNAME);
    Parent radice;
    cntrlIntesta = null;
    try {
      FXMLLoader fxmlLoad = new FXMLLoader(url);
      //      radice = FXMLLoader.load(url);
      radice = fxmlLoad.load();
      cntrlIntesta = fxmlLoad.getController();
    } catch (IOException e) {
      s_log.error("Errore caricamento FXML {}", ViewRecIntesta.CSZ_FXMLNAME, e);
      return;
    }
    //    Node nod = radice;
    //    do {
    //      cntrlIntesta = (ViewRecIntesta) nod.getProperties().get("refToCntrl");
    //      nod = nod.getParent();
    //    } while (cntrlIntesta == null && nod != null);

    Stage stageViewIntes = new Stage();
    Scene scene = new Scene(radice, 600, 440);
    stageViewIntes.setScene(scene);
    stageViewIntes.setWidth(800);
    stageViewIntes.setHeight(600);
    stageViewIntes.initOwner(primaryStage);
    stageViewIntes.initModality(Modality.APPLICATION_MODAL);
    stageViewIntes.setTitle("Gestione degli Intestatari");
    // verifica che nel FXML ci sia la dichiarazione:
    // <userData> <fx:reference source="controller" /> </userData>
    if (cntrlIntesta != null) {
      cntrlIntesta.setMyScene(scene);
      cntrlIntesta.initApp(props);
    }
    stageViewIntes.show();
  }

  @FXML
  void mnuRescanDirs(ActionEvent event) {
    try {
      getStage().getScene().setCursor(Cursor.WAIT);
      System.out.println("Menu Rescan Dirspess:" + event.toString());
      reloadListFilesPDF();
    } catch (Exception e) {
      //
    } finally {
      getStage().getScene().setCursor(Cursor.DEFAULT);
    }
  }

  @FXML
  void mnuExitClick(ActionEvent event) {
    Platform.exit();
  }

  @Override
  public void closeApp(AppProperties p_props) {
    p_props.setProperty(CSZ_LOG_LEVEL, levelMin.toString());
    if (recIntesta != null)
      p_props.setProperty(CSZ_INTESTATARIO, recIntesta.getNomeIntesta());
    double[] pos = spltPane.getDividerPositions();
    String szPos = String.format("%.4f", pos[0]).replace(",", ".");
    p_props.setProperty(CSZ_SPLITPOS, szPos);
  }

  @Override
  public void changeSkin() {
    s_log.warn("Implementare la changeSkin()");
  }

}
