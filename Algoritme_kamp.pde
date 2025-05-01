Table resultater = new Table();  //tabel med resultaterne

void algoritme_kamp(int algoritme1, int algoritme2) { //kan laves til at returnere en tabel i stedet for at opdatere hvis man vil lave multithreading i en større evolutionssimulation

  for (int i = 0; i < 12; i++) { //kør antallet af runder, eksempelvis 12

    resultater.setInt(i, 2, int(algoritmer[algoritme1].spil(resultater, true))); //finder ud af hvad algoritmerne vil gøre i en given runde og sætter det i tabellen med resultater

    resultater.setInt(i, 3, int(algoritmer[algoritme2].spil(resultater, false)));

    //sætter point ind baseret på valg
    if (boolean(resultater.getInt(i, 2)) && boolean(resultater.getInt(i, 3))) { //hvis begge er søde
      //sætter point ind
      resultater.setInt(i, 0, 3);
      resultater.setInt(i, 1, 3);
    } else if (!boolean(resultater.getInt(i, 2)) && boolean(resultater.getInt(i, 3))) { // hvis første er ond
      //sætter point ind
      resultater.setInt(i, 0, 5);
      resultater.setInt(i, 1, 0);
    } else if (boolean(resultater.getInt(i, 2)) && !boolean(resultater.getInt(i, 3))) { // hvis anden er ond
      //sætter point ind
      resultater.setInt(i, 0, 0);
      resultater.setInt(i, 1, 5);
    } else if (!boolean(resultater.getInt(i, 2)) && !boolean(resultater.getInt(i, 3))) { // hvis begge er ond
      //sætter point ind
      resultater.setInt(i, 0, 1);
      resultater.setInt(i, 1, 1);
    }

    runde++; //næste runde
  }

  runde = 0; //når algoritmerne har kørt resettes runden
}
