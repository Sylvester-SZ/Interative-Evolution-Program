boolean resultat;  //det sidste resultat der er udregnet
int runde = 0;  // hvilken runde vi er på

//lav alle algoritme objekterne
SoedAlgoritme soedAlgoritme = new SoedAlgoritme();
OndAlgoritme ondAlgoritme = new OndAlgoritme();
Random random = new Random();
Copycat copycat = new Copycat();
Haevnfuld haevnfuld = new Haevnfuld();
Pavlov pavlov = new Pavlov();
VægtetTilfældig vægtetTilfældig = new VægtetTilfældig();
Gennemsnit gennemsnit = new Gennemsnit();
Detektiv detektiv = new Detektiv();


class Algoritmer {  //klassen der opbevarer vores algoritmer

  String navn; //navnet på algoritmen
  boolean soed; //om algoritmen har chance for at være den første der ikke samarbejder
  String beskrivelse; //beskrivelse af algoritmen

  Algoritmer() {

    //alt der skal være i construkteren
  }

  boolean spil(Table resultater, boolean spiller1) { //metoder der finder ud af hvad en algoritme vil gøre

    return (resultat); //returnere hvad den fandt ud af
  }

  boolean erSoed() {

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*======================================= ny algoritme =============================================*/



class SoedAlgoritme extends Algoritmer {  //en algoritme der altid er sød

  SoedAlgoritme () {

    navn = "Sød algoritme";
    soed = true;  //den er som sagt sød
    beskrivelse = "En algoritme der ALTID samarbejder.";
  }

  boolean spil(Table resultater, boolean spiller1) { //grunden til at der er ubrugte indput er så der ikke kommer en error hvis metoden senere bliver kaldt i et for loop med input den ikke bruger

    resultat = true;  //den returneere altid true fordi den altid samarbejder

    return(resultat);
  }

  boolean erSoed() {

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*=======================================ny algoritme=============================================*/



class OndAlgoritme extends Algoritmer {  //en algoritme der aldrig samarbejder

  OndAlgoritme () {

    navn = "Ond algoritme";
    soed = false;  //den er som sagt ikke sød
    beskrivelse = "En algoritme der ALDRIG samarbejder.";
  }

  boolean spil(Table resultater, boolean spiller1) {

    resultat = false;  //den returneere altid false fordi den aldrig samarbejder

    return(resultat);
  }

  boolean erSoed() {

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*======================================= ny algoritme =============================================*/



class Random extends Algoritmer {  //en algoritme der samarbejder tilfældigt

  Random () {

    navn = "Tilfældig algoritme";
    soed = false;  //den vil ikke nødvendigvis gå efter at samarbejde
    beskrivelse = "En algoritme der tilfældigt vælger om den samarbejder.";
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

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*=======================================ny algoritme=============================================*/



class Copycat extends Algoritmer {  //en algoritme der gør hvad modstanderen gjorde sidst

  Copycat() {

    navn = "Copycat";
    soed = true;  //den starter med at være sød fordi modstanderen ikke har gjort noget endnu og stopper først med at samarbejde hvis modstanderen gør
    beskrivelse = "En algoritme der gør hvad modstanderen gjorde sidste runde. I første runde samarbejder den.";
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

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*=======================================ny algoritme=============================================*/



class Haevnfuld extends Algoritmer {  //en algoritme der samarbejder indtil modstandere ikke gør og derefter aldrig samarbejder igen

  Haevnfuld () {

    navn = "Hævnfuld algoritme";
    soed = true;  //den starter som sagt med at samarbejde
    beskrivelse = "En algoritme der samarbejder indtil modstanderen ikke gør, hvorefter den aldrig mere samarbejder.";
  }

  boolean spil(Table resultater, boolean spiller1) {

    if (runde == 0) { //hvis det er første runde

      resultat = true;
    } else {

      for (int i = 0; i < runde; i++) {

        if ((spiller1 && boolean(resultater.getInt(i, 3))) || ( !spiller1 && boolean(resultater.getInt(i, 2)))) { //hvis den anden spiller har været sød

          resultat = true; //også vær sød
        } else {

          resultat = false; //ellers prøv at snyde

          return(resultat);
        }
      }
    }

    return(resultat);
  }

  boolean erSoed() {

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*=======================================ny algoritme=============================================*/



class Pavlov extends Algoritmer {  //en algoritme der gør hvad den gjorde sidst hvis det gik godt, og det omvendte hvis det gik dårligt

  Pavlov () {

    navn = "Pavlov";
    soed = true;  //den starter med at samarbejde og den eneste måde det vil gå dårligt er hvis modstanderen ikke gør
    beskrivelse = "En algoritme der gør hvad den gjorde sidst hvis det gik godt, og det omvendte hvis det gik dårligt.";
  }

  boolean spil(Table resultater, boolean spiller1) {

    if (runde == 0) { //hvis det er første runde

      resultat = true;
    } else {

      if (spiller1) {
        if ((2 < resultater.getInt(runde - 1, 0))) { //hvis det er spiller 1 og den fik over 2 point sidste runde

          resultat = boolean(resultater.getInt(runde - 1, 2)); //gør det samme
        } else { //hvis det ikke gik godt sidste runde

          resultat = !boolean(resultater.getInt(runde - 1, 2)); //gør det modsatte
        }
      } else { //hvis det er spiller 2
        if (2 < resultater.getInt(runde - 1, 1)) { //hvis den fik over 2 point sidste runde

          resultat = boolean(resultater.getInt(runde - 1, 3)); //gør det samme
        } else {

          resultat = !boolean(resultater.getInt(runde - 1, 3)); //gør det modsatte
        }
      }
    }

    return(resultat);
  }

  boolean erSoed() {

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*=======================================ny algoritme=============================================*/



class VægtetTilfældig extends Algoritmer {  //en algoritme der tager et tilfældigt valgt men bliver mere tilbøjelig til ikke at samarbejde som der går flere runder

  VægtetTilfældig () {

    navn = "Vægtet tilfældig algoritme";
    soed = false;  //den kan sagtens være den første til ikke at samarbejde
    beskrivelse = "En algoritme der tager et tilfældigt valg, men bliver mere tilbøjelig til ikke at samarbejde som der går flere runder.";
  }

  boolean spil(Table resultater, boolean spiller1) {

    if (runde < random(15)) {

      resultat = true;
    } else {

      resultat = false;
    }

    return(resultat);
  }

  boolean erSoed() {

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*=======================================ny algoritme=============================================*/



class Gennemsnit extends Algoritmer {  //En algoritme der tager det valg der er lavet flest gange af modstanderen, hvis modstanderen har samarbejdet og ikke samarbejdet lige mange gange, samarbejder den.

  int samarbejdet;

  Gennemsnit () {

    navn = "Gennemsnits algoritme";
    soed = true;  //den kan ikke være den første der ikke samarbejder
    beskrivelse = "En algoritme der tager det valg der er lavet flest gange af modstanderen, hvis modstanderen har samarbejdet og ikke samarbejdet lige mange gange, samarbejder den.";
  }

  boolean spil(Table resultater, boolean spiller1) {

    samarbejdet = 0;

    for (int i = 0; i < runde; i++) {

      if ((spiller1 && boolean(resultater.getInt(i, 3))) || (!spiller1 && boolean(resultater.getInt(i, 2)))) { //hvis det er spiller 1 og spiller 2 har samarbejdet i den givne runde eller hvis det er spiller 2 og spiller 1 har samarbejdet

        samarbejdet++; //tilføj en til samarbejde tælleren
      }
    }

    if (runde == 0) {

      resultat = true;
    } else if (boolean(round(float(samarbejdet)/float(runde)))) { //hvis der er samarbejdet halvdelen eller over af runderne

      ////print(round(float(samarbejdet)/float(runde)));
      ////print(float(samarbejdet)/float(runde));
      ////print(float(samarbejdet) + " " + float(runde));

      resultat = true;
    } else {

      ////print(round(float(samarbejdet)/float(runde)));
      ////print(float(samarbejdet)/float(runde));
      ////print(float(samarbejdet) + " " + float(runde));

      resultat = false;
    }

    return(resultat);
  }

  boolean erSoed() {

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}



/*=======================================ny algoritme=============================================*/



class Detektiv extends Algoritmer {  //En algoritme der starter med at være som copycat, men efter nogle runder tjekker om modstanderen gør modstand hvis den er ikke samarbejder. Hvis modstandere ikke gør modstand, bliver den ved med ikke at samarbejde.

  Detektiv () {

    navn = "Detektiv";
    soed = false;  //den kan godt være den første der ikke samarbejder
    beskrivelse = "En algoritme der starter med at være sød, men efter nogle runder tjekker om modstanderen gør modstand hvis den er ikke samarbejder. Hvis modstandere ikke gør modstand, bliver den ved med ikke at samarbejde.";
  }

  boolean spil(Table resultater, boolean spiller1) {

    if (runde < 3) {

      //hvis det er en af de 3 første runder så gør den præcis det samme som copycat
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
    } else if (runde == 3) { // hvis det er runde 3 så samarbejder den ikke ligemeget hvad

      resultat = false;
    } else if (runde == 4) {

      //gør som copycat igen mens den venter på svar fra sidste runde og er sød en ekstra gang hvis den eksmempelvis er oppe mod en copycat så den ikke ender i en fre og tilbage af samarbejd, ikke samarbejde, samarbejd, ikke samarbejde osv.
      if (spiller1) { //ellers hvis de er spiller 1

        if (boolean(resultater.getInt(3, 3))) { //tjek modstanderens træk i tabellen

          resultat = true; //hvis de samarbejdede så samarbejd
        } else {

          resultat = false; // ellers lad vær
        }
      } else { //hvis de er spiller 2

        if (boolean(resultater.getInt(3, 2))) { //tjek spiller 1 træk

          //gør det samme som de gjorde

          resultat = true;
        } else {

          resultat = false;
        }
      }
    } else if (spiller1 && boolean(resultater.getInt(4, 3))) { //hvis det er efter runde 4 tjek hvad den anden spiller gjorde i runde 4 og hvis de stadig samarbejded så bliv ved med ikke at samarbejde

      resultat = false;
    } else if (!spiller1 && boolean(resultater.getInt(4, 2))) { //tjek hvad den anden spiller gjorde i runde 4 og hvis de stadig samarbejded så bliv ved med ikke at samarbejde

      resultat = false;
    } else { //ellers gå tilbage til copycat
    
    if (runde == 5){ //hvis det er lige efter runde 4 og den anden ikke samarbejdede skal den gøre som i runde 3 og ikke runde 4
    
    if (spiller1) { //hvis de er spiller 1

        if (boolean(resultater.getInt(3, 3))) { //tjek modstanderens tredje i tabellen

          resultat = true; //hvis de samarbejdede så samarbejd
        } else {

          resultat = false; // ellers lad vær
        }
      } else { //hvis de er spiller 2

        if (boolean(resultater.getInt(3, 2))) { //tjek spiller 1 tredje træk

          //gør det samme som de gjorde

          resultat = true;
        } else {

          resultat = false;
        }
      
      }
    
    } else if (spiller1) { //hvis de er spiller 1

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
    }

    return(resultat);
  }

  boolean erSoed() {

    return (soed);
  }

  String navn() {

    return (navn);
  }

  String beskrivelse() {

    return (beskrivelse);
  }
}
