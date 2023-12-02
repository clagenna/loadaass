package prova.javafx.concurrent;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

/**
 * Questo utilizza {@link Runnable} e non quello di javafx quindi da' errore sul
 * "{@link #runTask()}" nella <code>statusLabel.setText(status);</code>!
 *
 * <pre>
 * Exception in thread "Thread-3" java.lang.IllegalStateException: Not on FX application thread; currentThread = Thread-3
 * at javafx.graphics@20.0.2/com.sun.javafx.tk.Toolkit.checkFxUserThread(Toolkit.java:294)
 * </pre>
 *
 * Il metodo <code>runTask()</code> viene eseguito su un <b>nuovo</b> thread,
 * denominato <code>Thread-4</code> come mostrato nell'analisi dello stack, che
 * non è <b>JavaFX Application Thread</b>.<br/>
 * L'istruzione precedente imposta la proprietà text per Label, che fa parte di
 * un grafo <code>Scene</code> attivo, dal thread diverso da JavaFX Application
 * Thread, il che <b>non è consentito</b>.
 * <h2>Soluzione (a meta'!)</h2><br/>
 * The Platform class in the javafx.application package provides <b>two static
 * methods</b> to work with the JavaFX Application Thread.
 *
 * <pre>
public static boolean isFxApplicationThread()
public static void runLater(Runnable runnable)
 * </pre>
 *
 * The <code>isFxApplicationThread()</code> method returns true if the thread
 * calling this method is the JavaFX Application Thread. Otherwise, it returns
 * false.<br/>
 * The <code>runLater()</code> method schedules the specified Runnable to be run
 * on the JavaFX Application Thread at some unspecified <b>time in future</b>
 * !!!
 * @see {@link FxConcurrencyExample3}
 * @see https://examples.javacodegeeks.com/java-development/desktop-java/javafx/javafx-concurrency-example/
 */
public class FxConcurrencyExample2 extends Application {
  // Create the TextArea
  TextArea textArea = new TextArea();

  // Create the Label
  Label statusLabel = new Label("Not Started...");

  // Create the Buttons
  Button startButton = new Button("Start");
  Button exitButton  = new Button("Exit");

  public static void main(String[] args) {
    Application.launch(args);
  }

  @Override
  public void start(final Stage stage) {
    // Create the Event-Handlers for the Buttons
    startButton.setOnAction(new EventHandler<ActionEvent>() {
      @Override
      public void handle(ActionEvent event) {
        startTask();
      }
    });

    exitButton.setOnAction(new EventHandler<ActionEvent>() {
      @Override
      public void handle(ActionEvent event) {
        System.out.println("EventHandler() ExitButton Click");
        stage.close();
      }
    });

    // Create the ButtonBox
    HBox buttonBox = new HBox(5, startButton, exitButton);

    // Create the VBox
    VBox root = new VBox(10, statusLabel, buttonBox, textArea);

    // Set the Style-properties of the VBox
    root.setStyle("-fx-padding: 10;" //
        + "-fx-border-style: solid inside;" //
        + "-fx-border-width: 2;" //
        + "-fx-border-insets: 5;" //
        + "-fx-border-radius: 5;" //
        + "-fx-border-color: blue;");

    // Create the Scene
    Scene scene = new Scene(root, 400, 300);
    // Add the scene to the Stage
    stage.setScene(scene);
    // Set the title of the Stage
    stage.setTitle("A simple Concurrency Example");
    // Display the Stage
    stage.show();
  }

  public void startTask() {
    // Create a Runnable
    Runnable task = new Runnable() {
      @Override
      public void run() {
        runTask();
      }
    };

    // Run the task in a background thread
    Thread backgroundThread = new Thread(task);
    // Terminate the running thread if the application exits
    backgroundThread.setDaemon(true);
    // Start the thread
    backgroundThread.start();
  }

  public void runTask() {
    for (int i = 1; i <= 10; i++) {
      try {
        String status = "Processing " + i + " of " + 10;
        statusLabel.setText(status);
        textArea.appendText(status + "\n");
        System.out.println("FxConcurrencyExample2.runTask():" + status);
        Thread.sleep(1000);
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }
  }
}
