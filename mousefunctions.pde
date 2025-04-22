void mousePressed() {
  for (Block b : blocks) {
    b.checkMousePressed();
  }
}

void mouseDragged() {
  for (Block b : blocks) {
    b.checkMouseDragged();
  }
}

void mouseReleased() {
  for (Block b : blocks) {
    b.checkMouseReleased();
  }
}
