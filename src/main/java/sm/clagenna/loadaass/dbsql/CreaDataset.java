package sm.clagenna.loadaass.dbsql;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import sm.clagenna.loadaass.data.RigaHolder;
import sm.clagenna.loadaass.data.ValoreBySeq;
import sm.clagenna.loadaass.data.ValoreByTag;
import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class CreaDataset {
  private static int               NWIDTH = 20;

  private Map<String, ValoreByTag> m_map;
  private int                      m_nRighe;

  public CreaDataset() {
    m_map = new TreeMap<String, ValoreByTag>(String.CASE_INSENSITIVE_ORDER);
    m_nRighe = -1;
  }

  public int creaDtSet(RigaHolder pRh) {
    List<ValoreBySeq> li = pRh.getListSeq();
    for (ValoreBySeq seq : li) {
      Collection<? extends ValoreByTag> liVal = seq.allVals();
      for (ValoreByTag vbt : liVal) {
        if (m_map.containsKey(vbt.getFieldName()))
          continue;
        try {
          Object obj = vbt.getValore();
          if (obj instanceof List<?>) {
            int n = ((List<?>) obj).size();
            m_nRighe = n > m_nRighe ? n : m_nRighe;
          } else
            m_nRighe = 1;
        } catch (ReadFattValoreException e) {
          e.printStackTrace();
        }
        m_map.put(vbt.getFieldName(), vbt);
      }
    }
    return m_map.size();
  }

  public int creaDtSet(List<ValoreByTag> livbt) {
    m_nRighe = 1;
    for (ValoreByTag vbt : livbt) {
      if (m_map.containsKey(vbt.getFieldName()))
        continue;
      m_map.put(vbt.getFieldName(), vbt);
    }
    return m_map.size();
  }

  public boolean isMultiRow() {
    return m_nRighe > 1;
  }

  public Object getValue(String field) throws ReadFattValoreException {
    return getValue(field, 0);
  }

  public Object getValue(String field, int Riga) throws ReadFattValoreException {
    ValoreByTag vbt = m_map.get(field);
    if (vbt == null)
      return null;
    Object obj = vbt.getValore(Riga);
    return obj;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    String sz = " ".repeat(NWIDTH * (m_map.size() + 1));
    int n = 0;
    for (String key : m_map.keySet()) {
      sz = replace(sz, key, n++);
    }
    sb.append(sz.trim()).append("\n");

    for (int r = 0; r < m_nRighe; r++) {
      sz = " ".repeat(NWIDTH * (m_map.size() + 1));
      n = 0;
      for (String key : m_map.keySet()) {
        ValoreByTag tbv = m_map.get(key);
        Object obj = null;
        if (tbv.isArray()) {
          if (tbv.hasRiga(r))
            obj = tbv.getValoreNoEx(r);
        } else
          obj = tbv.getValoreNoEx();
        String szv = tbv.formattaObj(obj);
        sz = replace(sz, szv, n++);
      }
      sb.append(sz.trim()).append("\n");
    }
    return sb.toString();
  }

  private String replace(String sz, String cosa, int ndx) {
    int p = ndx * NWIDTH;
    String left = "";
    if (ndx > 0)
      left = sz.substring(0, p);
    String right = "";
    int p2 = p + cosa.length();
    if (p2 < sz.length())
      right = sz.substring(p2);
    sz = left + cosa + right;
    return sz;
  }
}
