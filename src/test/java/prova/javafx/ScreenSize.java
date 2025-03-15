package prova.javafx;

import javafx.application.Application;
import javafx.collections.ObservableList;
import javafx.geometry.Rectangle2D;
import javafx.stage.Screen;
import javafx.stage.Stage;

public class ScreenSize extends Application {

  public static void main(String[] args) {
    Application.launch(args);
  }

  @Override
  public void start(Stage primaryStage) {
    ObservableList<Screen> screenSizes = Screen.getScreens();
    double minX = 0, maxX = 0, minY = 0, maxY = 0;
    for (Screen scr : screenSizes) {
      Rectangle2D rect = scr.getBounds();
      minX = rect.getMinX() < minX ? rect.getMinX() : minX;
      maxX = rect.getMaxX() > maxX ? rect.getMaxX() : maxX;
      minY = rect.getMinY() < minY ? rect.getMinY() : minY;
      maxY = rect.getMaxY() > maxY ? rect.getMaxY() : maxY;
    }
    screenSizes.forEach(screen -> {
      System.out.println(screen.getBounds());
    });
    System.out.printf("Min Max X: %f\t%f\n", minX, maxX);
    System.out.printf("Min Max Y: %f\t%f\n", minY, maxY);
    System.exit(0);
  }
}
