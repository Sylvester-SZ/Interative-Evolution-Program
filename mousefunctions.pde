void mousePressed() {
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).checkMousePressed();
  }
  println(mouseX);
}

void mouseDragged() {
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).checkMouseDragged();
  }
}
