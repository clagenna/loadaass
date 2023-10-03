package sm.clagenna.loadaass.data;

public class Civetta {
  private String  m_civetta;
  private boolean m_exact;

  public Civetta(String p_sz) {
    setCivetta(p_sz);
  }

  public boolean verificaCivetta(TaggedValue p_cmp) {
    if (m_civetta == null || m_civetta.equals("*"))
      return false;
    if (m_exact)
      return p_cmp.getTxt().equals(m_civetta);
    return p_cmp.getTxt().indexOf(m_civetta) >= 0;
  }

  public void setCivetta(String p_sz) {
    m_exact = false;
    m_civetta = p_sz;
    if (p_sz.trim().startsWith("'")) {
      m_exact = true;
      m_civetta = p_sz.replaceAll("'", "");
    }
  }

  public String getCivetta() {
    return m_civetta;
  }

}
