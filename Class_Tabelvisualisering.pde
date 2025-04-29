

class TabelVisualisering {
  int xposTabel, yposTabel, sizexTabel, sizeyTabel; //variabler der bruges til at angive x og y pos af tabel og størrelsen i x og y af tabel
  int antalSildeben; //giver et random antal felter
  int antalRaekker=4;
  TabelVisualisering (int x, int y, int strx, int stry, int sildeben, int raekker) {

    xposTabel=x;
    yposTabel=y;
    sizexTabel=strx;
    sizeyTabel=stry;
    antalSildeben=sildeben;
    antalRaekker=raekker;
  }
  void tabelVisuel() {
    strokeWeight(1);
    int i = 0;
    int bredde1steRaekke=200;
    while (i<antalSildeben+1) {
      float x = xposTabel + i*sizexTabel/antalSildeben;
      line(x+bredde1steRaekke, yposTabel, x+bredde1steRaekke, yposTabel+sizeyTabel);
      
      i=i+1;
    }
    
    int j=0;
    while (j<antalRaekker+1) {
      float y = yposTabel + j*sizeyTabel/antalRaekker;
      line(xposTabel+bredde1steRaekke, y, xposTabel+sizexTabel+bredde1steRaekke, y);
      line(xposTabel, yposTabel, xposTabel, yposTabel+sizeyTabel); //laver en linje til første række af felter
      line(xposTabel, y, xposTabel+bredde1steRaekke, y);//laver en linje til første række af felter
      text("Spiller 1",xposTabel,yposTabel);//tekst til rows i tabel
      text("Spiller 2",xposTabel,yposTabel);//tekst til rows i tabel
      j=j+1;
    }

    println(antalSildeben);
  }

  void indsaetDataTabel() {
    
    println(sildeben.getInt(0, "Spiller 1"));
    fill(0,0,0);
    textSize(sizeyTabel/10);
    text(sildeben.getInt(0, "Spiller 1"),550,550);
    
  }
}
