void setup(){

  koerTabel();
 TabelVisualisering nytabel= new TabelVisualisering (500,500, 1000, 500, floor(random(10,16)), 5,250,40);
 
 nytabel.indsaetDataTabel();
 
 nytabel.tabelVisuel();
 
 fullScreen();
 
}
