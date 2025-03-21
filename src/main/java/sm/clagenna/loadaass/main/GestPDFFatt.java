package sm.clagenna.loadaass.main;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javafx.concurrent.Task;
import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.FactoryFattura;
import sm.clagenna.loadaass.data.RecIntesta;
import sm.clagenna.loadaass.data.RigaHolder;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.HtmlValue;
import sm.clagenna.loadaass.data.ValoreBySeq;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.dbsql.Consts;
import sm.clagenna.loadaass.dbsql.CreaDataset;
import sm.clagenna.loadaass.dbsql.ISql;
import sm.clagenna.loadaass.enums.ETipiDato;
import sm.clagenna.loadaass.enums.ETipoFatt;
import sm.clagenna.loadaass.javafx.LoadAassController;
import sm.clagenna.loadaass.javafx.LoadAassMainApp;
import sm.clagenna.loadaass.sys.ex.ReadFattException;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;
import sm.clagenna.loadaass.tohtml.FromPdf2Html;
import sm.clagenna.stdcla.sql.DBConn;
import sm.clagenna.stdcla.sys.ex.AppPropsException;
import sm.clagenna.stdcla.utils.AppProperties;
import sm.clagenna.stdcla.utils.Utils;

public class GestPDFFatt extends Task<String> {

  public static final String  CSZ_TEXT_H2O  = "Servizio Idrico Integrato";
  public static final String  CSZ_TEXT_EE   = "Servizio Energia Elettrica";
  public static final String  CSZ_TEXT_GAS  = "Servizio Gas Naturale";
  private static final String CSZ_TEXT_SANG = "Medicina Trasfusionale";
  private static final Logger s_log         = LogManager.getLogger(GestPDFFatt.class);
  private FromPdf2Html        m_fromHtml;

  @Getter
  private Path               pdfFile;
  @Getter
  private Path               propertyFile;
  private String             m_TextFile;
  private String             m_TagFile;
  private String             m_HtmlFile;
  private String             m_TraceFile;
  private StringBuilder      m_sbTraceSeq;
  private LoadAassController m_controller;
  private boolean            m_bGenTagFile;

  private List<HtmlValue>         m_liVals;
  private List<ValoreByTag>         m_liTagVals;
  private Map<Integer, ValoreBySeq> m_liSeqs;
  private List<RigaHolder>          m_liRigaHolder;
  private List<CreaDataset>         m_liDataset;

  private AppProperties m_props;
  @Getter @Setter
  private ETipoFatt     tipoFatt;
  @Getter @Setter
  private TagValFactory tagFactory;

  @Getter @Setter
  private boolean    genPDFText;
  @Getter @Setter
  private boolean    genTagFile;
  @Getter @Setter
  private boolean    genHTMLFile;
  @Getter @Setter
  private boolean    lanciaExcel;
  @Getter @Setter
  private boolean    overwrite;
  private DBConn     connSQL;
  @Getter @Setter
  private RecIntesta recIntesta;

  public GestPDFFatt() throws ReadFattException {
    //
  }

  public GestPDFFatt(String p_string) throws ReadFattException, AppPropsException {
    setPdfFile(Paths.get(p_string));
    init();
  }

  public GestPDFFatt(Path p_pth) throws ReadFattException, AppPropsException {
    setPdfFile(p_pth);
    init();
  }

  public void convertiPDF(Path p_pdf) throws ReadFattException, AppPropsException {
    setPdfFile(p_pdf);
    init();
    convertiPDF();
  }

  public void convertiPDF() throws ReadFattException, AppPropsException {
    String szMsg = "Converto " + getPdfFile().toString();
    s_log.info(szMsg);
    updateMessage(szMsg + " Inizio...");
    convertiInHTML();
    if (tipoFatt == null) {
      s_log.error("Rinuncio interpretare {}", pdfFile.toString());
      return;
    }
    updateMessage(szMsg + " Analisi valori...");
    leggiCercaValori();
    cercaTagValues();
    updateMessage(szMsg + " Ricerca sequenze...");
    cercaSeqValues();
    renamePdfFiles();
    if (genHTMLFile) {
      creaDbValori();
      m_fromHtml.saveHtmlFile(m_HtmlFile);
    }
    updateMessage(szMsg + " scrivo su DB...");
    inserisciInDB();
    updateMessage(szMsg + " Fatto !");
  }

