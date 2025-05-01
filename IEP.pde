void setup(){

 koerTabel(); //kører tabellen
  
 TabelVisualisering nytabel= new TabelVisualisering (500,500, 1000, 500, floor(random(10,16)), 3,250,40);
 //TabelVisualisering nytabel= new TabelVisualisering (500,500, 500, 250, floor(random(10,16)), 5,125,20);
 
 //nytabel.indsaetDataTabel();
 
 nytabel.tabelVisuel();
 
 fullScreen();
 
}
