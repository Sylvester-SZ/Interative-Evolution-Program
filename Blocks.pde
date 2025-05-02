class Block {
  float x, y, w, h;
  String label;
  boolean dragging = false;
  boolean picker;
  int catagory;
  Block parent;
  ArrayList<Block> connectedBlocks = new ArrayList<Block>();

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
  //Bruges til at tilføje nye blokke ud fra vores "picker" i venstre side og til at starte dragging
  void checkMousePressed() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      if (!picker) {
        dragging = true;
      } else {
        blocks.add(new Block(x+150, y, label, false, 1));
      }
    }
  }
  // Dragger blokken med musen - resetter "parent" variblen som bruges i blok-kode logikken
  void checkMouseDragged() {
    if (dragging) {
      x = mouseX - w / 2;
      y = mouseY - h / 2;
      parent = null;
    }
  }
  //Indeholder flere funktioner. Ved insættelse af blok lige under en anden blok, snapper den på plads og den nye blok sættes som "parent".
  //Ved indsættelse ved siden af en anden blok snapper den på plads og den indsættes i Arraylisten "connectedBlocks" som ogs å bruges i blokkode logik.
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

          if (!blocks.get(i).connectedBlocks.contains(this)) {
            blocks.get(i).connectedBlocks.add(this);
          }
        }
      }
    }
  }
  // Denne funktion finder alle "ChildBlocks", altså alle de blokke der har en parent, finder den barnet til (Rekursiv funktion)
  ArrayList<Block> getChildBlocks() {
    ArrayList<Block> children = new ArrayList<Block>();
    //sidelens
    for (Block block : blocks) {
      if (!block.picker && block.parent == this) {
        children.add(block);
      }
    }
    // Under
    for (Block block : blocks) {
      if (!block.picker && block != this) {
        if (abs(block.x - this.x) < 5 && abs(block.y - (this.y + this.h)) < 10) {
          children.add(block);


          ArrayList<Block> subChildren = block.getChildBlocks();
          for (Block subChild : subChildren) {
            if (!children.contains(subChild)) {
              children.add(subChild);
            }
          }
        }
      }
    }

    for (Block connected : connectedBlocks) {
      if (!children.contains(connected)) {
        children.add(connected);
      }
    }

    return children;
  }



  //Fundet i tidligere projekt. Laver en string der indeholder x (0x, 1x) om til et tal.
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
    }
    catch (Exception e) {
    }

    return defaultValue;
  }
  
  //Hjælpefunktion der returnere om en label er en af vores 2 varibler. Gør koden mere overskuelig
  boolean isVariable() {
    return label.equals("opponent") || label.equals("player");
  }
  //Endnu en hjælpefunktion som returnere hvilken varible det er.
  String getVariableName() {
    if (isVariable()) {
      return label + "Choice";
    }
    return "unknown";
  }
}

String[] codeLines;

//Funktion forslået af AI. Den gør detection af blokke mere præcis når man kigger igennem alle de connected blocks
boolean isBlockDirectlyBelow(Block upper, Block lower) {
  return abs(lower.y - (upper.y + upper.h)) < 5 &&
    abs(lower.x - upper.x) < 5;
}
