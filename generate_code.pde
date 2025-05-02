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
  } else if (block.label.equals("Spacer")) {
    // Spacer doesn't generate any code but may have children
    ArrayList<Block> children = block.getChildBlocks();
    if (!children.isEmpty()) {
      for (Block child : children) {
        String childCode = generateBlockCode(child, indentLevel);
        if (!childCode.isEmpty()) {
          codeBuilder.append(childCode).append("\n");
        }
      }
    }
  } else if (block.label.startsWith("Repeat")) {
    // Get all connected blocks for this Repeat block
    ArrayList<Block> connectedBlocks = block.connectedBlocks;

    // Default repeat count
    int repeatCount = 5;

    // Look for a numeric block (like 5x, 10x, 20x) directly connected to Repeat
    for (Block connected : connectedBlocks) {
      if (connected.label.contains("x")) {
        repeatCount = connected.getNumericValue();
        break;
      }
    }

    codeBuilder.append(indent + "for (int i = 0; i < " + repeatCount + "; i++) {");

    // Find the action block (should be the second connected block or after numeric block)
    Block actionBlock = null;
    for (Block connected : connectedBlocks) {
      if (!connected.label.contains("x")) {
        actionBlock = connected;
        break;
      }
    }

    // If no specific action block found, look for child blocks
    if (actionBlock == null) {
      ArrayList<Block> children = block.getChildBlocks();
      for (Block child : children) {
        if (!child.label.contains("x")) {
          actionBlock = child;
          break;
        }
      }
    }

    // Process the action block
    if (actionBlock != null) {
      codeBuilder.append("\n");
      codeBuilder.append(generateBlockCode(actionBlock, indentLevel + 1)).append("\n");
      codeBuilder.append(indent);
    }

    codeBuilder.append("}");
  } else if (block.label.equals("If")) {
    // Handle If block with condition and executable blocks
    ArrayList<Block> connectedBlocks = block.connectedBlocks;

    // We need: value1, operator, value2, action
    Block value1 = null;
    Block operator = null;
    Block value2 = null;
    Block actionBlock = null;

    // Try to identify the components from connected blocks
    for (Block connected : connectedBlocks) {
      if (connected.label.contains("x") && value1 == null) {
        value1 = connected;
      } else if ((connected.label.equals("<") || connected.label.equals(">") || connected.label.equals("==")) && operator == null) {
        operator = connected;
      } else if (connected.label.contains("x") && value1 != null && value2 == null) {
        value2 = connected;
      } else if (!connected.label.contains("x") && !connected.label.equals("<") &&
        !connected.label.equals(">") && !connected.label.equals("==")) {
        actionBlock = connected;
      }
    }

    // If we have the required components, generate the if statement
    if (value1 != null && operator != null && value2 != null) {
      int val1 = value1.getNumericValue();
      int val2 = value2.getNumericValue();
      String op = operator.label;

      codeBuilder.append(indent + "if (" + val1 + " " + op + " " + val2 + ") {");

      // Process the action block
      if (actionBlock != null) {
        codeBuilder.append("\n");
        codeBuilder.append(generateBlockCode(actionBlock, indentLevel + 1)).append("\n");
        codeBuilder.append(indent);
      }

      codeBuilder.append("}");
    } else {
      codeBuilder.append(indent + "// Incomplete If statement - missing condition or executable blocks");
    }
  } else if (block.label.contains("x")) {
    // Numeric blocks should be handled by their parent blocks, not individually
    // But we could add a comment for debugging
    codeBuilder.append(indent + "// Numeric value: " + block.getNumericValue());
  } else if (block.label.equals("<") || block.label.equals(">") || block.label.equals("==")) {
    // Operator blocks should be handled by their parent blocks, not individually
    // But we could add a comment for debugging
    codeBuilder.append(indent + "// Operator: " + block.label);
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
