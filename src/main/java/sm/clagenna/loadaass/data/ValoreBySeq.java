package sm.clagenna.loadaass.data;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import lombok.Getter;
import lombok.Setter;
import sm.clagenna.loadaass.enums.ETipiDato;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class ValoreBySeq {

  private static final Logger s_log = LogManager.getLogger(ValoreBySeq.class);

  private List<ValoreByTag> m_liSeq;
  @Getter
  private RigaHolder        rigaHolder;
  @Getter @Setter
  private int               numSeq;
  private TagValFactory     m_tagFact;

  public ValoreBySeq() {
    //
  }

  public ValoreBySeq(String p_fldNam, ETipiDato p_tipoc, boolean p_isArray) {
    addSeq(p_fldNam, p_tipoc, p_isArray);
  }

  /**
   * Verifica che il tipo del campo p_cmp è uguale al tipo del primo elemento
   * della sequenza
   *
   * @param p_cmp
   *          campo tagged fornito come partenza della sequenza
   * @return true se combacia la tipologia
   */
  public boolean goodStart(TaggedValue p_cmp) {
    ValoreByTag primo = m_liSeq.get(0);
    boolean bRet = p_cmp.getTipo().isCompatible(primo.getTipoDato());
    if (bRet) {
      // il tipo combacia, vediamo se anche il campo civetta
      if (primo.hasCivetta())
        bRet = primo.verificaCivetta(p_cmp);
    }
    return bRet;
  }

  /**
   * Aggiunge elemento di sequenza<br/>
   * Abbiamo almeno 5 elementi per ogni membro di sequenza<br/>
   * <ol>
   * <li>Il nome campo definito con {@link ValoreByTag}</li>
   * <li>eventuale campo civetta (opzionale)</li>
   * <li>Tipo di dato aspettato (vedi {@link ETipiDato})</li>
   * <li>riga posizione in Excel</li>
   * <li>Colonna in Excel</li>
   * </ol>
   *
   * @param p_szProp
   * @param p_nSeq
   * @return
   */
  public boolean addSeq(String p_szProp, int p_nSeq) {
    String[] arr = p_szProp.split(":");
    if (arr == null || arr.length < 4) {
      s_log.error("pochi campi tag {}", p_szProp);
      return false;
    }
    String szNam = arr[0];
    String szCivetta = arr[1];
    ETipiDato tipoc = ETipiDato.decode(arr[2]);
    int nExcCol = -1;
    int nExcRiga = -1;
    if ( !arr[3].equals("-") && !arr[4].equals("-")) {
      nExcCol = arr[3].toLowerCase().charAt(0) - 'a';
      nExcRiga = Integer.parseInt(arr[4]) - 1;
    }
    boolean bArray = false;
    if (arr.length >= 6) {
      String sz = arr[5].toLowerCase();
      switch (sz) {
        case "t":
        case "1":
          bArray = true;
          break;
      }
    }
    if (m_liSeq == null)
      m_liSeq = new ArrayList<>();
    ValoreByTag cmp = m_tagFact.creaValTag(szNam); // new ValoreByTag(szNam, szCivetta, tipoc, bArray);
    cmp.assegna(szCivetta, tipoc, bArray);
    cmp.setExcelCoord(nExcCol, nExcRiga);
    setNumSeq(p_nSeq);
    m_liSeq.add(cmp);
    return true;
  }

  public void addSeq(String p_fldNam, ETipiDato p_tipoc, boolean b_arr) {
    if (m_liSeq == null)
      m_liSeq = new ArrayList<>();
    ValoreByTag cmp = m_tagFact.creaValTag(p_fldNam); // new ValoreByTag(p_fldNam, "*", p_tipoc, b_arr);
    cmp.assegna("*", p_tipoc, b_arr);
    m_liSeq.add(cmp);
  }

  public int estraiValori(List<TaggedValue> p_liCmp, int p_k) {
    TaggedValue tgv = p_liCmp.get(p_k);
    int j = 0;
    // verifico che la la tipologia sequenza combaci con tipolog tags
    for (ValoreByTag tg : m_liSeq) {
      int indx = p_k + j++;
      if (indx >= p_liCmp.size())
        return 0;
      tgv = p_liCmp.get(indx);
      if ( !tg.getTipoDato().isCompatible(tgv.getTipo())) {
        s_log.trace("Seq({})[{}]:\"{}\"({}) <> Tgv:\"{}\"({})", //
            getNumSeq(), //
            j - 1, tg.getFieldName(), //
            tg.getTipoDato(), //
            tgv.getTxt(), //
            tgv.getTipo()); //
        return 0;
      }
    }
    // tutta la sequenza combacia per tipologia
    j = 0;
    for (ValoreByTag tg : m_liSeq) {
      tgv = p_liCmp.get(p_k + j++);
      try {
        tg.assegnaValDaCampo(tgv, rigaHolder.getRiga());
        // System.out.println("ValoreBySeq.estraiValori()=" + this.toString());
      } catch (ReadFattValoreException e) {
        s_log.error("Errore assegna seq:{} = {}", tg.getFieldName(), tgv.toString());
      }
    }
    return j;
  }

  /**
   * Imposta il flag di <code>stimato</code> su tutti i <b>valori</b> della
   * sequenza alla riga specificata dal {@link RigaHolder}
   *
   * @param p_b
   *          il valore di "Stimato"
   */
  public void setStimato(boolean p_b) {
    int nRig = rigaHolder.getRiga();
    for (ValoreByTag tg : m_liSeq) {
      tg.setStimato(nRig, p_b);
    }
  }

  @Override
  public String toString() {
    String sz = String.format("\nSeq(%d) {%s}\n\t", getNumSeq(), rigaHolder != null ? rigaHolder.toString() : "*noRigH*");
    String vir = "";
    if (m_liSeq == null || m_liSeq.size() == 0) {
      sz += "**NULL**";
      return sz;
    }
    int k = 0;
    for (ValoreByTag p : m_liSeq) {
      sz += vir; // + p.getTipoDato();
      //      Object val = p.getValoreNoEx();
      //      String szV = (val != null && !val.getClass().getSimpleName().equals("Object")) ? p.toString() : "*null*";
      //      sz += String.format("(%d){%s}", k++, szV);
      sz += String.format("(%d){%s\n\t}", k++, p.toString());
      vir = "\n\t";
    }
    return sz;
  }

  public Collection<? extends ValoreByTag> allVals() {
    return m_liSeq;
  }

  public int size() {
    if (m_liSeq == null)
      return 0;
    return m_liSeq.size();
  }

  public void addRiga() {
    if (rigaHolder != null)
      rigaHolder.addRiga();
    else
      s_log.error("La seq {} non ha riga holder!", numSeq);
    // System.out.println("ValoreBySeq.addRiga()" + this.toString());
  }

  public void setRigaHolder(RigaHolder p_rh) {
    rigaHolder = p_rh;
    p_rh.addSeq(this);
  }

  public void setTagValFactory(TagValFactory p_Fact) {
    m_tagFact = p_Fact;
  }

  public Object getValoreTag(int p_i) {
    ValoreByTag ret = null;
    if (m_liSeq == null || m_liSeq.size() <= p_i)
      return ret;
    return m_liSeq.get(p_i);
  }
}