  private void renamePdfFiles() throws ReadFattValoreException {
    ValoreByTag tg = tagFactory.get(Consts.TGV_PeriodFattDtIniz);
    Date dtIniz = (Date) tg.getValore();
    tg = tagFactory.get(Consts.TGV_PeriodFattDtFine);
    Date dtFin = (Date) tg.getValore();
    String szNewName = String.format("%s_%s_%s.pdf", tipoFatt.getTitolo(), Utils.s_fmtY4MD.format(dtIniz),
        Utils.s_fmtY4MD.format(dtFin));
    String szOldName = pdfFile.getFileName().toString().toLowerCase();
    try {
      // FIXME quando rinomino il nome del file rimane quello vecchio nella lista
      if ( !szOldName.equals(szNewName.toLowerCase())) {
        s_log.warn("Rinomino \"{}\" in \"{}\"", szOldName, szNewName);
        Path newName = Paths.get(pdfFile.getParent().toString(), szNewName);
        int k = 1;
        while (Files.exists(newName)) {
          String seq = String.format("_%03d.pdf", k++);
          String szB = szNewName.replace(".pdf", seq);
          newName = Paths.get(pdfFile.getParent().toString(), szB);
        }
        Files.move(pdfFile, newName);
        setPdfFile(newName);
      }
    } catch (IOException | ReadFattException e) {
      s_log.error("Errore rename \"{}\" in \"{}\"", szOldName, szNewName, e);
    }
  }

  private void convertiInHTML() throws ReadFattPropsException, AppPropsException {
    m_fromHtml = new FromPdf2Html();
    if ( !m_fromHtml.convertiPDF(pdfFile)) {
      s_log.error("Errore di conversione PDF in HTML!");
      return;
    }
    if (tipoFatt == null)
      discerniTipoPropContenuto();
    if (tipoFatt == null) {
      s_log.warn("Non riesco a capire il tipo di documento!");
      return;
    }

    if (genTagFile) {
      m_fromHtml.saveTagFile(m_TagFile);
    }
    //    if (genHTMLFile) {
    //      m_fromHtml.saveHtmlFile(m_HtmlFile);
    //    }
    if (genPDFText) {
      m_fromHtml.saveTxtFile(m_TextFile);
    }
  }

  public void leggiCercaValori() throws ReadFattPropsException {
    m_liTagVals = new ArrayList<>();
    // qui metto i campi "by tag"
    int qtaBuchi = 0;
    for (int ndx = 1; ndx < 200 && qtaBuchi < 5; ndx++) {
      String szIndx = String.format("tag%02d", ndx);
      String szTagVal = m_props.getProperty(szIndx);
      if (szTagVal == null) {
        qtaBuchi++;
        continue;
      }
      String szFldNam = getFieldName(szTagVal);
      ValoreByTag vTag = tagFactory.creaValTag(szFldNam); // new ValoreByTag();
      if ( !vTag.parseProp(szTagVal))
        s_log.error("Errore parse tag:{}", szTagVal);
      else
        m_liTagVals.add(vTag);
    }
    if (m_liTagVals.size() < 2) {
      throw new ReadFattPropsException("Nelle props. mancano i tags");
    }
    // qui tratto i campi BySeq
    m_liSeqs = new HashMap<>();
    qtaBuchi = 0;
    for (int nSeq = 1; nSeq < 100 && qtaBuchi < 5; nSeq++) {
      ValoreBySeq seq = new ValoreBySeq();
      seq.setTagValFactory(tagFactory);
      seq.setNumSeq(nSeq);
      int qtaBuchi2 = 0;
      for (int ndx = 1; ndx < 100 && qtaBuchi2 < 5; ndx++) {
        String szIndx = String.format("seq%02d_%02d", nSeq, ndx);
        String szTagVal = m_props.getProperty(szIndx);
        if (szTagVal == null) {
          qtaBuchi2++;
          continue;
        }
        qtaBuchi2 = 0;
        seq.addSeq(szTagVal, nSeq);
      }
      if (seq.size() > 0)
        m_liSeqs.put(nSeq, seq);
      else {
        s_log.debug("Non esiste seq={}", nSeq);
        qtaBuchi++;
      }
    }
    if (m_liSeqs.size() < 1) {
      throw new ReadFattPropsException("Nelle props. mancano le seq.");
    }
    for (int grp = 1; grp < 100; grp++) {
      String szKey = String.format("grp%02d", grp);
      String szGrp = m_props.getProperty(szKey);
      if (szGrp == null)
        break;
      RigaHolder rg = new RigaHolder();
      m_liRigaHolder.add(rg);
      String arr[] = szGrp.split(",");
      for (String szNo : arr) {
        Integer ii = Integer.parseInt(szNo);
        ValoreBySeq seq = m_liSeqs.get(ii);
        if (seq == null) {
          String szMsg = String.format("Il gruppo %s=%s contiene indice fuori dalle sequenze", szKey, szGrp);
          s_log.error(szMsg);
          throw new ReadFattPropsException(szMsg);
        }
        seq.setRigaHolder(rg);
      }
    }
  }

