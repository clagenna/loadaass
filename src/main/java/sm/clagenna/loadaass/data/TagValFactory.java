package sm.clagenna.loadaass.data;

import java.util.Map;
import java.util.TreeMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import sm.clagenna.loadaass.sys.ex.ReadFattValoreException;

public class TagValFactory {

  private static final Logger      s_log = LogManager.getLogger(TagValFactory.class);
  private Map<String, ValoreByTag> m_map;

  public TagValFactory() {
    //
  }

  public ValoreByTag creaValTag(String p_nam) {
    ValoreByTag ret = null;
    if (p_nam == null) {
      s_log.error("Unnamed Tag ?!?");
      return ret;
    }
    if (m_map == null) {
      // @see https://www.baeldung.com/java-map-with-case-insensitive-keys
      m_map = new TreeMap<String, ValoreByTag>(String.CASE_INSENSITIVE_ORDER);
    }
    ret = m_map.get(p_nam);
    if (ret == null) {
      try {
        ret = new ValoreByTag();
        ret.setFieldName(p_nam);
        m_map.put(p_nam, ret);
      } catch (ReadFattValoreException e) {
        //
      }
    } else
      s_log.warn("Il tag \"{}\" esiste gia' vedi:{} !", p_nam, ret.toString());
    return ret;
  }

  public ValoreByTag get(String p_nam) {
    ValoreByTag ret = m_map.get(p_nam);
    if (ret == null)
      s_log.error("Il tag \"{}\" non e' stato creato !", p_nam);
    return ret;
  }
}
