void mousePressed() {
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).checkMousePressed();
  }
}

void mouseDragged() {
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).checkMouseDragged();
  }
}

void mouseReleased() {
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).checkMouseReleased();
  }
}
