
//============================================ her er void mouseReleased =============================================================================

void mouseReleased() {
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).checkMouseReleased();
  }

  tjekAlgoritmeKnapper(); //tjekker om der trykkes på algoritmeknapperne

  if (hitbox(width/1.6, height/1.4, width/5, height/5, 0)) {
    skaermState = 2;
  }


  if (hitbox(width/7, height/1.4, width/5, height/5, 0)) {
    skaermState = 3;
  }
  if (hitbox(0, 0, width/14, height/14, 1)) {
    skaermState = 0;
  }
  if (hitbox(0, 0, width/14, height/14, 2)) {
    skaermState = 0;
  }
  if (hitbox(0, 0, width/14, height/14, 3)) {
    skaermState = 0;
  }
  if (hitbox(0, 0, width/14, height/14, 4)) {
    skaermState = 0;
  }
  if (hitbox(0, 0, width/14, height/14, 5)) {
    skaermState = 4;
  }
  if (hitbox(width-width/14, 0, width/14, height/14, 4)) {
    skaermState = 5;
  }
   if (hitbox(width-width/14,0, width/14, height/14, 3)) {
    skaermState = 6;
  }
  if (hitbox(0, 0, width/14, height/14, 6)) {
    skaermState = 3;
  }

  draggerVenstreScrollBar = false; //hvis man giver slip på musen stopper man med at dragge
  draggerHoejreScrollBar = false;

}

void mousePressed() {

  if (skaermState == 3) { //hvis den er på algoritme kamp skærmen

    if (mouseX < width/100 && mouseY > venstreScrollY && mouseY < venstreScrollY + height/25) { //hvis musen er over venstre scroll bar

      draggerVenstreScrollBar = true; //går i gang med at dragge scroll baren
      venstreScrollBarOffset = mouseY - venstreScrollY; //sætter ofsættet af hvor man dragger fra
    } else if (mouseX > width - width/100 && mouseY > hoejreScrollY && mouseY < hoejreScrollY + height/25) {

      draggerHoejreScrollBar = true; //går i gang med at dragge scroll baren
      hoejreScrollBarOffset = mouseY - hoejreScrollY; //sætter ofsættet af hvor man dragger fra
    }
  }

  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).checkMousePressed();
  }
  println(mouseX);
}

void mouseDragged() {

  if (draggerVenstreScrollBar) {

    venstreScrollY = mouseY - venstreScrollBarOffset; //sætter scrollbarens position baseret på musen og det ofset den havde da man begyndte at dragge
    venstreScrollY = constrain(venstreScrollY, 0, height-height/25); //gør så den ikke kommer for langt
  } else if (draggerHoejreScrollBar) {

    hoejreScrollY = mouseY - hoejreScrollBarOffset;
    hoejreScrollY = constrain(hoejreScrollY, 0, height-height/25);
  }

  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).checkMouseDragged();
  }
}
