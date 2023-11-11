package prova;

import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 * Vari test delle features apparse dopo JDK.8 al JDK.21 <a href=
 * "https://advancedweb.hu/a-categorized-list-of-all-java-and-jvm-features-since-jdk-8-to-21/">Vedi
 * articolo</a>
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
	}

	private void recordPattern() {
		MyRecord mr = new MyRecord(11, "claudio", 23.57);
		if (mr instanceof MyRecord(int x, String y, double z)) {
			System.out.println("x = " + x);
			System.out.println("y = " + y);
			System.out.println("z = " + z);
		}

	}

	public void guardedTypePattern() {
		Object obj = Integer.valueOf(23);
		String sz = typePattern2(obj);
		System.out.println(sz);
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
	 * case Integer i when i > 10 -> String.format("Grande int %d", i);
	 * case Integer i -> String.format("Piccolo int %d", i);
	 * case BigDecimal bd -> fx.format(bd);
	 * default -> obj.toString();
	 * };
	 * </pre>
	 *
	 * @param obj
	 * @return
	 */
	private String typePattern2(Object obj) {
		String fmt = null;

		// questo invece funziona (non guarded pattern)
		String sz = "b";
		switch (sz) {
		case "a" -> System.out.println("Lettera A");
		case "b" -> System.out.println("Lettera B");
		default -> System.out.println("Non lo so!");
		}

		final DecimalFormat fx = new DecimalFormat("#.00");
		fmt = switch (obj) {
		case Integer i when i > 10 -> String.format("Grande int %d", i);
		case Integer i -> String.format("Piccolo int %d", i);
		case BigDecimal bd -> fx.format(bd);
		default -> obj.toString();
		};

		return fmt;
	}

}