  public List<HtmlValue> cercaTagValues() {
    // Iterator<Campo> enu = app.getListCampi().iterator();
    m_liVals = m_fromHtml.getListCampi();
    for (int k = 0; k < m_liVals.size(); k++) {
      HtmlValue cmp = m_liVals.get(k);
      if (cmp.isText()) {
        k = trovaValori(cmp, m_liVals, k);
      }
    }
    return m_liVals;
  }

  /**
   * In tutto l'elenco di {@link HtmlValue} cerco la corretta sequenza
   * presente in {@link ValoreBySeq}.
   *
   * @param liCmp
   */
  public void cercaSeqValues() {
    if (s_log.isTraceEnabled() && m_bGenTagFile)
      m_sbTraceSeq = new StringBuilder();
    int kk = 0;
    // semforo dei consumi effettivi
    boolean bSemaConsEffettivi = true;
    HtmlValue tgNumeric = null;
  
    try {
  
      for (int tagIndx = 0; tagIndx < m_liVals.size(); tagIndx++) {
        kk = tagIndx;
        HtmlValue tgv = m_liVals.get(tagIndx);
        tgNumeric = tgv.getTipo().isNumeric() ? tgv : null;
        if (s_log.isTraceEnabled() && m_bGenTagFile)
          m_sbTraceSeq.append(tgv.toString()).append("\n");
  
        // per scartare le righe delle letture stimate
        bSemaConsEffettivi = seConsumiEffettivi(tgv.getTxt(), bSemaConsEffettivi);
        for (Integer ii : m_liSeqs.keySet()) {
          ValoreBySeq seq = m_liSeqs.get(ii);
          if ( !seq.goodStart(tgv))
            continue;
          // nTagsAvanti != 0 trovata la sequenza
          int nTagsAvanti = seq.estraiValori(m_liVals, tagIndx);
          if (nTagsAvanti <= 0)
            continue;
          // trovato la sequenza !
          // per cui incremento la riga di pertinenza
          // if (bSemaConsEffettivi)
          seq.setStimato( !bSemaConsEffettivi);
          seq.addRiga();
          if (s_log.isTraceEnabled())
            traceScrivi(tagIndx, tagIndx + nTagsAvanti);
          // - 1 perche' poi ho tagIndx++
          tagIndx += nTagsAvanti - 1;
          tgNumeric = null;
          break;
        }
        if (tgNumeric != null && s_log.isTraceEnabled())
          s_log.trace("Scarto Tag Num:\n{}", traceScartoTgv(tagIndx));
      }
    } catch (Exception e) {
      System.out.println("GestPDFFatt.cercaSeqValues():" + e.getMessage());
    }
  
    s_log.trace("GestPDFFatt cercaSeqValues  qta tags =" + kk);
    if (m_sbTraceSeq != null && !m_sbTraceSeq.isEmpty()) {
      Path pth = Paths.get(m_TraceFile);
      try {
        Files.deleteIfExists(pth);
        byte[] bys = m_sbTraceSeq.toString().getBytes();
        Files.write(pth, bys);
        s_log.info("Scritto traceLog {}", m_TraceFile);
      } catch (IOException e) {
        s_log.error("Errore su trace file: {}, msg = {}", pth.toString(), e.getMessage());
      }
    }
  }

