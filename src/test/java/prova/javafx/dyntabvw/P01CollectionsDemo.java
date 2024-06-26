package prova.javafx.dyntabvw;

import java.util.ArrayList;
import java.util.List;

import javafx.collections.FXCollections;
import javafx.collections.ListChangeListener;
import javafx.collections.ObservableList;

public class P01CollectionsDemo {

  public static void main(String[] args) {

    // Use Java Collections to create the List.
    List<String> list = new ArrayList<String>();

    // Now add observability by wrapping it with ObservableList.
    ObservableList<String> observableList = FXCollections.observableList(list);
    observableList.addListener(new ListChangeListener<String>() {
      @Override
      public void onChanged(Change<? extends String> p_c) {
        System.out.println("Qualcosa e' cambiato:" + p_c);

      }
    });

    // Changes to the observableList WILL be reported.
    // This line will print out "Detected a change!"
    observableList.add("item one");

    // Changes to the underlying list will NOT be reported
    // Nothing will be printed as a result of the next line.
    list.add("item two");

    System.out.println("Size: " + observableList.size());

  }
}
