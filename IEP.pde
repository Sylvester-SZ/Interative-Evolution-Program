import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

ArrayList<Block> blocks = new ArrayList<Block>();

void setup() {
  fullScreen();
  //Alle vores actionblokke
  blocks.add(new Block(50, 50, "Cooperate", true, 1));
  blocks.add(new Block(50, 700, "Spacer", true, 1));
  blocks.add(new Block(50, 100, "Defect", true, 1));
  blocks.add(new Block(50, 150, "Repeat", true, 1));
  blocks.add(new Block(50, 200, "If", true, 1)); 
  
  // Talblokkene vi bruger til vores repeat og vores if
  blocks.add(new Block(50, 260, "0x", true, 2));
  blocks.add(new Block(50, 310, "1x", true, 2));
  blocks.add(new Block(50, 360, "5x", true, 2));
  blocks.add(new Block(50, 310, "10x", true, 2));
  
  //Logik/Sammenligningsblokke vi bruger til if
  blocks.add(new Block(50, 420, "==", true, 3));
  blocks.add(new Block(50, 470, ">", true, 3));
  blocks.add(new Block(50, 520, "<", true, 3));
  
  //Variabler fra tidligere spil
  blocks.add(new Block(50, 580, "opponent", true, 4));
  blocks.add(new Block(50, 630, "player", true, 4));
}

void draw() {
  background(220);
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).display();
  }
}
