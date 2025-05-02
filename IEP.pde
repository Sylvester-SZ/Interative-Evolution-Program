import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

ArrayList<Block> blocks = new ArrayList<Block>();

void setup() {
  fullScreen();

  blocks.add(new Block(25, 200, "If", true, 3));  // If control block
  blocks.add(new Block(25, 400, "==", true, 4));  // Equality operator
  blocks.add(new Block(25, 450, ">", true, 4));   // Greater than
  blocks.add(new Block(25, 500, "<", true, 4));
  blocks.add(new Block(100, 400, "Defect", true, 1));
  blocks.add(new Block(100, 460, "Cooperate", true, 1));
  blocks.add(new Block(100, 520, "Repeat", true, 3));
  blocks.add(new Block(100, 580, "1x", true, 2));
  blocks.add(new Block(100, 640, "3x", true, 2));
  blocks.add(new Block(100, 700, "5x", true, 2));
  blocks.add(new Block(100, 760, "10x", true, 2));
}

void draw() {
  background(220);
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).display();
  }
}
