package prova.tags;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import sm.clagenna.loadaass.data.HtmlValue;
import sm.clagenna.loadaass.enums.ETipoFatt;
import sm.clagenna.loadaass.main.GestPDFFatt;
import sm.clagenna.loadaass.sys.ex.ReadFattException;
import sm.clagenna.loadaass.tohtml.FromPdf2Html;
import sm.clagenna.stdcla.sys.ex.AppPropsException;

public class TestTagsFromFile {
  private static final String CSZ_PROPERTIES = "src/main/resources/FattGAS_HTML.properties";
  // pattern per :
  //  -1---2---3--4----5-6----7---8--9-----------------
  // (511,36,289,65)  89(1), 75 txt="Totale Consumi mc"
  private static final String CSZ_PATTAGSTXT = ""                                           //
      + "\\("                                                                               //
      + "([0-9]+),"                                                                         // (1)
      + "([0-9]+),"                                                                         // (2)
      + "([0-9]+),"                                                                         // (3)
      + "([0-9]+)"                                                                          // (4)
      + "\\)[ \t]+"                                                                         //
      + "([0-9]+)"                                                                          // (5)
      + "\\(([0-9]+)\\),[ \t]+"                                                             // (6)
      + "([0-9]+)"                                                                          // (7)
      + "[ \t]+"                                                                            //
      + "([^=]+)="                                                                          // (8)
      + "\"([^\"]+)\"";                                                                     // (9)
  private static Pattern      s_pat;
  private FromPdf2Html        m_pdf2h;
  private GestPDFFatt         m_gest;
  static {
    s_pat = Pattern.compile(CSZ_PATTAGSTXT);
  }

  public TestTagsFromFile() {
    //
  }

  public static void main(String[] args) throws ReadFattException {
    if (args.length == 0) {
      System.err.println("Non hai specificato il file di Tags");
      return;
    }
    TestTagsFromFile app = new TestTagsFromFile();
    app.doTheJob(args[0]);
  }

  private void doTheJob(String p_fi) throws ReadFattException {

    m_pdf2h = new FromPdf2Html();
    m_pdf2h.setPage(1);

    m_gest = new GestPDFFatt();
    m_gest.setPdfFile( Paths.get( p_fi));

    m_gest.setFromPdf2HTML(m_pdf2h);
    m_gest.setTipoFatt(ETipoFatt.GAS);
    m_gest.setPropertyFile(Paths.get(CSZ_PROPERTIES));

    try {
      Files.lines(Paths.get(p_fi)) //
          .forEach(l -> parseRiga(l));
      for (HtmlValue cv : m_pdf2h.getListCampi()) {
        System.out.println("tgVal=" + cv.toString());
      }
      m_gest.discerniTipoPropContenuto();
      m_gest.leggiCercaValori();
      m_gest.cercaTagValues();
    } catch (IOException | AppPropsException e) {
      e.printStackTrace();
    }
  }

  @SuppressWarnings("unused")
  private Object parseRiga(String p_l) {
    //    System.out.println(p_l);
    Matcher mat = s_pat.matcher(p_l);
    if ( !mat.matches()) {
      System.out.printf("Not match;%s\n", p_l);
      return null;
    }
    int k = 1;
    String szY = String.format("%s.%s", mat.group(k++), mat.group(k++));
    String szX = String.format("%s.%s", mat.group(k++), mat.group(k++));
    String szRig = mat.group(k++);
    String szPag = mat.group(k++);
    String szCol = mat.group(k++);
    String szTip = mat.group(k++);
    String szVal = mat.group(k++);
    //    System.out.printf("%s,%s\tp=%s (%s,%s)\t[%s] \"%s\"\n", szX, szY, szPag, szRig, szCol, szTip, szVal);
    m_pdf2h.trattaRiga(szX, szY, szVal, p_l);
    return null;
  }

}
