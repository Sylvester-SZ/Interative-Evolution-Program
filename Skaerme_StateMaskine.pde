
//Denne tab har alt indhold vedrørende hvad der vises på de forskellige skærme. De forskellige skærme kaldes med skaermState=(nr. på skærm) inde fra draw i tab "IEP"

int skaermState = 0;

void SplashScreen() {
  
  //================================================================tekst på hjemmeskærmen som forklarer programmet===================================
  textAlign(CENTER, CENTER);
  stroke(50);
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  fill(50);
  textSize(width/25);
  text("Samarbejde i Organismer", width/2, height/10); //overskrift teksten
  
  textSize(width/50);
  fill(50);
  text("Dette program skal forklare prisoners dilemma til den som gerne vil forstå det", width/2, height/5.5);
  text("Prisoners dilemma undersøger samarbejde mellem individer. Der sættes to spillere (algoritmer) op imod hinanden", width/2, height/4.4);
  text("Det gælder for individet om at få flest point. Spilleren har to muligheder i spillet. At samarbejde eller ikke", width/2, height/3.7);
  text("Hvis begge samarbejder får de 3 point hver. 1 point hvis de begge ikke samarbejder", width/2, height/3.17);
  text("Hvis den ene samarbejder og den anden ikke gør får den der samarbejder 0 point og den der ikke gør får 5", width/2, height/2.78);
  text("Den der ikke samarbejder stjæler fra den anden", width/2, height/2.45);
  text("Derfor er formålet med dette program egentligt at undersøge om man får flest point i livet ved at samarbejde", width/2, height/2);
  //============================= Knapper til hjemmeskærmen så man kan gå videre til andre elementer i programmet ==========================
  stroke(50);
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  fill(150);
  textSize(width/50);
  textAlign(CENTER,CENTER);
  rect(width/1.6, height/1.4, width/5, height/5);
  rect(width/7, height/1.4, width/5, height/5);
  fill(255);
  fill(50);
  text("Test Algorimter", width/1.6+width/5/2, height/1.4+height/5/2);
  text("Byg Egen Algoritme", width/7+width/5/2, height/1.4+height/5/2);
  fill(0);
//=====================================================================================================================================================

  // kan bruges, textWidth(); funktionen
}

void StartSkaerm() {
  //========================================================================================= knap der fører til hjemmeskærm================
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(150);
  textAlign(CENTER,CENTER);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(50);
  text("Hjemmeskaerm", width/14/2, height/14/2);
  fill(0);
  //==========================================================================================================================================
}




void AlgoritmeSkaerm() {
  tegnAlgoritmeKnapper();
  //=========================================================================================== knap der fører til hjemmeskærm=================
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(150);
  textAlign(CENTER,CENTER);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(50);
  text("Hjemmeskaerm", width/14/2, height/14/2);
  fill(0);
  
    tegnAlgoritmeKnapper();
  //===========================================================================================================================================
}



void BygSelvSkaerm() {
  background(220);
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(190);
  rect(0,0,width/10,height);
  textSize(width/100);
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).display();
  }
  //========================================================================================= knap der fører til hjemmeskærm ==================
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(150);
  textAlign(CENTER,CENTER);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(50);
  text("Hjemmeskaerm", width/14/2, height/14/2);
  fill(0);
  //==========================================================================================forklarende tekst til byg selv skærmen===============
  textSize(width/60); 
  fill(50);
  text("Tryk på en ønsket blok. Drag den ud på midten og tilføj andre blokke ved at sætte dem under (blokkene snapper fast)", width/1.84, height/1.05); //forklarende i byg selv
  //==========================================================================================overskrift til byg selv skærmen===============
    textSize(width/30);
    text("Velkommen til: Byg Din Egen Algoritme", width/1.84, height/15);
    //==========================================================================================Forklaring r og c===============
    
    textSize(width/80);
    text("!! r kører din algoritme!! ", width/1.84, height/6.7);
    text("!! c sletter alt på skærmen!! ", width/1.84, height/8.5);
  //================================================================================================================================================
   //========================================================================================= knap der fører til en skærm med gode råd ==========
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(150);
  textAlign(CENTER,CENTER);
  textSize(width/100);
  rect(width-width/14, 0, width/14, height/14);
  fill(50);
  text("Guide", width-width/14/2, height/14/2);
  fill(0);
}



