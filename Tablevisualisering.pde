Table sildeben;


void koerTabel(){
 sildeben = new Table();
 
 sildeben.addColumn("Spiller 1", Table.INT);
 sildeben.addColumn("Spiller 2", Table.INT);
 sildeben.addColumn("Spiller 1 valg", Table.INT);
 sildeben.addColumn("Spiller 2 valg", Table.INT);
 
 sildeben.addRow();
 
 sildeben.setInt(0,"Spiller 1",5);
 sildeben.setInt(0,"Spiller 2",0);
 sildeben.setInt(0,"Spiller 1 valg",1);
 sildeben.setInt(0,"Spiller 2 valg",0);
 
 ////print(sildeben.getInt(0, "Spiller 1"));
 ////print(sildeben.getInt(0,"Spiller 2"));
 ////print(sildeben.getInt(0, "Spiller 1 valg"));
 ////print(sildeben.getInt(0,"Spiller 2 valg"));
}
