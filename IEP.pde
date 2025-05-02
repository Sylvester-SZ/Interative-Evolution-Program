import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

Algoritmer[] algoritmer = new Algoritmer[4]; //laver et array til algoritmerne
TabelVisualisering nytabel;

ArrayList<Block> blocks = new ArrayList<Block>();

Algoritmer[] algoritmer = new Algoritmer[9]; //laver et array til algoritmerne
TabelVisualisering nytabel;

int antalRunder; //antallet af runder algortimerne spiller mod hinanden

boolean draggerVenstreScrollBar = false;
boolean draggerHoejreScrollBar = false;

//============================================ her er void setup =============================================================================

void setup() {
  //Alle vores actionblokke
  int blocksoffset = height/17;
  int ekstraoffset = height/40;
  blocks.add(new Block(50, height/14*1.3, "Cooperate", true, 1));
  blocks.add(new Block(50, height/14*1.3+blocksoffset, "Defect", true, 1));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*2, "Repeat", true, 1));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*3, "If", true, 1));

  // Talblokkene vi bruger til vores repeat og vores if
  blocks.add(new Block(50, height/14*1.3+blocksoffset*4+ekstraoffset*1, "0x", true, 2));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*5+ekstraoffset*1, "1x", true, 2));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*6+ekstraoffset*1, "5x", true, 2));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*7+ekstraoffset*1, "10x", true, 2));

  //Logik/Sammenligningsblokke vi bruger til if
  blocks.add(new Block(50, height/14*1.3+blocksoffset*8+ekstraoffset*2, "==", true, 3));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*9+ekstraoffset*2, ">", true, 3));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*10+ekstraoffset*2, "<", true, 3));

  //Variabler fra tidligere spil
  blocks.add(new Block(50, height/14*1.3+blocksoffset*11+ekstraoffset*3, "opponent", true, 4));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*12+ekstraoffset*3, "player", true, 4));
  blocks.add(new Block(50, height/14*1.3+blocksoffset*13+ekstraoffset*4, "Spacer", true, 1));


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

  koerTabel(); //kører tabellen

  nytabel = new TabelVisualisering (width/6, height/8, width-width/6*2, height/5, floor(random(10, 16)), 3, 250, 40);

  fullScreen();
}


//============================================ her er void draw =============================================================================

void draw() { //mouse released interrupter draw funktionen så uden den fungere mouse released ikke

  background(190);

  //følgende er visuelt til debugging, skal bygges ind i en state machine senere
  nytabel.tabelVisuel();
  tegnAlgoritmeKnapper();

  switch(skaermState) {
  case 0:
    SplashScreen();
    break;
  case 1:
    StartSkaerm();
    break;
  case 2:
    AlgoritmeSkaerm();
    break;
  case 3:
    BygSelvSkaerm();
    break;
  case 4:
    ResultatSkaerm();
    break;
  case 5:
    GodeRaedSkaerm();
    break;
  }
}
