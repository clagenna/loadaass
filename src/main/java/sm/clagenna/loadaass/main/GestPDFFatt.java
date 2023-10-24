package sm.clagenna.loadaass.main;

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

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.data.FactoryFattura;
import sm.clagenna.loadaass.data.RigaHolder;
import sm.clagenna.loadaass.data.TagValFactory;
import sm.clagenna.loadaass.data.TaggedValue;
import sm.clagenna.loadaass.data.ValoreBySeq;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.dbsql.Consts;
import sm.clagenna.loadaass.dbsql.CreaDataset;
import sm.clagenna.loadaass.dbsql.DBConn;
import sm.clagenna.loadaass.dbsql.ISql;
import sm.clagenna.loadaass.dbsql.SqlServIntest.RecIntesta;
import sm.clagenna.loadaass.enums.ETipiDato;
import sm.clagenna.loadaass.enums.ETipoFatt;
import sm.clagenna.loadaass.sys.AppProperties;
import sm.clagenna.loadaass.sys.Utils;
import sm.clagenna.loadaass.sys.ex.ReadFattException;
import sm.clagenna.loadaass.sys.ex.ReadFattPropsException;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;
import sm.clagenna.loadaass.tohtml.FromPdf2Html;

public class GestPDFFatt {

  private static final Logger       s_log = LogManager.getLogger(GestPDFFatt.class);
  private FromPdf2Html              m_fromHtml;

  @Getter
  private Path                      pdfFile;
  @Getter
  private Path                      propertyFile;
  private String                    m_TextFile;
  private String                    m_TagFile;
  private String                    m_HtmlFile;

  private List<TaggedValue>         m_liVals;
  private List<ValoreByTag>         m_liTagVals;
  private Map<Integer, ValoreBySeq> m_liSeqs;
  private List<RigaHolder>          m_liRigaHolder;
  private List<CreaDataset>         m_liDataset;

  private AppProperties             m_props;
  @Getter @Setter
  private ETipoFatt                 tipoFatt;
  @Getter @Setter
  private TagValFactory             tagFactory;

  @Getter @Setter
  private boolean                   genPDFText;
  @Getter @Setter
  private boolean                   genTagFile;
  @Getter @Setter
  private boolean                   genHTMLFile;
  @Getter @Setter
  private boolean                   lanciaExcel;
  @Getter @Setter
  private boolean                   overwrite;
  private DBConn                    connSQL;
  @Getter @Setter
  private RecIntesta                recIntesta;

  public GestPDFFatt(String p_string) throws ReadFattException {
    setPdfFile(Paths.get(p_string));
  }

  public GestPDFFatt(Path p_pth) throws ReadFattException {
    setPdfFile(p_pth);
  }

  public void convertiPDF(Path p_pdf) throws ReadFattException {
    setPdfFile(p_pdf);
    convertiPDF();
  }

