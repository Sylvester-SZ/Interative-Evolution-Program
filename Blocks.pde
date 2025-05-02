class Block {
  float x, y, w, h;
  String label;
  boolean dragging = false;
  boolean picker;
  int catagory;
  Block parent;
  ArrayList<Block> connectedBlocks;

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
      parent = null;
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
        } else if (mouseX > xb+wb && mouseX < xb + 2*wb && mouseY > yb && mouseY < yb + hb && blocks.get(i).picker==false) {
          x = blocks.get(i).x+blocks.get(i).w;
          y= blocks.get(i).y;
          parent = blocks.get(i);
        }
      }
    }
  }
  
  ArrayList<Block> getChildBlocks() {
    ArrayList<Block> children = new ArrayList<Block>();

    // First add direct children (blocks that have this as parent)
    for (Block block : blocks) {
      if (!block.picker && block.parent == this) {
        children.add(block);
      }
    }

    // Then find blocks that are vertically connected (directly below)
    for (Block block : blocks) {
      if (!block.picker && block.parent == null && block != this) {
        // Check if block is directly below this block (snapped to bottom)
        if (abs(block.x - this.x) < 5 && abs(block.y - (this.y + this.h)) < 10) {
          children.add(block);

          // Recursively add children of this vertical child
          ArrayList<Block> subChildren = block.getChildBlocks();
          for (Block subChild : subChildren) {
            if (!children.contains(subChild)) {
              children.add(subChild);
            }
          }
        }
      }
    }

    return children;
  }
  
  //Fundet i tidligere projekt
   int getNumericValue() {
    int defaultValue = 5;
    
    try {
      if (label.contains("x")) {
        String[] parts = label.split("x");
        if (parts.length > 0) {
          return Integer.parseInt(parts[0].trim());
        }
      } else if (label.matches(".*\\d+.*")) {
        // Extract numbers from the label
        String numStr = label.replaceAll("[^0-9]", "");
        if (!numStr.isEmpty()) {
          return Integer.parseInt(numStr);
        }
      }
    } catch (Exception e) {
    }
    
    return defaultValue;
  }
}

String[] codeLines;


boolean isBlockDirectlyBelow(Block upper, Block lower) {
  // Check if lower block's top edge is near upper block's bottom edge
  return abs(lower.y - (upper.y + upper.h)) < 5 &&
    abs(lower.x - upper.x) < 5;
}