  private void creaDbValori() {
    String padre = Paths.get(pdfFile.getParent().toString(), "acqinfo").toString();
    String szPdfNoExt = FilenameUtils.removeExtension(pdfFile.getFileName().toString());
    String csvFile = Paths.get(padre, szPdfNoExt + ".csv").toString();
    try (BufferedWriter bw = new BufferedWriter(new FileWriter(csvFile, false))) {
      m_liDataset = new ArrayList<>();
      CreaDataset dts = new CreaDataset();
      dts.creaDtSet(m_liTagVals);
      // s_log.trace(dts.toString());
      bw.write(dts.toString());
      bw.write("\n");
      m_liDataset.add(dts);
      for (RigaHolder rh : m_liRigaHolder) {
        dts = new CreaDataset();
        dts.creaDtSet(rh);
        m_liDataset.add(dts);
        // s_log.trace(dts.toString());
        bw.write(dts.toString());
        bw.write("\n");
      }
      s_log.info("Scritto CSV file {}", csvFile);
    } catch (IOException e) {
      s_log.error("Errore scrittura file CSV", e);
    }
  }

  private void inserisciInDB() throws ReadFattException {
    ISql genfatt = FactoryFattura.getFatturaInserter(tipoFatt);
    genfatt.init(tagFactory, connSQL, getPdfFile());
    genfatt.setRecIntesta(getRecIntesta());
    genfatt.setTipoFatt(getTipoFatt());
    // ------ Fattura ---------
    try {
      if ( !genfatt.fatturaExist())
        genfatt.insertNewFattura();
      else if (isOverwrite()) {
        genfatt.deleteFattura();
        genfatt.insertNewFattura();
      } else {
        var val = tagFactory.get(Consts.TGV_FattNr).getValoreNoEx();
        s_log.warn("La fattura {} \"{}\" esiste gia' nel DB", tipoFatt.getTitolo(), val);
        return;
      }
    } catch (SQLException e) {
      s_log.error("Insert New Fattura {} error:{}", genfatt.getClass().getSimpleName(), e.getMessage(), e);
    }
    // ------ Lettura ---------
    try {
      if ( !genfatt.letturaExist())
        genfatt.insertNewLettura();
      else {
        var val = tagFactory.get(Consts.TGV_FattNr).getValoreNoEx();
        s_log.warn("La Lettura per {} No \"{}\" esiste gia' nel DB", tipoFatt.getTitolo(), val);
      }
    } catch (SQLException e) {
      s_log.error("Insert New Lettura {} error:{}", genfatt.getClass().getSimpleName(), e.getMessage(), e);
    }
    // ------ Consumo ---------
    try {
      if ( !genfatt.consumoExist())
        genfatt.insertNewConsumo();
      else {
        var val = tagFactory.get(Consts.TGV_FattNr).getValoreNoEx();
        s_log.warn("Il consumo per {} No \"{}\" esiste gia' nel DB", tipoFatt.getTitolo(), val);
      }
    } catch (SQLException e) {
      s_log.error("Insert New Consumo {} error:{}", genfatt.getClass().getSimpleName(), e.getMessage(), e);
    }
  }