  public void convertiPDF() throws ReadFattException {
    convertiInHTML();
    if (tipoFatt == null) {
      s_log.error("Rinuncio interpretare {}", pdfFile.toString());
      return;
    }
    leggiCercaValori();
    cercaTagValues();
    renamePdfFiles();
    cercaSeqValues();
    if (genHTMLFile)
      creaDbValori();
    inserisciInDB();
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
      }
    } catch (IOException e) {
      s_log.error("Errore rename \"{}\" in \"{}\"", szOldName, szNewName, e);
      // e.printStackTrace();
    }
  }

  private void convertiInHTML() throws ReadFattPropsException {
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
    if (genHTMLFile) {
      m_fromHtml.saveHtmlFile(m_HtmlFile);
    }
    if (genPDFText) {
      m_fromHtml.saveTxtFile(m_TextFile);
    }
  }

  private void leggiCercaValori() throws ReadFattPropsException {
    m_liTagVals = new ArrayList<>();
    // qui metto i campi "by tag"
    for (int ndx = 1; ndx < 100; ndx++) {
      String szIndx = String.format("tag%02d", ndx);
      String szTagVal = m_props.getProperty(szIndx);
      if (szTagVal == null)
        break;
      String szFldNam = getFieldName(szTagVal);
      ValoreByTag vTag = tagFactory.creaValTag(szFldNam); // new ValoreByTag();
      if ( !vTag.parseProp(szTagVal))
        s_log.error("Errore parse tag:{}", szTagVal);
      else
        m_liTagVals.add(vTag);
    }
    if (m_liTagVals.size() < 5) {
      throw new ReadFattPropsException("Nelle props. mancano i tags");
    }
    // qui tratto i campi BySeq
    m_liSeqs = new HashMap<>();
    boolean bContinua = true;
    for (int nSeq = 1; nSeq < 100 && bContinua; nSeq++) {
      ValoreBySeq seq = new ValoreBySeq();
      seq.setTagValFactory(tagFactory);
      seq.setNumSeq(nSeq);
      for (int ndx = 1; ndx < 100 && bContinua; ndx++) {
        String szIndx = String.format("seq%02d_%02d", nSeq, ndx);
        String szTagVal = m_props.getProperty(szIndx);
        if (szTagVal == null) {
          // bContinua = false;
          break;
        }
        seq.addSeq(szTagVal, nSeq);
      }
      if (seq.size() > 0)
        m_liSeqs.put(nSeq, seq);
      else
        bContinua = false;
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

  private List<TaggedValue> cercaTagValues() {
    // Iterator<Campo> enu = app.getListCampi().iterator();
    m_liVals = m_fromHtml.getListCampi();
    for (int k = 0; k < m_liVals.size(); k++) {
      TaggedValue cmp = m_liVals.get(k);
      if (cmp.isText()) {
        k = trovaValori(cmp, m_liVals, k);
      }
    }
    return m_liVals;
  }

  private void creaDbValori() {
    m_liDataset = new ArrayList<>();
    CreaDataset dts = new CreaDataset();
    dts.creaDtSet(m_liTagVals);
    s_log.trace(dts.toString());
    m_liDataset.add(dts);
    for (RigaHolder rh : m_liRigaHolder) {
      dts = new CreaDataset();
      dts.creaDtSet(rh);
      m_liDataset.add(dts);
      s_log.trace(dts.toString());
    }
  }

  private void inserisciInDB() throws ReadFattException {
    ISql genfatt = FactoryFattura.getFatturaInserter(tipoFatt);
    genfatt.init(tagFactory, connSQL);
    genfatt.setRecIntesta(getRecIntesta());
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

  public void init() throws ReadFattException {
    if (propertyFile != null) {
      m_props = new AppProperties();
      m_props.leggiPropertyFile(propertyFile);
    }

    if ( !Files.exists(pdfFile, LinkOption.NOFOLLOW_LINKS))
      throw new ReadFattException("Non esiste " + pdfFile.toString());
    String szNoExt = FilenameUtils.removeExtension(pdfFile.toString());
    m_TextFile = szNoExt + ".txt";
    m_TagFile = szNoExt + "_Tags.txt";
    m_HtmlFile = szNoExt + ".HTML";
    m_liRigaHolder = new ArrayList<>();
    tagFactory = new TagValFactory();
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

  private void setPdfFile(Path p_pdf) throws ReadFattException {
    pdfFile = p_pdf;
    if (tipoFatt == null)
      discerniTipoPropDaNomeFile();
    init();
  }

  public void setPropertyFile(Path p_prop) {
    propertyFile = p_prop;
    if (tipoFatt != null)
      return;
    final String szPat = "Fatt([a-z]{2-3})_.*";
    Pattern pat = Pattern.compile(szPat);
    Matcher mtch = pat.matcher(szPat);
    if (mtch.matches()) {
      String gr = mtch.group(1);
      tipoFatt = ETipoFatt.parse(gr);
    }
  }

  private void discerniTipoPropContenuto() throws ReadFattPropsException {
    String szTxt = m_fromHtml.getTextTAGs();
    if (szTxt.indexOf("Servizio Gas Naturale") >= 0)
      setTipoFatt(ETipoFatt.GAS);
    else if (szTxt.indexOf("Servizio Energia Elettrica") >= 0)
      setTipoFatt(ETipoFatt.EnergiaElettrica);
    else if (szTxt.indexOf("Servizio Idrico Integrato") >= 0)
      setTipoFatt(ETipoFatt.Acqua);
    else
      s_log.warn("non sono riuscito a capire che tipo di Fattura AASS e'");
    if (propertyFile == null || m_props == null) {
      String szProp = String.format("Fatt%s_HTML.properties", tipoFatt.getTitolo());
      setPropertyFile(Paths.get(szProp));
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
   * A fronte di un {@link TaggedValue} di tipo {@link ETipiDato#Stringa}
   * verifico se in {@link ValoreByTag} esiste corrispondenza. Se esiste allora
   * delego il {@link ValoreByTag} di discernere il campo associato scandendo il
   * prossimo {@link TaggedValue} (gli ho fornito l'indice al prox valore)
   *
   * @param p_cmp
   *          il Campo in sequenza appena scandito
   * @param p_liCmp
   *          La lista dei {@link TaggedValue}
   * @param p_k
   *          l'indice su elemento valore
   */
  private int trovaValori(TaggedValue p_cmp, List<TaggedValue> p_liCmp, int p_k) {
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

  /**
   * In tutto l'elenco di {@link TaggedValue} cerco la corretta sequenza
   * presente in {@link ValoreBySeq}.
   *
   * @param liCmp
   */
  private void cercaSeqValues() {
    int kk = 0;
    boolean bSemaConsEffettivi = true;
    for (int tagIndx = 0; tagIndx < m_liVals.size(); tagIndx++) {
      kk = tagIndx;
      TaggedValue tgv = m_liVals.get(tagIndx);
      // per scartare le righe delle letture stimate
      if (tgv.getTxt().contains("CONSUMI STIMATI"))
        bSemaConsEffettivi = false;
      if (tgv.getTxt().contains("TOTALE SERVIZI FORNITURA GAS"))
        bSemaConsEffettivi = true;

      for (Integer ii : m_liSeqs.keySet()) {
        ValoreBySeq seq = m_liSeqs.get(ii);
        if ( !seq.goodStart(tgv)) {
          continue;
        }
        int nTagsAvanti = seq.estraiValori(m_liVals, tagIndx);
        if (nTagsAvanti != 0) {
          // trovato la sequenza !
          // per cui incremento la riga di pertinenza
          if (bSemaConsEffettivi)
            seq.addRiga();
          // - 1 perche' poi ho tagIndx++
          tagIndx += nTagsAvanti - 1;
          break;
        } else {
          s_log.trace("La seq N.{}\n\t{} non match-a col val:\n\t{}", //
              seq.getNumSeq(), //
              seq.getValoreTag(0).toString(), //
              tgv.toString());
        }
      }
    }
    s_log.trace("GestPDFFatt cercaSeqValues  qta tags =" + kk);
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

}
