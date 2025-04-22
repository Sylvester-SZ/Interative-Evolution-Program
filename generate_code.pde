void generateCode() {
  String[] header = { "void setup() {", "  size(400, 400);", "  background(220);" };
  String[] footer = { "}" };
  
  String[] body = new String[blocks.length];
  
  for (int i = 0; i < blocks.length; i++) {
    if (blocks[i].label.equals("Defect")) {
      body[i] = "  println(\"Defect\");";
    } else if (blocks[i].label.equals("Cooperate")) {
      body[i] = "  println(\"Cooperate\");";
    } else if (blocks[i].label.equals("Repeat")) {
      body[i] = "  println(\"Repeat last action\");";
    }
  }
  
  // Samler alt til én fil
  String[] fullCode = concat(concat(header, body), footer);
  saveStrings("generated_code/generated_code.pde", fullCode);
}


void runCode() {
  generateCode(); // Gemmer filen
  
  // Eksekverer Processing-koden
  exec("processing-java", "--sketch=" + sketchPath("generated_code"), "--run");
}
