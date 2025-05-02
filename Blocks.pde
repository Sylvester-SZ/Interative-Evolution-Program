

class Block {
  float x, y, w, h;
  String label;
  boolean dragging = false;
  boolean picker;
  int catagory;
  Block parent;

  Block(float x, float y, String label, boolean picker, int catagory) {
    this.x = x;
    this.y = y;
    this.w = 120;
    this.h = 40;
    this.label = label;
    this.picker = picker;
    this.catagory = catagory;
  }

  void display() {
    fill(dragging ? color(200, 200, 255) : color(150, 150, 250));
    rect(x, y, w, h, 5);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }

  void checkMousePressed() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      if (!picker) {
        dragging = true;
      } else {
        blocks.add(new Block(x+150, y, label, false, 1));
      }
    }
  }

  void checkMouseDragged() {
    if (dragging) {
      x = mouseX - w / 2;
      y = mouseY - h / 2;
    }
  }

  void checkMouseReleased() {
    dragging = false;
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      for (int i = 0; i < blocks.size(); i++) {
        float xb = blocks.get(i).x;
        float yb = blocks.get(i).y;
        float wb = blocks.get(i).w;
        float hb = blocks.get(i).h;
        if (mouseX > xb && mouseX < xb + wb && mouseY > yb+hb && mouseY < yb + hb *2 && blocks.get(i).picker==false) {
          //println("andet tjek " + i);
          x = blocks.get(i).x;
          y= blocks.get(i).y+blocks.get(i).h;
        }
        else if(mouseX > xb+wb && mouseX < xb + 2*wb && mouseY > yb && mouseY < yb + hb && blocks.get(i).picker==false){
          x = blocks.get(i).x+blocks.get(i).w;
          y= blocks.get(i).y;
          parent = blocks.get(i);
        }
      }
    
    }
  }
  ArrayList<Block> getChildBlocks() {
    ArrayList<Block> children = new ArrayList<Block>();
    for (Block block : blocks) {
      if (block.parent == this) {
        children.add(block);
      }
    }
    return children;
  }
}

String[] codeLines;