void ResultatSkaerm() {
  nytabel.tabelVisuel();
  nytabel.indsaetDataTabel();
  //==========================================================================================overskrift til byg selv skærmen===============
    fill(50);
    textSize(width/35);
    text("Point Fordeling:", width/1.84, height/1.9);
  //========================================================================================= knap der fører til hjemmeskærm====================
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(150);
  textAlign(CENTER,CENTER);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(50);
  text("Hjemmeskaerm", width/14/2, height/14/2);
  fill(0);
  //========================================================================================= knap der fører til en skærm med gode råd ==========
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(150);
  textAlign(CENTER,CENTER);
  textSize(width/100);
  rect(width-width/14, 0, width/14, height/14);
  fill(50);
  text("Gode Råd", width-width/14/2, height/14/2);
  fill(0);
  
  //=========================================================================================== forklarende tekst i forhold til tabellen ========
  fill(50);
  textAlign(CENTER,CENTER);
  textSize(width/50);
  text("Der gives point i henhold til den forklaring der findes på hjemmeskærmen. Der kan forklaring på point ses.",width/2,height/1.65);
  text("Grøn farve betyder at algoritmen har samarbejdet. Rød farve betyder at den ikke har.",width/2,height/1.5);
  
  //===========================================================================================================================================
}



void GodeRaedSkaerm(){
  
  //======================================================================overskrift til gode råd ===============================================
  fill(50);
  textSize(width/30);
  text("Velkommen til: Råd til at forstå programmet", width/1.84, height/15);
  //=================================================================== forklarende tips på gode råd skærmen ===================================
  textSize(width/50); 
  fill(50);
  text("Hvis du som bruger undersøger nok algoritmer vil du indse at samarbejde er den smarteste strategi", width/2, height/5.5);
  text("Hvis du spiller egoistisk og aldrig samarbejder er der for stor chance for at to algoritmer altid", width/2, height/4.4);
  text("bare kommer til at låse sig fast i et loop hvor begge algoritmer får meget få point", width/2, height/3.7);
  text("Dette kan ses hvis sætter to (onde algoritmer) overfor hinanden. De vil for evigt i n runder få", width/2, height/3.17);
  text("mindste point begge to", width/2, height/2.78);
  text("prøv istedet at tage to søde algoritmer. De får nu begge 3 point i hver runde. Det er mere end 1", width/2, height/2.45);
  textSize(width/60);
  text("Så et lille hint til at designe egne algoritmer (hvis du kan udnytte samarbejde får alle flest mulige point)", width/2, height/2);
  
  //========================================================================================= knap der fører til tilbage ==================
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(150);
  textAlign(CENTER,CENTER);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(50);
  text("Tilbage", width/14/2, height/14/2);
  fill(0);
  //===========================================================================================================================================
}

void BygSelvForklaringSkaerm(){
  //================================================================================ knap der fører tilbage til byg selv skærm ============
  strokeWeight(5); //sætter tykkelsen på stregen rundt i rektanglen til 5 pixels
  stroke(50);
  fill(150);
  textAlign(CENTER,CENTER);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(50);
  text("Tilbage", width/14/2, height/14/2);
  fill(0);
  //===========================================================================================================================================
  
  //=================================================================== forklarende tips på og gode råd til byg selv ===========================
  fill(50);
  
  textSize(width/30);
  text("Byg Selv Guide",width/2,height/14);
  
  textSize(width/60); 
  text("Du skal her lave din egen algoritme som du bagefter kan teste mod andre præprogrammerede algoritmer.", width/2, height/5.5);
  text("Du er selvfølgelig en mester i det her, og du skal jo prøve at vinde. Måske du skulle teste andre algoritmer først? og få idéer", width/2, height/4.4);
  
  textSize(width/80); 
  text("For at lave din egen algoritme skal du bruge blokkodning. Spacer sættes under repeat. Antal gange sættes til højre for repeat samt handlingen til højre", width/2, height/3.7);
  textSize(width/50); 
  text("Øvelse: lav funktionen: if, opponent, defect, cooporate, else, defect", width/2, height/2.6);
  textSize(width/60); 
  text("Denne øvelse vil give en algoritme som ser på om modstandenren ikke samarbejder, og hvis ja, så samarbejder den selv.", width/2, height/2.3);
  text("Hvis modstanderen samarbejder, så samarbejder denne funktion ikke.", width/2, height/2.1);
  text("Du hiver bare blokkene over og sætter dem til højre for hinanden i den givne rækkefølge.", width/2, height/1.9);

  textSize(width/50); 
  text("Advarsel", width/2, height/1.5);
  textSize(width/80); 
  text("Du skal bare vide at nogle kombinationer af kode kan crashe programmet. Undgå udsagn hvor algoritmen står uden en klar definition på hvad den skal gøre i et tilfælde", width/2, height/1.4);
}
