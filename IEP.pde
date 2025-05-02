import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

ArrayList<Block> blocks = new ArrayList<Block>();

void setup() {
  fullScreen();

  blocks.add(new Block(100, 400, "Defect", true, 1));
  blocks.add(new Block(100, 460, "Cooperate", true, 1));
  blocks.add(new Block(100, 520, "Repeat", true, 1));
}

void draw() {
  background(220);
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).display();
  }
}