  public void init() throws ReadFattException, AppPropsException {
    if (propertyFile != null) {
      m_props = new AppProperties();
      m_props.leggiPropertyFile(propertyFile);
    }
    if ( !Files.exists(pdfFile, LinkOption.NOFOLLOW_LINKS))
      throw new ReadFattException("Non esiste " + pdfFile.toString());
    Path pthPadre = Paths.get(pdfFile.getParent().toString(), "acqinfo");
    try {
      if ( !Files.exists(pthPadre))
        Files.createDirectories(pthPadre);
    } catch (IOException e) {
      String msg = String.format("Non riesco a creare il dir \"%s\"", pthPadre.toString());
      // s_log.error(msg);
      throw new ReadFattException(msg);
    }
    String padre = pthPadre.toString();

    String szPdfNoExt = FilenameUtils.removeExtension(pdfFile.getFileName().toString());
    m_TextFile = Paths.get(padre, szPdfNoExt + ".txt").toString();
    m_TagFile = Paths.get(padre, szPdfNoExt + "_Tags.txt").toString();
    m_HtmlFile = Paths.get(padre, szPdfNoExt + ".HTML").toString();
    m_TraceFile = Paths.get(padre, szPdfNoExt + "_TRACE.txt").toString();

    //    String szNoExt = FilenameUtils.removeExtension(pdfFile.toString());
    //    m_TextFile = szNoExt + ".txt";
    //    m_TagFile = szNoExt + "_Tags.txt";
    //    m_HtmlFile = szNoExt + ".HTML";
    m_liRigaHolder = new ArrayList<>();
    tagFactory = new TagValFactory();
    tagFactory.setProperties(m_props);
    if (null != LoadAassMainApp.getInst()) {
      m_controller = (LoadAassController) LoadAassMainApp.getInst().getController();
      m_bGenTagFile = m_controller.isGenTags();
    }
    m_sbTraceSeq = null;
  }

  private void discerniTipoPropDaNomeFile() {
    // discerno il tipo di property-file dal prefisso del nome file della fattura
    String szNam = pdfFile.getFileName().toString().toUpperCase();
    tipoFatt = null;
    for (ETipoFatt t : ETipoFatt.values()) {
      String sz = t.getTitolo() + "_";
      if (szNam.startsWith(sz)) {
        setTipoFatt(t);
        String szProp = String.format("Fatt%s_HTML.properties", t.getTitolo());
        setPropertyFile(Paths.get(szProp));
        break;
      }
    }
  }

  public void setPdfFile(Path p_pdf) throws ReadFattException {
    pdfFile = p_pdf;
    if (tipoFatt == null)
      discerniTipoPropDaNomeFile();
  }

  public void setPropertyFile(Path p_prop) {
    propertyFile = p_prop;
    if (tipoFatt != null)
      return;
    final String szPat = "Fatt([a-z]{2,3})_.*";
    Pattern pat = Pattern.compile(szPat);
    Matcher mtch = pat.matcher(szPat);
    if (mtch.matches()) {
      String gr = mtch.group(1);
      tipoFatt = ETipoFatt.parse(gr);
    }
  }

  public void discerniTipoPropContenuto() throws ReadFattPropsException, AppPropsException {
    String szTxt = m_fromHtml.getTextTAGs();
    if (szTxt.indexOf(CSZ_TEXT_GAS) >= 0)
      setTipoFatt(ETipoFatt.GAS);
    else if (szTxt.indexOf(CSZ_TEXT_EE) >= 0)
      setTipoFatt(ETipoFatt.EnergiaElettrica);
    else if (szTxt.indexOf(CSZ_TEXT_H2O) >= 0)
      setTipoFatt(ETipoFatt.Acqua);
    else if (szTxt.indexOf(CSZ_TEXT_SANG) >= 0)
      setTipoFatt(ETipoFatt.Analisi);
    else {
      s_log.warn("non sono riuscito a capire che tipo di Fattura AASS e': {}", pdfFile.toString());
      return;
    }
    if (propertyFile == null || m_props == null) {
      if (null == propertyFile) {
        String szProp = String.format("Fatt%s_HTML.properties", tipoFatt.getTitolo());
        setPropertyFile(Paths.get(szProp));
      }
      m_props = new AppProperties();
      m_props.leggiPropertyFile(propertyFile);
    }
  }

