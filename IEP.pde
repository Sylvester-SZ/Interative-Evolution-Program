Algoritmer[] algoritmer = new Algoritmer[4]; //laver et array til algoritmerne
 TabelVisualisering nytabel;

void setup() {

  //sæt algoritmerne i et array så de er nemme at tilgå
  algoritmer[0] = soedAlgoritme;
  algoritmer[1] = ondAlgoritme;
  algoritmer[2] = random;
  algoritmer[3] = copycat;

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
  
 nytabel = new TabelVisualisering (width/6, height/8, width-width/6*2, height/5, floor(random(10,16)), 3,250,40);
 //TabelVisualisering nytabel= new TabelVisualisering (500,500, 500, 250, floor(random(10,16)), 5,125,20);
 
 //nytabel.indsaetDataTabel();
 

 
 fullScreen();
 
}

void draw(){ //mouse released interrupter draw funktionen så uden den fungere mouse released ikke

//følgende er visuelt til debugging, skal bygges ind i en state machine senere
  nytabel.tabelVisuel();
  tegnAlgoritmeKnapper();
  
}

void mouseReleased(){
  
 tjekAlgoritmeKnapper(); //tjekker om der trykkes på algoritmeknapperne
  
}
