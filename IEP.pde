
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
  
 TabelVisualisering nytabel= new TabelVisualisering (width/4,height/4, width/2.2, height/4, floor(random(10,16)), 3,width/8,height/25); //laver en fysisk tabel på skærmen ud fra class Tabelvisualisering
 //TabelVisualisering nytabel= new TabelVisualisering (500,500, 500, 250, floor(random(10,16)), 5,125,20);
 
 //nytabel.indsaetDataTabel();
 
 nytabel.tabelVisuel();
  
  fullScreen();
  
}

void draw(){
 
  SkaermState = 1;
  
  if(SkaermState == 0){
     SplashScreen();
  }
  if(SkaermState == 1){
     StartSkaerm();
  }
  if(SkaermState == 2){
     AlgoritmeSkaerm();
  }
  if(SkaermState == 3){
     BygSelvSkaerm();
  }
  
  
}
