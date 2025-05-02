ArrayList<Float> heights = new ArrayList<Float>();

//Lavet ved hjælp af AI
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
  ArrayList<String> bodyLines = new ArrayList<String>();

  for (Block block : blocks) {
    // Kun top‑level blokke (ingen parent) og ikke‑picker
    if (!block.picker && block.parent == null) {
      bodyLines.add(generateBlockCode(block, 1));
    }
  }

  ArrayList<String> result = new ArrayList<String>();
  result.add("void setup() {");
  result.add("  size(400, 400);");
  result.add("  background(220);");

  for (String line : bodyLines) {
    result.add(line);
  }
  result.add("}");

  saveStrings("generated_code/generated_code.pde", result.toArray(new String[0]));
}




String generateBlockCode(Block block, int indentLevel) {
  if (block.picker) {
    return "";
  } else {
    String indent = getIndent(indentLevel);

    if (block.label.equals("Cooperate")) {
      return indent + "delay(100);\n" + indent + "background(color(0, 255, 0));";
    }

    if (block.label.equals("Defect")) {
      return indent + "delay(100);\n" + indent + "background(color(255, 0, 0));";
    }

    if (block.label.startsWith("Repeat")) {
      int repeatCount = 1;
      if (block.label.split(" ").length > 1) {
        try {
          repeatCount = Integer.parseInt(block.label.split(" ")[1].replace("x", ""));
        }
        catch (Exception e) {
          repeatCount = 1;
        }
      }

      ArrayList<Block> children = block.getChildBlocks();
      StringBuilder repeatCode = new StringBuilder();
      repeatCode.append(indent + "for (int i = 0; i < " + repeatCount + "; i++) {\n");

      for (Block child : children) {
        if (!child.picker) {
          repeatCode.append(generateBlockCode(child, indentLevel + 1) + "\n");
        }
      }

      repeatCode.append(indent + "  // End Repeat\n");
      repeatCode.append(indent + "}");

      return repeatCode.toString();
    }

    return indent + "// Ukendt blok-type: " + block.label;
  }
}


String getIndent(int indentLevel) {
  StringBuilder indent = new StringBuilder();
  for (int i = 0; i < indentLevel; i++) {
    indent.append("  ");
  }
  return indent.toString();
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
