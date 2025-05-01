
void tjekAlgoritmeKnapper(){
  
  for (int i = 0; i < algoritmer.length; i++){ //for hver algoritme
  
if (hitbox(width/20, height/10, width/10, height/10, 0)){ // hvis der tyrkkes på knappen
 
background(0,0,255);
  
}

  rect(width/20, height/10, width/10, height/10, 10); //tegn knappen
  
  }

}
