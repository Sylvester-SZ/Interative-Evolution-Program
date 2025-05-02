ArrayList<Float> heights = new ArrayList<Float>();

boolean canRunProcessingJava() {
  try {
    Process process = Runtime.getRuntime().exec("processing-java --version");
    process.waitFor();

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


    return output.toString().toLowerCase().contains("processing");
  }
  catch (IOException | InterruptedException e) {
    println("Fejl under exec: " + e.getMessage());
  }
  return false;
}

void generateCode() {
  String[] header = { "void setup() {", "  size(400, 400);", "  background(220);" };
  String[] footer = { "}" };

  String[] body = new String[blocks.size()];

  for (int i = 0; i < blocks.size(); i++) {
    if (blocks.get(i).label.equals("Defect") && !blocks.get(i).picker) {
      body[i] = "  background(color(255,0,0));";
    } else if (blocks.get(i).label.equals("Cooperate")&&!blocks.get(i).picker) {
      body[i] = "  delay(100);";
    } else if (blocks.get(i).label.equals("Repeat")&&!blocks.get(i).picker) {
      body[i] = "  background(color(0,0,255));";
    }
    else if(blocks.get(i).picker){
      body[i] = "";
    }
  }

  // Samler alt til én fil
  String[] fullCode = concat(concat(header, body), footer);
  saveStrings("generated_code/generated_code.pde", fullCode);
}


void runCode() {
    parseCode();
  if (canRunProcessingJava()) {
    generateCode();

    exec("processing-java", "--sketch=" + sketchPath("generated_code"), "--run");
  } else {
    println("Din computer har ikke processing i dens systemvaribler. Dette skyldes at du ikke bruger den rigtige version af Processing. Brug venligst version 4.3");
  }
}


void parseCode() {
  boolean swapped;
  do {
    swapped = false;

    for (int i = 0; i < blocks.size() - 1; i++) {
      Block a = blocks.get(i);
      Block b = blocks.get(i + 1);

      if (!a.picker && !b.picker) {
        if (a.y > b.y) {
          blocks.set(i, b);
          blocks.set(i + 1, a);
          swapped = true;
          println("Swapped " + i + " med " + (i + 1));
        }
      }
    }
  } while (swapped);
  swapped = false;
}
