

class TabelVisualisering {
  int xposTabel, yposTabel, sizexTabel, sizeyTabel; //variabler der bruges til at angive x og y pos af tabel og størrelsen i x og y af tabel
  int antalSildeben; //giver et random antal felter
  int antalRaekker=4, txtSize;
  int bredde1steRaekke;
  TabelVisualisering (int x, int y, int strx, int stry, int sildeben, int raekker, int bredRaek1, int txt) {

    xposTabel=x;
    yposTabel=y;
    sizexTabel=strx;
    sizeyTabel=stry;
    antalSildeben=sildeben;
    antalRaekker=raekker;
    txtSize= txt;
    bredde1steRaekke=bredRaek1;
  }
  void tabelVisuel() {

    stroke(70, 70, 70); //giver farve til linjerne i sildebenet
    fill(80, 80, 80); //giver farve til karaktererne i skemaet
    textAlign(CENTER, CENTER);
    strokeWeight(5);
    textSize(txtSize);

    for (int i = 0; i < antalSildeben + 1; i++) {

      float x = xposTabel + i*(sizexTabel-bredde1steRaekke)/antalSildeben;
      line(x+bredde1steRaekke, yposTabel, x+bredde1steRaekke, yposTabel+sizeyTabel);
    }

    for (int i = 0; i < antalSildeben; i++) { //dette while for indskriver runde tallet i sildebensskemaet
      float x = xposTabel + i*(sizexTabel-bredde1steRaekke)/antalSildeben;
      text(i+1, x+bredde1steRaekke+(((sizexTabel-bredde1steRaekke)/antalSildeben)/2), yposTabel+(sizeyTabel/antalRaekker)/2);
    }



    for (int i = 0; i < antalRaekker + 1; i++) {
      float y = yposTabel + i*sizeyTabel/antalRaekker;
      line(xposTabel, y, xposTabel+sizexTabel, y); //laver den linje der danne selve sildebenet

      line(xposTabel, yposTabel, xposTabel, yposTabel+sizeyTabel); //laver en linje til første række af felter
      text("Runde:", xposTabel+(bredde1steRaekke/2), yposTabel+(1*(sizeyTabel/antalRaekker)/2));//tekst til rows i tabel
      text("Spiller 1", xposTabel+(bredde1steRaekke/2), yposTabel+(3*(sizeyTabel/antalRaekker)/2));//tekst til rows i tabel
      text("Spiller 2", xposTabel+(bredde1steRaekke/2), yposTabel+(5*(sizeyTabel/antalRaekker)/2));//tekst til rows i tabel
    }
  }

  void indsaetDataTabel() {

    println(sildeben.getInt(0, "Spiller 1"));
    fill(0, 0, 0);

    text(sildeben.getInt(0, "Spiller 1"), 550, 550);

    for (int i = 0; i < antalRaekker + 1; i++) { //her indtegnes værdierne fra tabellen
      //float y = yposTabel + l*sizeyTabel/antalRaekker;
    }
  }
}
