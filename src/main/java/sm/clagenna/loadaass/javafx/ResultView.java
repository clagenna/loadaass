package sm.clagenna.loadaass.javafx;

import java.net.URL;
import java.util.ResourceBundle;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import sm.clagenna.loadaass.data.RecEEScaglioniImporti;
import sm.clagenna.loadaass.dbsql.SqlServIntest.RecIntesta;

public class ResultView implements Initializable {
  @SuppressWarnings("unused")
  private static final Logger                        s_log        = LogManager.getLogger(ResultView.class);
  public static final String                         CSZ_FXMLNAME = "ResultView.fxml";
  @FXML
  private Button                                     btCerca;
  @FXML
  private ComboBox<RecIntesta>                       cbIntesta;
  @FXML
  private ComboBox<Integer>                          cbAnnoComp;

  @FXML
  private TextField                                  txDtEmiss;
  @FXML
  private TextField                                  txFattNo;
  @FXML
  private TextField                                  txPeriodoFatt;
  @FXML
  private TextField                                  txTotPagare;
  @FXML
  private TextField                                  txCredPrec;
  @FXML
  private TextField                                  txCredAttuale;
  @FXML
  private TextField                                  txAddizFER;

  @FXML
  private TableView<RecEEScaglioniImporti>           tblEEScaglioni;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colDtIniz;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colEESca1;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colEESca2;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colEESca3;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colEESpreaSca1;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colEESpreaSca2;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colEEPun;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colRifiuti;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colImpegnoTot;
  @FXML
  private TableColumn<RecEEScaglioniImporti, String> colTotRiga;

  public ResultView() {
    //
  }

  @Override
  public void initialize(URL p_location, ResourceBundle p_resources) {

  }

  @FXML
  void cbIntestaSel(ActionEvent event) {

  }

  @FXML
  void cbAnnoCompSel(ActionEvent event) {

  }

  @FXML
  void btCercaClick(ActionEvent event) {

  }

}
