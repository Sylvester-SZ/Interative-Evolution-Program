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
  ArrayList<String> result = new ArrayList<String>();
  result.add("void setup() {");
  result.add("  size(400, 400);");
  result.add("  background(220);");

  // Only process top-level blocks (no parent and not pickers)
  for (Block block : blocks) {
    if (!block.picker && block.parent == null) {
      result.add(generateBlockCode(block, 1));
    }
  }

  result.add("}");

  // Debug output
  println("Generated code:");
  for (String line : result) {
    println(line);
  }

  saveStrings("generated_code/generated_code.pde", result.toArray(new String[0]));
}


String generateBlockCode(Block block, int indentLevel) {
  if (block.picker) {
    return "";
  }
  
  String indent = getIndent(indentLevel);
  StringBuilder codeBuilder = new StringBuilder();
  
  // Process this block
  if (block.label.equals("Cooperate")) {
    codeBuilder.append(indent + "delay(100);\n");
    codeBuilder.append(indent + "background(color(0, 255, 0));");
  } else if (block.label.equals("Defect")) {
    codeBuilder.append(indent + "delay(100);\n");
    codeBuilder.append(indent + "background(color(255, 0, 0));");
  } else if (block.label.startsWith("Repeat")) {
    // Get all children blocks for this Repeat block
    ArrayList<Block> children = block.getChildBlocks();
    
    // Determine repeat count - use first child's numeric value if available
    int repeatCount = 5; // Default value
    
    if (!children.isEmpty()) {
      Block firstChild = children.get(0);
      // Use the first child for repeat count if it has a numeric value
      repeatCount = firstChild.getNumericValue();
      
      // Remove the first child from processing as it's used for the count
      children.remove(0);
    }
    
    codeBuilder.append(indent + "for (int i = 0; i < " + repeatCount + "; i++) {");
    
    // Process remaining children
    if (!children.isEmpty()) {
      codeBuilder.append("\n");
      for (Block child : children) {
        codeBuilder.append(generateBlockCode(child, indentLevel + 1)).append("\n");
      }
      codeBuilder.append(indent);
    }
    
    codeBuilder.append("}");
  } else {
    codeBuilder.append(indent + "// Unknown block type: " + block.label);
  }
  
  return codeBuilder.toString();
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
