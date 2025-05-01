boolean canRunProcessingJava() {
  try {
    Process process = Runtime.getRuntime().exec("processing-java --version");
    process.waitFor(); // Vent på at processen er færdig

    BufferedReader stdOut = new BufferedReader(new InputStreamReader(process.getInputStream()));
    BufferedReader stdErr = new BufferedReader(new InputStreamReader(process.getErrorStream()));

    String line;
    StringBuilder output = new StringBuilder();
    
    while ((line = stdOut.readLine()) != null) {
      output.append(line).append("\n");
    }
    while ((line = stdErr.readLine()) != null) {
      output.append(line).append("\n");
    }

    //println("Output fra kommandoen:\n" + output);

    // Kig i output for noget der ligner "Processing 4.x"
    return output.toString().toLowerCase().contains("processing");
    
  } catch (IOException | InterruptedException e) {
    println("Fejl under exec: " + e.getMessage());
  }
  return false;
}

void generateCode() {
  String[] header = { "void setup() {", "  size(400, 400);", "  background(220);" };
  String[] footer = { "}" };

  String[] body = new String[blocks.size()];

  for (int i = 0; i < blocks.size(); i++) {
    if (blocks.get(i).label.equals("Defect")) {
      body[i] = "  println(\"Defect\");";
    } else if (blocks.get(i).label.equals("Cooperate")) {
      body[i] = "  println(\"Cooperate\");";
    } else if (blocks.get(i).label.equals("Repeat")) {
      body[i] = "  println(\"Repeat last action\");";
    }
  }

  // Samler alt til én fil
  String[] fullCode = concat(concat(header, body), footer);
  saveStrings("generated_code/generated_code.pde", fullCode);
}


void runCode() {
  if (canRunProcessingJava()) {
    generateCode(); // Gemmer filen

    // Eksekverer Processing-koden
    exec("processing-java", "--sketch=" + sketchPath("generated_code"), "--run");
  }
  else{
    println("Din computer har ikke processing i dens systemvaribler. Dette skyldes at du ikke bruger den rigtige version af Processing. Brug venligst version 4.3");
  }
}
