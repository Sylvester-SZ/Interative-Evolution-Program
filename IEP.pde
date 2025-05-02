Algoritmer[] algoritmer = new Algoritmer[9]; //laver et array til algoritmerne
TabelVisualisering nytabel;

int antalRunder; //antallet af runder algortimerne spiller mod hinanden

boolean draggerVenstreScrollBar = false;
boolean draggerHoejreScrollBar = false;

void setup() {

  antalRunder = floor(random(10, 16));

  //sæt algoritmerne i et array så de er nemme at tilgå
  algoritmer[0] = soedAlgoritme;
  algoritmer[1] = ondAlgoritme;
  algoritmer[2] = random;
  algoritmer[3] = copycat;
  algoritmer[4] = haevnfuld;
  algoritmer[5] = pavlov;
  algoritmer[6] = vægtetTilfældig;
  algoritmer[7] = gennemsnit;
  algoritmer[8] = detektiv;

  //lav tabel med resultater
  resultater.addColumn("Spiller 1");
  resultater.addColumn("Spiller 2");
  resultater.addColumn("Spiller 1 Valg");
  resultater.addColumn("Spiller 2 Valg");

  for (int i = 0; i < 15; i++) {

    resultater.addRow(); //tilføjer alle rækkerne til vores resultat table
  }

  //saveTable(resultater, "data/resultater.HTML"); //tjek resultaterne uden at skulle lave visuelt til skærm så det er nemmere at debugge

  koerTabel(); //kører tabellen

  nytabel = new TabelVisualisering (width/6, height/8, width-width/6*2, height/5, antalRunder, 3, 250, 40);
  //TabelVisualisering nytabel= new TabelVisualisering (500,500, 500, 250, floor(random(10,16)), 5,125,20);

  //nytabel.indsaetDataTabel();



  fullScreen();
}

void draw() { //mouse released interrupter draw funktionen så uden den fungere mouse released ikke

  background(200);

  //følgende er visuelt til debugging, skal bygges ind i en state machine senere
  nytabel.tabelVisuel();
  tegnAlgoritmeKnapper();
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
}

void mouseDragged() {

  if (draggerVenstreScrollBar) {

    venstreScrollY = mouseY - venstreScrollBarOffset; //sætter scrollbarens position baseret på musen og det ofset den havde da man begyndte at dragge
    venstreScrollY = constrain(venstreScrollY, 0, height-height/25); //gør så den ikke kommer for langt
  } else if (draggerHoejreScrollBar) {

    hoejreScrollY = mouseY - hoejreScrollBarOffset;
    hoejreScrollY = constrain(hoejreScrollY, 0, height-height/25);
  }
}

void mouseReleased() {

  draggerVenstreScrollBar = false; //hvis man giver slip på musen stopper man med at dragge
  draggerHoejreScrollBar = false;

  tjekAlgoritmeKnapper(); //tjekker om der trykkes på algoritmeknapperne
}
