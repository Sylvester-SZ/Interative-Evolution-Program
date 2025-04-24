  Table resultater;  //tabel med resultaterne
  boolean resultat;  //det sidste resultat der er udregnet
  int runde = 0;  // hvilken runde vi er på

class Algoritmer{  //klassen der opbevarer vores algoritmer
  
  boolean soed;  //er algoritmen sød (starter den med at samarbejde)
  
  Algoritmer(){
    
    //alt der skal være i construkteren
    
  }
  
  boolean spil(){
    
    //den logik der skal stå for at returnere et resultat i form af at samarbejde eller ej
    
    return(resultat);  //resultatet der returneres
    
  }
  
  boolean erSoed(){
    
   return(soed); 
    
  }
  
}



/*=======================================ny algoritme=============================================*/



class SoedAlgoritme extends Algoritmer{  //en algoritme der altid er sød
 
  boolean soed;
  
  SoedAlgoritme (){
    
    soed = true;  //den er som sagt sød
    
  }
  
    boolean spil(){
    
    resultat = true;  //den returneere altid true fordi den altid samarbejder
    
    return(resultat);
    
  }
  
    boolean erSoed(){
    
   return super.erSoed(); 
    
  }
  
}



/*=======================================ny algoritme=============================================*/



class DumAlgoritme extends Algoritmer{  //en algoritme der aldrig samarbejder
 
  boolean soed;
  
  DumAlgoritme (){
    
    soed = false;  //den er som sagt ikke sød
    
  }
  
    boolean spil(){
    
    resultat = false;  //den returneere altid false fordi den aldrig samarbejder
    
    return(resultat);
    
  }
  
      boolean erSoed(){
    
   return super.erSoed(); 
    
  }
  
}



/*=======================================ny algoritme=============================================*/



class RandomAlgoritme extends Algoritmer{  //en algoritme der samarbejder tilfældigt
 
  boolean soed;
  
  RandomAlgoritme (){
    
    soed = true;  //den vil ikke (nødvendigvis) gå efter at samarbejde i første runde
    
  }
  
    boolean spil(){
    
      if (int(random(2)) == 0){ //50/50 chance
      
    resultat = true;  //tilfældigt output
    
      } else {
        
       resultat = false;
       
      }
    
    return(resultat);
    
  }
  
      boolean erSoed(){
    
   return super.erSoed(); 
    
  }
  
}



/*=======================================ny algoritme=============================================*/



class Copycat extends Algoritmer{  //en algoritme der gør hvad modstanderen gjorde sidst
 
  boolean soed;
  
   Copycat(){
    
    soed = true;  //den starter med at være sød fordi modstanderen ikke har gjort noget endnu
    
  }
  
    boolean spil(){
    
    if (runde == 0){  //hvis det er første runde
    
    resultat = true;   //samarbejd
    
    }
    //ellers tjek modstanderens sidste træk i tabellen
    //gør det samme som de gjorde
    
    return(resultat);
    
  }
  
      boolean erSoed(){
    
   return super.erSoed(); 
    
  }
  
}
