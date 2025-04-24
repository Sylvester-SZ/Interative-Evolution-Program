Table sildeben;

int antalSildeben=floor(random(10,16));
int antalRaekker=4;

void koerTabel(){
 sildeben = new Table();
 
 sildeben.addColumn("Spiller 1", Table.INT);
 sildeben.addColumn("Spiller 2", Table.INT);
 
 sildeben.addRow();
 
 sildeben.setInt(0,"Spiller 1",5);
 sildeben.setInt(0,"Spiller 2",3);
 
 println(sildeben.getInt(0, "Spiller 1"));
 println(sildeben.getInt(0,"Spiller 2"));
}


void tabelVisuel(){
  //stroke(173, 216, 230); lyseblå farve
  strokeWeight(6);
  int i=0;
  while(i<antalSildeben*width){
  line(i,0,i,height);
  i=i+width/antalSildeben;
  
  }
  
  int j=0;
  while(j<antalRaekker*width){
  line(0,j,width,j);
  j=j+height/antalRaekker;
  
  }
  
  println(antalSildeben);
}
