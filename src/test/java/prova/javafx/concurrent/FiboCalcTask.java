package prova.javafx.concurrent;

import javafx.concurrent.Task;

public class FiboCalcTask extends Task<Long> {

  private final int n;
  private long      last;

  public FiboCalcTask(int n) {
    this.n = n;
  }

  @Override
  protected Long call() throws Exception {
    System.out.println("FiboCalcTask.call() --> Inizio!");
    updateMessage("    Processing... ");
    long result = fibonacci(n);
    System.out.println("FiboCalcTask.call() --> Finito!");
    updateMessage("    Done.  ");
    return result;
  }

  public long fibonacci(long number) {
    if (number <= 1)
      return number;
    if (last < number) {
      last = number;
      updateMessage("    Processing... " + number);
    }

    return fibonacci(number - 1) + fibonacci(number - 2);
  }
}
