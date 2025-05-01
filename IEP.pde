Algoritmer[] algoritmer = new Algoritmer[4]; //laver et array til algoritmerne

void setup() {

  //sæt algoritmerne i et array så de er nemme at tilgå
  algoritmer[0] = soedAlgoritme;
  algoritmer[1] = dumAlgoritme;
  algoritmer[2] = random;
  algoritmer[3] = copycat;

  //lav tabel med resultater
  resultater.addColumn("Spiller1");
  resultater.addColumn("Spiller2");
  resultater.addColumn("Spiller1Valg");
  resultater.addColumn("Spiller2Valg");

  for (int i = 0; i < 15; i++) {

    resultater.addRow(); //tilføjer alle rækkerne til vores resultat table
  }

  println("kolonner: " + resultater.getColumnCount() + ", rækker: " + resultater.getRowCount()); //debugging

  algoritme_kamp(2, 3); //eksempel kamp mellem random og copycat

  saveTable(resultater, "data/resultater.HTML"); //tjek resultaterne uden at skulle lave visuelt til skærm så det er nemmere at debugge

 koerTabel(); //kører tabellen
  
 TabelVisualisering nytabel= new TabelVisualisering (500,500, 1000, 500, floor(random(10,16)), 3,250,40);
 //TabelVisualisering nytabel= new TabelVisualisering (500,500, 500, 250, floor(random(10,16)), 5,125,20);
 
 //nytabel.indsaetDataTabel();
 
 nytabel.tabelVisuel();
 
 fullScreen();
 
}
