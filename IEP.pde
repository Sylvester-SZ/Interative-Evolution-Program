  Algoritmer[] algoritmer = new Algoritmer[4]; //laver et array til algoritmerne

void setup(){
 
  //sæt algoritmerne i et array så de er nemme at tilgå
  algoritmer[0] = soedAlgoritme;
  algoritmer[1] = dumAlgoritme;
  algoritmer[2] = random;
  algoritmer[3] = copycat;
  
  //lav tabel med resultater
  resultater.addColumn("spiller1");
    resultater.addColumn("spiller2");
    
    for (int i = 0; i < 15; i++){
      
     resultater.addRow(); 
      
    }
    
    println("kolonner: " + resultater.getColumnCount() + ", rækker: " + resultater.getRowCount()); //debugging
    
    algoritme_kamp(2,3);
    
    saveTable(resultater, "data/resultater.HTML");
  
}
