import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

void setup() {
  size(600, 400);
  blocks = new Block[3];
  blocks[0] = new Block(100, 100, "Defect");
  blocks[1] = new Block(100, 160, "Cooperate");
  blocks[2] = new Block(100, 220, "Repeat");
}
void draw() {
  background(220);
  for (Block b : blocks) {
    b.display();
  }
}
