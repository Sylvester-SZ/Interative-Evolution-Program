int valgtAlgoritme1; //den første algoritme valgt af brugeren
int valgtAlgoritme2; //den anden algoritme valgt af brugeren
int algoritmeKampSkaerm = 2;

void tjekAlgoritmeKnapper() {

  for (int i = 0; i < algoritmer.length; i++) { //for hver algoritme

    if (hitbox(width/20, height/10 * (i+1) + 30 * i, width/10, height/10, algoritmeKampSkaerm)) { // hvis der trykkes på en af knapperne til vemstre

      valgtAlgoritme1 = i; //sæt den valgte algoritme 1 til den valgte
    } else if (hitbox(width - (width/20 + width/10), height/10 * (i+1) + 30 * i, width/10, height/10, algoritmeKampSkaerm)) { //hvis der trykkes på en af knapperne til højre

      valgtAlgoritme2 = i; //sæt den valgte algoritme 2 til den valgte
    }
  }

  println(valgtAlgoritme1 + " " + valgtAlgoritme2);
  
  //tjek testknappen
  if (hitbox(width/2 - width/5/2, height/60, width/5, height/10, algoritmeKampSkaerm)){
    
skaermState = 4; //sæt den til skærmen der viser resultater, som er 1  nu men nok ikke skal være det

algoritme_kamp(valgtAlgoritme1, valgtAlgoritme2);
saveTable(resultater, "data/resultater.HTML"); //tjek resultaterne uden at skulle lave visuelt til skærm så det er nemmere at debugge
    
  }
  
}

void tegnAlgoritmeKnapper() {

  // =================================== sætter nogle visuelle ting ===================================================================================================================
  stroke(70);
  fill(80);
  textAlign(CENTER, CENTER);
  strokeWeight(5);

  for (int i = 0; i < algoritmer.length; i++) {
    
    // ======================================================= nedenstående tegner knapperne i venstre side på skærmen AlgoritmeSkaerm(); som har nr. 2 ====================================
    if (valgtAlgoritme1 == i) { //hvis dette er den valgte algortime

      fill(100, 255, 100); //sæt farven til grøn
    } else {

      fill(150); //ellers sæt farven til grå
    }
    rect(width/20, height/10 * (i+1) + height/30 * i, width/10, height/10, 10); //tegn knappen


    // ======================================================================= tegn teksten til algoritme knapperne ===========================================================================
    fill(50);
    textSize(height/60);
    text(algoritmer[i].navn, width/20 + width/80, height/10 * (i + 1) + height/30 * i + height/40, width/10 - 2 * width/80, height/10 - 2 * height/40);

    //nedenstående tegner knapperne i højre side
    if (valgtAlgoritme2 == i) { //hvis dette er den valgte algortime

      fill(100, 255, 100); //sæt farven til grøn
    } else {

      fill(150); //ellers sæt farven til grå
    }
    rect(width - width/20, height/10 * (i+1) + height/30 * i, -width/10, height/10, 10); //tegn knappen

    //tegn teksten til algoritme knapperne
    fill(50);
    text(algoritmer[i].navn, width - (width/20 + width/80), height/10 * (i + 1) + height/30 * i + height/40, -(width/10 - 2 * width/80), height/10 - 2 * height/40);
  }
  
  //tegner test knappen
  fill(170, 210, 240); 
      rect(width/2 - width/5/2, height/60, width/5, height/10, 10);
      textSize(height/30);
      fill(78);
      text("Test algoritmerne", width/2 - width/5/2, height/60, width/5, height/10);
  
}
