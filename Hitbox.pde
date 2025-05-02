// FØLGENDE KODE ER TYVSTJÅLET FRA ET TIDLIGERE PROJEKT

boolean hitbox(float x0, float y0, float x1, float  y1, int reqskaerm) {
  float tolerance = 6;
  x0 = x0- tolerance;
  y0 = y0- tolerance;
  x1 = x1+x0+tolerance;
  y1 = y1+y0+tolerance;
  if ((mouseX>x0)&&(mouseX<x1)&&mouseY>y0&&mouseY<y1&&(reqskaerm==skaermState)) {
    return true;
  } else {
    return false;
  }
}

// herfra er koden ikke længere taget fra et tidligere projekt
