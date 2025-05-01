boolean resultat;  //det sidste resultat der er udregnet
int runde = 0;  // hvilken runde vi er på

//lav alle algoritme objekterne
  SoedAlgoritme soedAlgoritme = new SoedAlgoritme();
  DumAlgoritme dumAlgoritme = new DumAlgoritme();
  Random random = new Random();
  Copycat copycat = new Copycat();

class Algoritmer {  //klassen der opbevarer vores algoritmer

  boolean soed;  //er algoritmen sød (starter den med at samarbejde)

  Algoritmer() {

    //alt der skal være i construkteren
  }

  boolean spil(Table resultater, boolean spiller1) { //tabel med tidligere resulater til hvis algortimen bruger dette og om algortimen er spiller 1 eller 2 i tabellen med resultater for at hvide om det eksempelvis var dem selv eller modstanderen der var ond sidste gang

    //den logik der skal stå for at returnere et resultat i form af at samarbejde eller ej

    return(resultat);  //resultatet der returneres
  }

  boolean erSoed() {

    return(soed);
  }
}



/*======================================= ny algoritme =============================================*/



class SoedAlgoritme extends Algoritmer {  //en algoritme der altid er sød

  boolean soed;

  SoedAlgoritme () {

    soed = true;  //den er som sagt sød
  }

  boolean spil(Table resultater, boolean spiller1) { //grunden til at der er ubrugte indput er så der ikke kommer en error hvis metoden senere bliver kaldt i et for loop med input den ikke bruger

    resultat = true;  //den returneere altid true fordi den altid samarbejder

    return(resultat);
  }

  boolean erSoed() {

    return super.erSoed();
  }
}



/*=======================================ny algoritme=============================================*/



class DumAlgoritme extends Algoritmer {  //en algoritme der aldrig samarbejder

  boolean soed;

  DumAlgoritme () {

    soed = false;  //den er som sagt ikke sød
  }

  boolean spil(Table resultater, boolean spiller1) {

    resultat = false;  //den returneere altid false fordi den aldrig samarbejder

    return(resultat);
  }

  boolean erSoed() {

    return super.erSoed();
  }
}



/*======================================= ny algoritme =============================================*/



class Random extends Algoritmer {  //en algoritme der samarbejder tilfældigt

  boolean soed;

  Random () {

    soed = true;  //den vil ikke (nødvendigvis) gå efter at samarbejde i første runde
  }

  boolean spil(Table resultater, boolean spiller1) {

    if (int(random(2)) == 0) { //50/50 chance

      resultat = true;  //tilfældigt output
    } else {

      resultat = false;
    }

    return(resultat);
  }

  boolean erSoed() {

    return super.erSoed();
  }
}



/*=======================================ny algoritme=============================================*/



class Copycat extends Algoritmer {  //en algoritme der gør hvad modstanderen gjorde sidst

  boolean soed;

  Copycat() {

    soed = true;  //den starter med at være sød fordi modstanderen ikke har gjort noget endnu
  }

  boolean spil(Table resultater, boolean spiller1) {

    if (runde == 0) {  //hvis det er første runde

      resultat = true;   //samarbejd
    } else if (spiller1) { //ellers hvis de er spiller 1

        if (boolean(resultater.getInt(runde-1, 3))) { //tjek modstanderens sidste træk i tabellen

          resultat = true; //hvis de samarbejdede så samarbejd
        } else {

          resultat = false; // ellers lad vær
        }
      } else { //hvis de er spiller 2

        if (boolean(resultater.getInt(runde-1, 2))) { //tjek spiller 1 sidste træk

          //gør det samme som de gjorde

          resultat = true;
        } else {

          resultat = false;
        }
      }

      return(resultat);
    }

    boolean erSoed() {

      return super.erSoed();
    }
  }
