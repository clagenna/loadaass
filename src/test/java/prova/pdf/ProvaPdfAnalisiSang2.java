package prova.pdf;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import sm.clagenna.loadaass.data.EsSang;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.dbsql.SqlServToAnalisi;
import sm.clagenna.loadaass.enums.ETipoFatt;
import sm.clagenna.loadaass.main.GestPDFFatt;
import sm.clagenna.loadaass.sys.ex.ReadFattException;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;
import sm.clagenna.loadaass.tohtml.FromPdf2Html;
import sm.clagenna.stdcla.sql.DBConnSQL;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.stdcla.utils.AppProperties;

public class ProvaPdfAnalisiSang2 {
  private static final String CSZ_PROPERTIES = "src/main/resources/AnSang_HTML.properties";
  private static final String baseDir        = "\\temp\\analisi";

  private FromPdf2Html m_pdf2h;
  private GestPDFFatt  m_gest;
  private List<EsSang> m_liEsam;

  private AppProperties    m_prop;
  private DBConnSQL        m_conn;
  private SqlServToAnalisi m_db;

  public ProvaPdfAnalisiSang2() {
    //
  }

  // @ Test
  public void doIt() throws AppPropsException, ReadFattException, SQLException {
    Path PTH_PDFFILE = Paths.get("F:\\Google Drive\\gennari\\claudio\\Cartella Clinica\\An-Sang\\analisi-2025-01-27.pdf");
    PTH_PDFFILE = Paths.get("F:\\Google Drive\\gennari\\claudio\\Cartella Clinica\\An-Sang\\analisi_2019-05-16.pdf");
    // fermarsi sul valore PSA oppure sui range con le quadre
    AppProperties.setSingleton(false);
    init();
    leggiEsami(PTH_PDFFILE);
  }

  @Test
  public void doTheJob() throws ReadFattException, AppPropsException, IOException {
    // Path PTH_PDFFILE = Paths.get("F:\\Google Drive\\gennari\\claudio\\Cartella Clinica\\An-Sang\\analisi-2025-01-27.pdf");

    // perchè si ferma alla 7' riga

    Path PTH_PDFFILE = Paths.get("F:\\Google Drive\\gennari\\claudio\\Cartella Clinica\\An-Sang");
    AppProperties.setSingleton(false);
    init();
    Files.list(PTH_PDFFILE) //
        .filter(s -> s.getFileName().toString().startsWith("analisi")) //
        .forEach(s -> {
          try {
            leggiEsami(s);
          } catch (AppPropsException | ReadFattException | SQLException e) {
            e.printStackTrace();
          }
        });
  }

  private void init() throws AppPropsException {
    m_prop = new AppProperties();
    m_prop.leggiPropertyFile("loadAASS.properties", true, false);

    m_conn = new DBConnSQL();
    m_conn.readProperties(m_prop);
    m_conn.doConn();

    m_db = new SqlServToAnalisi();
    m_db.setConnSql(m_conn);
    m_db.init();
  }

  private void leggiEsami(Path pth) throws ReadFattException, AppPropsException, SQLException {
    pdf2Html(pth);
    saveCSV(pth, "orig");
    saveHTML(pth);
    m_pdf2h.unifyByRanges();
    saveCSV(pth, "unify");
    studiaHtml(pth);
    estraiAnalisi();
    saveDb(pth);
    //    } catch (SQLException e) {
    //      System.err.printf("Errore File \"%s\", err=%s", pth.toString(), e.getMessage());
    //      e.printStackTrace();
    //    }
  }

  private void pdf2Html(Path pth) {
    System.out.printf("Studio Esami %s\n", pth.toString());
    m_pdf2h = new FromPdf2Html();
    m_pdf2h.setPage(1);
    if ( !m_pdf2h.convertiPDF(pth))
      return;
  }

  private void studiaHtml(Path pth) throws ReadFattException, AppPropsException, ReadFattPropsException {
    m_gest = new GestPDFFatt();
    m_gest.setPdfFile(pth);
    m_gest.setPropertyFile(Paths.get(CSZ_PROPERTIES));
    m_gest.init();
    m_gest.setFromPdf2HTML(m_pdf2h);
    m_gest.setTipoFatt(ETipoFatt.Analisi);

    try {
      m_gest.discerniTipoPropContenuto();
      m_gest.leggiCercaValori();
      m_gest.cercaTagValues();
      m_gest.cercaSeqValues();
    } catch (AppPropsException e) {
      e.printStackTrace();
    }
  }

  private List<EsSang> estraiAnalisi() {
    TagValFactory fact = m_gest.getTagFactory();
    m_liEsam = new ArrayList<EsSang>();
    int qta = fact.getSize();
    for (int i = 0; i < qta; i++) {
      EsSang es = new EsSang();
      if (es.assegna(fact, i))
        m_liEsam.add(es);
    }
    return m_liEsam;
  }

  private void saveCSV(Path pth, String suff) {
    Path pthbas = Paths.get(baseDir);
    try {
      if ( !Files.exists(pthbas, LinkOption.NOFOLLOW_LINKS)) {
        Files.createDirectories(pthbas);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    String szNam = pth.getFileName().toString().toLowerCase();
    if (null != suff) {
      int n = szNam.lastIndexOf(".");
      String lnam = szNam.substring(0, n);
      szNam = String.format("%s_%s.csv", lnam, suff);
    }
    szNam = szNam.replace(".pdf", ".csv");
    Path dest = Paths.get(pthbas.toString(), szNam);
    m_pdf2h.saveCSVFile(dest.toString());
  }

  private void saveHTML(Path pth) {
    Path pthbas = Paths.get(baseDir);
    try {
      if ( !Files.exists(pthbas, LinkOption.NOFOLLOW_LINKS)) {
        Files.createDirectories(pthbas);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    String szNam = pth.getFileName().toString().toLowerCase();
    szNam = szNam.replace(".pdf", ".html");
    Path dest = Paths.get(pthbas.toString(), szNam);
    m_pdf2h.saveHtmlFile2(dest.toString());
  }

  private void saveDb(Path p_pth) throws SQLException {
    if (null == m_liEsam || m_liEsam.size() == 0)
      return;
    EsSang es = m_liEsam.get(0);
    if (m_db.esameExist(es) > 0)
      m_db.esameDelete(es);
    for (EsSang es2 : m_liEsam) {
      m_db.esameInsert(es2);
    }
  }
}
