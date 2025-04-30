Table resultater = new Table();  //tabel med resultaterne

void algoritme_kamp(int algoritme1, int algoritme2){ //kan laves til at returnere en tabel i stedet for at opdatere hvis man vil lave multithreading i en større evolutionssimulation
  
  for (int i = 0; i < 12; i++){ //kør antallet af runder, eksempelvis 11
    
  resultater.setInt(i,0,int(algoritmer[algoritme1].spil(resultater, true))); //finder ud af hvad algoritmerne vil gøre i en given runde og sætter det i tabellen med resultater
  
  resultater.setInt(i,1,int(algoritmer[algoritme2].spil(resultater, false)));
  
  runde++;
  }
  
  runde = 0;
  
}
