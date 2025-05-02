import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

ArrayList<Block> blocks = new ArrayList<Block>();

void setup() {
  fullScreen();

  blocks.add(new Block(50, 50, "Cooperate", true, 1));
  blocks.add(new Block(50, 550, "Spacer", true, 1));
  blocks.add(new Block(50, 100, "Defect", true, 1));
  blocks.add(new Block(50, 150, "Repeat", true, 1));
  blocks.add(new Block(50, 200, "If", true, 1)); 
  

  blocks.add(new Block(50, 250, "5x", true, 2));
  blocks.add(new Block(50, 300, "10x", true, 2));
  blocks.add(new Block(50, 350, "20x", true, 2));
  
  blocks.add(new Block(50, 400, "==", true, 3));
  blocks.add(new Block(50, 450, ">", true, 3));
  blocks.add(new Block(50, 500, "<", true, 3));
}

void draw() {
  background(220);
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).display();
  }
}
