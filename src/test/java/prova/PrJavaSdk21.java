package prova;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Vari test delle features apparse dopo JDK.8 al JDK.21 <a href=
 * "https://advancedweb.hu/a-categorized-list-of-all-java-and-jvm-features-since-jdk-8-to-21/">Vedi
 * articolo</a><br/>
 * Inoltre va ricordato che per lavorare con JavaFx occorre mettere:<br/>
 * <code>--module-path "C:/Program Files/Java/javafx-sdk-20.0.2/lib" --add-modules=javafx.controls,javafx.fxml</code><br/>
 * nei parametri della VM
 *
 * @author claudio
 */
public class PrJavaSdk21 {

  record MyRecord(int a, String b, double c) {
  }

  public PrJavaSdk21() {
    //
  }

  public static void main(String[] arc) {
    var app = new PrJavaSdk21();
    app.guardedTypePattern(); // jdk.21
    app.recordPattern();
    app.unnamedVar();
    app.stringTemplates();
    app.shaaaf();
  }

  private void guardedTypePattern() {
    Object obj = Integer.valueOf(23);
    String sz = typePattern2(obj);
    System.out.println(sz);
  }

  private void recordPattern() {
    MyRecord mr = new MyRecord(11, "claudio", 23.57);
    if (mr instanceof MyRecord(int x, String y, double z)) {
      System.out.println("x = " + x);
      System.out.println("y = " + y);
      System.out.println("z = " + z);
    }

  }

  @SuppressWarnings("unused")
  private void unnamedVar() {
    List<String> li = new ArrayList<>();
    //    var _ = li.add("claudio");
    //    try {
    //      li.add("bruno");
    //    } catch (Exception _) {
    //
    //    }
  }

  /**
   * Vedi anche l'articolo
   * <a href="https://www.baeldung.com/java-21-string-templates">su Baeldung</a>
   */
  @SuppressWarnings("unused")
  private void stringTemplates() {
    String nome = "claudio";
    String cognome = "gennari";
    int eta = 65;

    int x = 10;
    int y = 20;
    //        String result1 = fmt."\{x} + \{y} = \{x + y}";
    //        String result2 = fmt."%s\{x} + %s\{y} = %s\{x + y}";

    String msg = MessageFormat.format("Io mi chiamo {0} e di nome {1} ed ho {2} anni", nome, cognome, eta);
    //    String info = STR."""
    //        Oggi {nome} { cognome} compie { eta } anni
    //""";
    //    System.out.println(info);
    String feelsLike = "Good";
    double temperature = 23.7;
    String unit = "Degree";
    String szp = """
        stringa
        a capo
        """;
    //    info =FormatProcessor.FMT."""
    //        {
    //          "feelsLike": "%1s{ feelsLike }",
    //          "temperature": "%2.2f{ temperature }",
    //          "unit": "%1s{ unit }"
    //        }
    //""";

  }

  /**
   * Provo i <i>guarded pattern</i> on <code>switch</code> statement<br/>
   * che <b>NON</b> va in eclipse !!! vedi <a target="_blank"
   * target"https://marketplace.eclipse.org/comment/8473#comment-8473">Eclipse
   * Market Place</a><br/>
   * mentre se compilato con:<br/>
   * <code>javac src\test\java\prova\PrJavaSdk21.java </code><br/>
   * <b>funziona</b>!!!<br/>
   *
   * <pre>
   * final DecimalFormat fx = new DecimalFormat("#.00");
   * fmt = switch (obj) {
   *   case Integer i when i > 10 -> String.format("Grande int %d", i);
   *   case Integer i -> String.format("Piccolo int %d", i);
   *   case BigDecimal bd -> fx.format(bd);
   *   default -> obj.toString();
   * };
   * </pre>
   *
   * @param obj
   * @return
   */
  private String typePattern2(Object obj) {
    String fmt = null;

    final DecimalFormat fx = new DecimalFormat("#.00");
    fmt = switch (obj) {
      case Integer i when i > 10 -> String.format("Grande int %d", i);
      case Integer i -> String.format("Piccolo int %d", i);
      case BigDecimal bd -> fx.format(bd);
      default -> obj.toString();
    };

    // questo invece funziona (non guarded pattern)
    String sz = "b";
    switch (sz) {
      case "a" -> System.out.println("Lettera A");
      case "b" -> System.out.println("Lettera B");
      default -> System.out.println("Non lo so!");
    }

    return fmt;
  }

  private void shaaaf() {
    // As of Java 21
    //    String name = "Shaaf";
    //    String greeting = "Hello \{name}";
    //    System.out.println(greeting);
  }

}
