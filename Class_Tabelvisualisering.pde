

class TabelVisualisering {
  float xposTabel, yposTabel, sizexTabel, sizeyTabel; //variabler der bruges til at angive x og y pos af tabel og størrelsen i x og y af tabel
  float antalSildeben; //giver et random antal felter
  float antalRaekker=4, txtSize;
  float bredde1steRaekke;
  TabelVisualisering (float x, float y, float strx, float stry, int sildeben, int raekker,float bredRaek1, float txt) {

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
    
    stroke(70,70,70); //giver farve til linjerne i sildebenet
    fill(80,80,80); //giver farve til karaktererne i skemaet
    textAlign(CENTER, CENTER);
    strokeWeight(5);
    textSize(txtSize);
    
    int i = 0;
    while (i<antalSildeben+1) {
      float x = xposTabel + i*sizexTabel/antalSildeben;
      line(x+bredde1steRaekke, yposTabel, x+bredde1steRaekke, yposTabel+sizeyTabel);


      
      i=i+1;
    }
    
    int k = 0; 
    while (k<antalSildeben) { //dette while loop indskriver runde tallet i sildebensskemaet
      float x = xposTabel + k*sizexTabel/antalSildeben;
      text(k+1,x+bredde1steRaekke+((sizexTabel/antalSildeben)/2), yposTabel+(sizeyTabel/antalRaekker)/2);
 
      k=k+1;
    }
    
    
    int j=0;
    while (j<antalRaekker+1) {
      float y = yposTabel + j*sizeyTabel/antalRaekker;
      line(xposTabel+bredde1steRaekke, y, xposTabel+sizexTabel+bredde1steRaekke, y); //laver den linje der danne selve sildebenet
      
      line(xposTabel, yposTabel, xposTabel, yposTabel+sizeyTabel); //laver en linje til første række af felter
      line(xposTabel, y, xposTabel+bredde1steRaekke, y);//laver en linje til første række af felter
      text("Runde:",xposTabel+(bredde1steRaekke/2),yposTabel+(1*(sizeyTabel/antalRaekker)/2));//tekst til rows i tabel
      text("Spiller 1",xposTabel+(bredde1steRaekke/2),yposTabel+(3*(sizeyTabel/antalRaekker)/2));//tekst til rows i tabel
      text("Spiller 2",xposTabel+(bredde1steRaekke/2),yposTabel+(5*(sizeyTabel/antalRaekker)/2));//tekst til rows i tabel
      //text("Spiller 1 valg",xposTabel+(bredde1steRaekke/2),yposTabel+(7*(sizeyTabel/antalRaekker)/2));//tekst til rows i tabel
      //text("Spiller 2 valg",xposTabel+(bredde1steRaekke/2),yposTabel+(9*(sizeyTabel/antalRaekker)/2));//tekst til rows i tabel
      
      j=j+1;
    }

  }

  void indsaetDataTabel() {
   
    
    println(sildeben.getInt(0, "Spiller 1"));
    fill(0,0,0);
    
    text(sildeben.getInt(0, "Spiller 1"),550,550);
    
    int l=0;
    while (l<antalRaekker+1) { //her indtegnes værdierne fra tabellen
      //float y = yposTabel + l*sizeyTabel/antalRaekker;
      
      
    }
  }
}
