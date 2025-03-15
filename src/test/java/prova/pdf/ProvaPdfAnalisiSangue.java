package prova.pdf;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.fit.pdfdom.PDFDomTree;
import org.junit.Test;

public class ProvaPdfAnalisiSangue {

  private static String CSZ_PAT2 = ".*<div .* style=\"top:(\\d+\\.\\d+)pt;left:(\\d+\\.\\d+)pt;.*>(.*)</div>";

  private Path          PTH_PDFFILE;
  private List<String>  outHTML;
  private int           m_nPage;
  private TagVal2       m_lastCp;
  private List<TagVal2> m_tgVals;

  public ProvaPdfAnalisiSangue() {
    //
  }

  @Test
  public void provalo() {
    PTH_PDFFILE = Paths.get("F:\\Google Drive\\gennari\\claudio\\Cartella Clinica\\An-Sang\\analisi-2025-02-21.pdf");
    convert2HTML();
    parseHTML();
    parseSeqs();
    saveTags();
    saveHTML();
  }

  private void convert2HTML() {
    outHTML = new ArrayList<String>();
    try (PDDocument pdf = PDDocument.load(PTH_PDFFILE.toFile()); //
        StringWriter sw = new StringWriter()) {
      new PDFDomTree().writeText(pdf, sw);
      String[] arr = sw.toString().split("\n");
      outHTML.addAll(Arrays.asList(arr));
    } catch (Exception e) {
      e.printStackTrace();
      return;
    }
  }

  private void parseHTML() {
    if (null == outHTML)
      return;
    m_tgVals = new ArrayList<TagVal2>();
    Pattern pat2 = Pattern.compile(CSZ_PAT2);
    String szLeft, szTop, szText;
    for (String szRigaHtml : outHTML) {
      if (szRigaHtml.indexOf(">&nbsp;</div>") >= 0)
        continue;
      if (szRigaHtml.indexOf("class=\"page\"") >= 0) {
        m_nPage++;
        continue;
      }
      if (szRigaHtml.indexOf("div class=\"p\"") < 0)
        continue;
      Matcher mtch = pat2.matcher(szRigaHtml);
      if ( !mtch.find())
        continue;
      int k = 1;
      szTop = mtch.group(k++);
      szLeft = mtch.group(k++);
      szText = mtch.group(k++);
      trattaRiga(szLeft, szTop, szText, szRigaHtml);
    }
    Collections.sort(m_tgVals);
  }

  @SuppressWarnings("unused")
  private void trattaRiga(String szLeft, String szTop, String szTxt, String szRigaHtml) {
    String szDebug = null;
    if (szDebug != null && szTxt.toLowerCase().contains(szDebug))
      System.out.printf("trattaRiga(\"%s\")=%s\n", szDebug, szTxt);
    if (szTxt != null && szTxt.indexOf("nbsp;") >= 0)
      return;
    double nLeft = Double.parseDouble(szLeft);
    double nTop = Double.parseDouble(szTop);
    if (m_nPage <= 0)
      System.out.printf("Pagina fuori range:%s su tag %s\n", m_nPage, szTxt);
    TagVal2 rec = new TagVal2(nLeft, nTop, m_nPage, szTxt, szRigaHtml);
    if (m_lastCp != null && m_lastCp.isConsecutivo(rec))
      m_lastCp.append(rec);
    else {
      // m_liCampi.add(rec);
      m_tgVals.add(rec);
      m_lastCp = rec;
    }
  }

  private void parseSeqs() {
    int ndx = 0;
    while (ndx < m_tgVals.size()) {

    }
  }

  private void saveTags() {
    if (null == outHTML)
      return;
    Path outFi = Paths.get("C:\\temp", PTH_PDFFILE.getFileName().toString().replace(".pdf", ".tgv"));
    try {
      Files.deleteIfExists(outFi);
    } catch (IOException e) {
      e.printStackTrace();
      return;
    }
    try (BufferedWriter bw = new BufferedWriter(new FileWriter(outFi.toFile()))) {
      for (TagVal2 tgv : m_tgVals) {
        bw.write(tgv.toString() + System.lineSeparator());
      }
      System.out.printf("Scritto: %s\n", outFi.toString());
    } catch (IOException e) {
      e.printStackTrace();
    }

  }

  private void saveHTML() {
    if (null == outHTML)
      return;
    Path outFi = Paths.get("C:\\temp", PTH_PDFFILE.getFileName().toString().replace(".pdf", ".html"));
    try {
      Files.deleteIfExists(outFi);
    } catch (IOException e) {
      e.printStackTrace();
      return;
    }
    try (BufferedWriter bw = new BufferedWriter(new FileWriter(outFi.toFile()))) {
      for (String sz : outHTML) {
        bw.write(sz + System.lineSeparator());
      }
      System.out.printf("Scritto: %s\n", outFi.toString());
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

}
