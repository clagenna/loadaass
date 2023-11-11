package prova.javafx;

import java.util.ArrayList;
import java.util.List;

class P04LoremIpsumGenerator {
  private static final String[] LOREM   = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc tempus cursus diam ac blandit. Ut ultrices lacus et mattis laoreet. Morbi vehicula tincidunt eros lobortis varius. Nam quis tortor commodo, vehicula ante vitae, sagittis enim. Vivamus mollis placerat leo non pellentesque. Nam blandit, odio quis facilisis posuere, mauris elit tincidunt ante, ut eleifend augue neque dictum diam. Curabitur sed lacus eget dolor laoreet cursus ut cursus elit. Phasellus quis interdum lorem, eget efficitur enim. Curabitur commodo, est ut scelerisque aliquet, urna velit tincidunt massa, tristique varius mi neque et velit. In condimentum quis nisi et ultricies. Nunc posuere felis a velit dictum suscipit ac non nisl. Pellentesque eleifend, purus vel consequat facilisis, sapien lacus rutrum eros, quis finibus lacus magna eget est. Nullam eros nisl, sodales et luctus at, lobortis at sem."
      .split(" ");

  private int                   curWord = 0;

  List<String> getNext(int nWords) {
    List<String> words = new ArrayList<>();

    for (int i = 0; i < nWords; i++) {
      if (curWord == Integer.MAX_VALUE) {
        curWord = 0;
      }

      words.add(LOREM[curWord % LOREM.length]);
      curWord++;
    }

    return words;
  }
}