  private String getFieldName(String p_sz) {
    String szRet = null;
    String[] arr = p_sz.split(":");
    if (arr.length >= 1)
      szRet = arr[0];
    return szRet;
  }

  /**
   * A fronte di un {@link HtmlValue} di tipo {@link ETipiDato#Stringa}
   * verifico se in {@link ValoreByTag} esiste corrispondenza. Se esiste allora
   * delego il {@link ValoreByTag} di discernere il campo associato scandendo il
   * prossimo {@link HtmlValue} (gli ho fornito l'indice al prox valore)
   *
   * @param p_cmp
   *          il Campo in sequenza appena scandito
   * @param p_liCmp
   *          La lista dei {@link HtmlValue}
   * @param p_k
   *          l'indice su elemento valore
   */
  private int trovaValori(HtmlValue p_cmp, List<HtmlValue> p_liCmp, int p_k) {
    String szDegString = "Periodo di fatturazione dal";
    if (szDegString != null && p_liCmp.get(p_k + 1).getTxt().contains(szDegString)) {
      System.out.println();
      for (int i = p_k - 2; i <= p_k + 2; i++)
        if (i < p_liCmp.size())
          System.out.printf("%s%s\n", i == p_k ? ">" : " ", p_liCmp.get(i));
    }
    for (ValoreByTag cv : m_liTagVals) {
      try {
        if (cv.isAssegnabile() && cv.verificaCivetta(p_cmp)) {
          p_k += cv.estraiValori(p_liCmp, p_k + 1);
          break;
        }
      } catch (ReadFattValoreException e) {
        s_log.error("Errore in trovaValori per Tag: {}, ex={}", p_cmp.toString(), e);
      }
    }
    return p_k;
  }

  private boolean seConsumiEffettivi(String p_sz, boolean bPrecEffStim) {
    boolean bEff = bPrecEffStim;
    if (p_sz.contains("CONSUMI STIMATI"))
      bEff = false;
    else if (p_sz.contains("CONSUMI EFFETTIVI"))
      bEff = true;
    else if (p_sz.contains("TOTALE SERVIZI FORNITURA GAS"))
      bEff = true;
    return bEff;
  }

  private String traceScartoTgv(int ndx) {
    // style="background-color: #f02020;color: yellow;"
    StringBuilder sb = new StringBuilder();
    for (int j = ndx - 2; j <= ndx + 2; j++) {
      if (j < 0 || j >= m_liVals.size())
        continue;
      if (sb.length() > 0)
        sb.append("\n");
      HtmlValue tgv = m_liVals.get(j);
      sb.append("\t").append(tgv.toString());
      sb.append(j == ndx ? "\t <-- no seq!" : "");
      if (j == ndx) {
        if (null != m_sbTraceSeq)
          m_sbTraceSeq.append("\t no seq ! ^^^^\n");
        tgv.setNoSeq(true);
      }
    }
    return sb.toString();
  }

  private void traceScrivi(int p_tagIndx, int p_i) {
    if (null == m_sbTraceSeq)
      return;
    for (int k = p_tagIndx; k < p_i; k++) {
      HtmlValue tgv = m_liVals.get(k);
      m_sbTraceSeq.append(tgv.toString()).append("\n");
    }
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    for (ValoreByTag tg : m_liTagVals) {
      sb.append(tg.toString()).append("\n");
    }
    for (ValoreBySeq sq : m_liSeqs.values()) {
      sb.append(sq.toString()).append("\n");
    }
    return sb.toString();
  }

  public void setConnSql(DBConn p_connSQL) {
    connSQL = p_connSQL;
  }

  public void setFromPdf2HTML(FromPdf2Html p_pdf2h) {
    m_fromHtml = p_pdf2h;
  }

  @Override
  protected String call() throws Exception {
    System.out.println("GestPDFFatt Runner .call()");
    convertiPDF();
    //    System.out.println("RunTask() ... Sleep!");
    // Thread.sleep(500);
    return "...done!";
  }

}
