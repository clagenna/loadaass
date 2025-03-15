package sm.clagenna.loadaass.data;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.Data;
import sm.clagenna.stdcla.utils.ParseData;
import sm.clagenna.stdcla.utils.Utils;

@Data
public class EsSang {

  private int           codiss;
  private LocalDateTime dtExam;
  private String        esame;
  private Double        esito;
  private String        unMisura;
  private Double        valRifMin;
  private Double        valRifMax;
  private String        valMinMax;
  private boolean       alarme;

  public EsSang() {
    init();
  }

  private void init() {
    codiss = -1;
    dtExam = null;
    esame = null;
    esito = null;
    unMisura = null;
    valRifMin = null;
    valRifMax = null;
    alarme = false;

  }

  public boolean assegna(TagValFactory fact, int riga) {
    // Allarme, Codiss, DataAccet, Perc, TipoEsame, Tratt, UnMisura, ValMax, ValMin, Valore
    Object vv = null;
    ValoreByTag vtg = null;

    try {
      vtg = fact.get("Codiss");
      codiss = (Integer) vtg.getValore();

      Date dt = fact.getDate("DataAccet");
      dtExam = ParseData.toLocalDateTime(dt);

      vtg = fact.get("TipoEsame");
      if ( !vtg.hasRiga(riga))
        return false;

      vv = vtg.getValore(riga);
      esame = vv.toString();
      final String szExcl[] = { "iss:", "ise su", "Page" };
      for (String sz : szExcl)
        if (esame.toLowerCase().contains(sz))
          return false;

      vtg = fact.get("Valore");
      vv = vtg.getValore(riga);
      esito = (Double) vv;

      vtg = fact.get("Allarme");
      if (vtg.hasRiga(riga)) {
        vv = vtg.getValore(riga);
        alarme = Utils.isValue(vv);
      }

      vtg = fact.get("UnMisura");
      vv = vtg.getValore(riga);
      if (vv instanceof String sz)
        unMisura = sz;

      //      vtg = fact.get("ValMin");
      //      if ( null != vtg &&  vtg.hasRiga(riga)) {
      //        vv = vtg.getValore(riga);
      //        if (vv instanceof Number nm) {
      //          valRifMin = nm.doubleValue();
      //        }
      //      }
      //
      //      vtg = fact.get("ValMax");
      //      if (null != vtg && vtg.hasRiga(riga)) {
      //        vv = vtg.getValore(riga);
      //        if (vv instanceof Number nm) {
      //          valRifMax = nm.doubleValue();
      //        }
      //      }

      vtg = fact.get("ValMinMax");
      if (null != vtg && vtg.hasRiga(riga)) {
        vv = vtg.getValore(riga);
        if (vv instanceof String nm) {
          valMinMax = nm;
        }
      }

    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
    System.out.println(String.valueOf(riga) + ":" + toString());
    return true;
  }

  @Override
  public String toString() {
    String szMinMax = "";
    String lum = null != unMisura ? unMisura : "?";
    if (null != valRifMin || null != valRifMax) {
      double lMin = null != valRifMin ? valRifMin.doubleValue() : 0f;
      double lMax = null != valRifMax ? valRifMax.doubleValue() : 0f;
      szMinMax = String.format("[%s - %s]", lMin, lMax);
    } else if (null != valMinMax) {
      szMinMax = valMinMax;
    }
    return String.format("%s) %6d %-32s %s %1s %-13s %s ", //
        ParseData.s_fmtY4MD.format(dtExam), //
        codiss, //
        esame, //
        Utils.formatDouble(esito), //
        alarme ? "*" : "", //
        lum, //
        szMinMax);
  }
}
