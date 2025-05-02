
int skaermState = 0;

void SplashScreen() {
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(width/30);
  text("Samarbejde i Organismer", width/2, height/10);
  textSize(width/50);
  text("Dette program skal forklare prisoners dilemma", width/2, height/5.5);
  textSize(width/50);
  text("Prisoners dilemma", width/2, height/4.55);
  textSize(width/50);
  text("hej verden", width/2, height/3.9);
  textSize(width/50);
  textAlign(LEFT, TOP);
  rect(width/1.6, height/1.4, width/5, height/5);
  rect(width/7, height/1.4, width/5, height/5);
  fill(255);
  text("Test Algorimter", width/1.6, height/1.4);
  text("Byg Egen Algoritme", width/7, height/1.4);
  fill(0);


  // kan bruges, textWidth(); funktionen
}

void StartSkaerm() {
  fill(0);
  textAlign(LEFT, TOP);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(255);
  text("Hjemmeskaerm", 0, 0);
  fill(0);
}

void AlgoritmeSkaerm() {
  tegnAlgoritmeKnapper();
  fill(0);
  textAlign(LEFT, TOP);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(255);
  text("Hjemmeskaerm", 0, 0);
  fill(0);
}

void BygSelvSkaerm() {
  background(220);
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).display();
  }
  fill(0);
  textAlign(LEFT, TOP);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(255);
  text("Hjemmeskaerm", 0, 0);
  fill(0);
}

void ResultatSkaerm() {
  nytabel.tabelVisuel();
  nytabel.indsaetDataTabel();
  fill(0);
  textAlign(LEFT, TOP);
  textSize(width/100);
  rect(0, 0, width/14, height/14);
  fill(255);
  text("Hjemmeskaerm", 0, 0);
  fill(0);
}
