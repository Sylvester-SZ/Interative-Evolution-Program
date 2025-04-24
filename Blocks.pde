class Block {
  float x, y, w, h;
  String label;
  boolean dragging = false;
  boolean dragged;

  Block(float x, float y, String label, boolean dragged) {
    this.x = x;
    this.y = y;
    this.w = 120;
    this.h = 40;
    this.label = label;
    this.dragged = dragged;
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
      dragging = true;
    }
  }

  void checkMouseDragged() {
    if (!original) {
      if (dragging) {
        x = mouseX - w / 2;
        y = mouseY - h / 2;
      }
    } else{
      
    }
    }

    void checkMouseReleased() {
      dragging = false;
    }
}

Block[] blocks;
String[] codeLines;
