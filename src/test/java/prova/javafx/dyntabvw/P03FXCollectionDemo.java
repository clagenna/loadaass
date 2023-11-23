package prova.javafx.dyntabvw;

import java.util.ArrayList;
import java.util.List;

import javafx.collections.FXCollections;
import javafx.collections.ListChangeListener;
import javafx.collections.ObservableList;

public class P03FXCollectionDemo {

  public static void main(String[] args) {

    // Use Java Collections to create the List
    List<String> list = new ArrayList<String>();
    list.add("d");
    list.add("b");
    list.add("a");
    list.add("c");

    // Now add observability by wrapping it with ObservableList
    ObservableList<String> observableList = FXCollections.observableList(list);
    observableList.addListener(new ListChangeListener<String>() {

      @Override
      public void onChanged(Change<? extends String> p_change) {
        System.out.println("Detected a change:" + p_change);
        //        System.out.println("Was added? " + p_change.wasAdded());
        //        System.out.println("Was removed? " + p_change.wasRemoved());
        //        System.out.println("Was replaced? " + p_change.wasReplaced());
        //        System.out.println("Was permutated? " + p_change.wasPermutated());
      }
    });
    // Sort using FXCollections
    FXCollections.sort(observableList);
  }
}
