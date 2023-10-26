package sm.clagenna.loadaass.tohtml;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.fit.pdfdom.PDFDomTree;

import sm.clagenna.loadaass.data.TaggedValue;
import sm.clagenna.loadaass.sys.AppProperties;

public class FromPdf2Html {
  private static final Logger s_log    = LogManager.getLogger(FromPdf2Html.class);

  private static String       CSZ_PAT2 = ".*<div .* style=\"top:(\\d+\\.\\d+)pt;left:(\\d+\\.\\d+)pt;.*>(.*)</div>";
  private List<String>        m_outHtml;
  private int                 m_nPage;
  private List<TaggedValue>   m_liCampi;
  private TaggedValue         m_lastCp;

  public FromPdf2Html() {
    //
  }

  public boolean convertiPDF(Path p_fiPdf) {
    s_log.info("Parse del file \"{}\"", p_fiPdf.toString());
    if ( !convToHtml(p_fiPdf) || !scanRigheHTML())
      return false;
    // per ora non raccolgo campi testo in uno solo
    // accomunaText();
    return true;
  }

  public List<TaggedValue> getListCampi() {
    return m_liCampi;
  }

  /**
   * Converte il file PDF in formato HTML dove sono presenti i i tags da
   * interpretare
   *
   * <pre>
   *   <div class="page" id="page_0" style=
  "width:595.0pt;height:841.0pt;overflow:hidden;">
   *     <div class="r" style=
  "left:292.25pt;top:299.75pt;width:276.15002pt;height:0.0pt;border-bottom:1.5pt solid #0057af;">&nbsp;</div>
   * </pre>
   *
   * @param p_fiPdf
   * @return
   */
  private boolean convToHtml(Path p_fiPdf) {
    PDDocument pdf;
    try {
      pdf = PDDocument.load(p_fiPdf.toFile());
    } catch (IOException e) {
      s_log.error("Errore \"{}\" in lettura file PDF: {}", e.getMessage(), p_fiPdf.toString());
      return false;
    }
    StringWriter swr = new StringWriter();
    //    Writer output = new PrintWriter(szFiHtml, "utf-8");
    try {
      new PDFDomTree().writeText(pdf, swr);
      swr.close();
      pdf.close();
    } catch (IOException e) {
      s_log.error("Errore \"{}\" Scrittura HTML", e.getMessage());
      return false;
    }
    m_outHtml = new ArrayList<>();
    String[] arr = swr.toString().split("\n");
    m_outHtml.addAll(Arrays.asList(arr));
    return true;
  }

  private boolean scanRigheHTML() {
    m_nPage = 0;
    Pattern pat2 = Pattern.compile(CSZ_PAT2);
    String szLeft = null, szTop = null, szText = null;
    m_liCampi = new ArrayList<>();
    for (String sz : m_outHtml) {
      if (sz.indexOf(">&nbsp;</div>") >= 0)
        continue;
      if (sz.indexOf("class=\"page\"") >= 0) {
        m_nPage++;
        continue;
      }
      if ( (sz.indexOf("div class=\"p\"") < 0))
        continue;
      Matcher mtch = pat2.matcher(sz);
      if ( !mtch.find())
        continue;
      int k = 1;
      szTop = mtch.group(k++);
      szLeft = mtch.group(k++);
      szText = mtch.group(k++);
      trattaRiga(szLeft, szTop, szText);
    }
    if (m_liCampi.size() < 5) {
      s_log.error("Non sembra essere una fattura");
      return false;
    }
    Collections.sort(m_liCampi);
    return true;
  }

  @SuppressWarnings("unused")
  public void trattaRiga(String szLeft, String szTop, String szTxt) {
    String szDebug = null;
    if (szDebug != null && szTxt.toLowerCase().contains(szDebug))
      System.out.printf("FromHtml.trattaRiga(\"%s\")=%s\n", szDebug, szTxt);

    if (szTxt != null && szTxt.indexOf("nbsp;") >= 0)
      return;
    if (m_liCampi == null)
      m_liCampi = new ArrayList<>();
    double nLeft = Double.parseDouble(szLeft);
    double nTop = Double.parseDouble(szTop);
    if (m_nPage <= 0)
      s_log.error("Pagina fuori range:{} su tag {}", m_nPage, szTxt);
    TaggedValue rec = new TaggedValue(nLeft, nTop, m_nPage, szTxt);
    if (m_lastCp != null && m_lastCp.isConsecutivo(rec))
      m_lastCp.append(rec);
    else {
      m_liCampi.add(rec);
      m_lastCp = rec;
    }
  }

  public String getTextTAGs() {
    String sz = "**NULL**";
    if (m_liCampi == null || m_liCampi.size() == 0)
      return sz;
    sz = m_liCampi //
        .stream() //
        .map(t -> t.toString()) //
        .collect(Collectors.joining("\n"));
    return sz;
  }

  public void saveTagFile(String p_tagFile) {
    String sz = getTextTAGs();
    try (BufferedWriter bw = new BufferedWriter(new FileWriter(p_tagFile))) {
      bw.write(sz);
      s_log.info("Scritto TAGs file {}", p_tagFile);
    } catch (IOException e) {
      s_log.error("Errore scrittura TAGs", e);
    }
  }

  public void saveTxtFile(String p_txtFile) {
    TextPrint txp = new TextPrint(false, 5);
    for (TaggedValue cm : getListCampi())
      txp.scrivi(cm);
    // System.out.println(txp.toString());
    try (BufferedWriter bw = new BufferedWriter(new FileWriter(p_txtFile))) {
      bw.write(txp.toString());
      s_log.info("Scritto pdf text file {}", p_txtFile);
    } catch (IOException e) {
      s_log.error("Errore scrittura pdf text", e);
    }
  }

  public void saveHtmlFile(String p_htmlFile) {
    try (BufferedWriter bw = new BufferedWriter(new FileWriter(p_htmlFile))) {
      String szHtml = m_outHtml //
          .stream() //
          .collect(Collectors.joining(System.lineSeparator()));
      bw.write(szHtml);
      s_log.info("Scritto HTML file {}", p_htmlFile);
    } catch (IOException e) {
      s_log.error("Errore scrittura TAGs", e);
    }
  }

  public Object parseRiga(String p_l) {
    // TODO Auto-generated method stub
    return null;
  }

  public void setPage(int p_i) {
    m_nPage = p_i;
  }

}
