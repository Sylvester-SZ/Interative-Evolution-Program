

//====================================== classen som danner tabellen der displayes på skærmen ===================================================


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
  
  
  
//==================================================================================viser tabellens felter på skærmen==================================================================================================
  
  
  void tabelVisuel() { //viser tabellens felter på skærmen

    stroke(70); //giver farve til linjerne i sildebenet
    fill(80); //giver farve til karaktererne i skemaet
    textAlign(CENTER, CENTER);
    strokeWeight(5);
    textSize(txtSize);
    
    antalSildeben=antalRunder;

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


//===================================================indsætter data fra table (skemaet) der hedder resultater===========================================================================


  void indsaetDataTabel() { //indsætter data fra table (skemaet) der hedder resultater

    ////print(resultater.getInt(0, "Spiller 1"));
    fill(0);

int s = 0;
while (s<antalSildeben){
    
    textAlign(CENTER, CENTER);
    float x = xposTabel + s*(sizexTabel-bredde1steRaekke)/antalSildeben;
    
     fill(80, 80, 80); //giver farve til karaktererne i skemaet
     
     if((resultater.getInt(s, "Spiller 1")==3 || (resultater.getInt(s, "Spiller 1")==0))){
       fill(100,255,100);
       text(resultater.getInt(s, "Spiller 1"),x+bredde1steRaekke+sizexTabel/antalSildeben/2, yposTabel+(3*(sizeyTabel/antalRaekker)/2));  
     } else{
       fill(255,0,0);
       text(resultater.getInt(s, "Spiller 1"),x+bredde1steRaekke+sizexTabel/antalSildeben/2, yposTabel+(3*(sizeyTabel/antalRaekker)/2));
     }
     if((resultater.getInt(s, "Spiller 2")==3 || (resultater.getInt(s, "Spiller 2")==0))){
       fill(0,255,0);
     text(resultater.getInt(s, "Spiller 2"),x+bredde1steRaekke+sizexTabel/antalSildeben/2, yposTabel+(5*(sizeyTabel/antalRaekker)/2));
      s=s+1;
     } else{
       fill(255,0,0);
     text(resultater.getInt(s, "Spiller 2"),x+bredde1steRaekke+sizexTabel/antalSildeben/2, yposTabel+(5*(sizeyTabel/antalRaekker)/2));
        s=s+1;
     }
}

    for (int i = 0; i < antalRaekker + 1; i++) { //her indtegnes værdierne fra tabellen
      //float y = yposTabel + l*sizeyTabel/antalRaekker;
    }
  }
}
