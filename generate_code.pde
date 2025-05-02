ArrayList<Float> heights = new ArrayList<Float>();

//Lavet ved hjælp af AI. Forsøger at køre processing-java --version, i terminalen for at sikre at processing kan køres igennem consollen.
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

//Funktionen der generere koden som vi launcher i et nyt vindue. Lavet i samarbejde med AI, dog med stor egen biddragelse
String generateCode() {
  StringBuilder codeBuilder = new StringBuilder();
  codeBuilder.append("void setup() {\n");
  codeBuilder.append("  size(400, 400);\n");
  codeBuilder.append("  background(220);\n");

  codeBuilder.append("  int opponentChoice = 0; // Default to defect (0)\n");
  codeBuilder.append("  int playerChoice = 1; // Default to cooperate (1)\n\n");

  ArrayList<Block> sortedBlocks = new ArrayList<Block>();
  for (Block block : blocks) {
    if (!block.picker) {
      sortedBlocks.add(block);
    }
  }

  sortedBlocks.sort((a, b) -> Float.compare(a.y, b.y));

  // Her køres der igennem det som kaldes "main tree". altså alle blokke der står "alene".
  ArrayList<Block> processedBlocks = new ArrayList<Block>();
  for (Block block : sortedBlocks) {
    boolean isNonStartingChainBlock = false;
    for (Block other : sortedBlocks) {
      if (other != block && other.connectedBlocks.contains(block)) {
        isNonStartingChainBlock = true;
        break;
      }
    }

    if (!isNonStartingChainBlock) {
      String blockCode = processBlock(block, 1);
      if (!blockCode.isEmpty()) {
        codeBuilder.append(blockCode).append("\n");
        processedBlocks.add(block);
      }
    }
  }

  codeBuilder.append("}\n");
  return codeBuilder.toString();
}


//Denne funktion "forstår" blokkens funktioner og indhold, og laver dem om til den kode der bruges i vores generateCode();
String processBlock(Block block, int indentLevel) {
  String indent = getIndent(indentLevel);
  StringBuilder codeBuilder = new StringBuilder();
  
  if (block.label.equals("Cooperate")) {
    codeBuilder.append(indent + "delay(100);\n");
    codeBuilder.append(indent + "background(color(0, 255, 0));");
  } 
  else if (block.label.equals("Defect")) {
    codeBuilder.append(indent + "delay(100);\n");
    codeBuilder.append(indent + "background(color(255, 0, 0));");
  } 
  else if (block.label.equals("Spacer")) {
    return "";
  } 
  else if (block.label.equals("Repeat")) {
    ArrayList<Block> chain = new ArrayList<>();
    chain.add(block);
    

    for (Block connected : block.connectedBlocks) {
      chain.add(connected);
      

      for (Block secondLevel : connected.connectedBlocks) {
        if (!chain.contains(secondLevel)) {
          chain.add(secondLevel);
        }
      }
    }
    
    int repeatCount = 5;
    Block actionBlock = null;
    
    for (Block chainBlock : chain) {
      if (chainBlock.label.contains("x")) {
        repeatCount = chainBlock.getNumericValue();
      } 
      else if (chainBlock.label.equals("Cooperate") || chainBlock.label.equals("Defect")) {
        actionBlock = chainBlock;
      }
    }
    
    codeBuilder.append(indent + "for (int i = 0; i < " + repeatCount + "; i++) {\n");
    
    if (actionBlock != null) {
      codeBuilder.append(processBlock(actionBlock, indentLevel + 1)).append("\n");
    }
    
    codeBuilder.append(indent + "}");
  } 
  else if (block.label.equals("If")) {
    ArrayList<Block> chain = new ArrayList<>();
    chain.add(block);
    
    ArrayList<Block> processed = new ArrayList<>();
    processed.add(block);
    buildCompleteChain(block, chain, processed);
    
    Block value1 = null;
    Block operator = null;
    Block value2 = null;
    Block actionBlock = null;
    
    for (Block chainBlock : chain) {
      if ((chainBlock.label.contains("x") || chainBlock.isVariable()) && value1 == null) {
        value1 = chainBlock;
      }
      else if ((chainBlock.label.equals("<") || chainBlock.label.equals(">") || chainBlock.label.equals("==")) && operator == null) {
        operator = chainBlock;
      }
      else if ((chainBlock.label.contains("x") || chainBlock.isVariable()) && value1 != null && value2 == null) {
        value2 = chainBlock;
      }
      else if (chainBlock.label.equals("Cooperate") || chainBlock.label.equals("Defect")) {
        actionBlock = chainBlock;
      }
    }
    
    // (Opbygningen af vores if statement)
    if (value1 != null && operator != null && value2 != null) {
      String val1 = value1.isVariable() ? value1.getVariableName() : Integer.toString(value1.getNumericValue());
      String val2 = value2.isVariable() ? value2.getVariableName() : Integer.toString(value2.getNumericValue());
      String op = operator.label;
      
      codeBuilder.append(indent + "if (" + val1 + " " + op + " " + val2 + ") {\n");
      
      if (actionBlock != null) {
        codeBuilder.append(processBlock(actionBlock, indentLevel + 1)).append("\n");
      }
      
      codeBuilder.append(indent + "}");
    } else {
      codeBuilder.append(indent + "// Incomplete If statement - missing condition or executable blocks");
    }
  } 
  else if (block.label.contains("x") || block.label.equals("<") || block.label.equals(">") || block.label.equals("==") || block.isVariable()) {
    return "";
  } 
  else {
    codeBuilder.append(indent + "// Unknown block type: " + block.label);
  }
  
  return codeBuilder.toString();
}

//Den her "kæder" blokkene sammen.
void buildCompleteChain(Block start, ArrayList<Block> chain, ArrayList<Block> processed) {
  for (Block connected : start.connectedBlocks) {
    if (!processed.contains(connected)) {
      chain.add(connected);
      processed.add(connected);
      buildCompleteChain(connected, chain, processed);
    }
  }
}

//En hjælpefunktion foreslået af AI. Denne funktion gør vi kan ændre indentation i den genereret kode, som gør det mere læsbart. (ikke nødvendig)
String getIndent(int indentLevel) {
  StringBuilder indent = new StringBuilder();
  for (int i = 0; i < indentLevel; i++) {
    indent.append("  ");
  }
  return indent.toString();
}



//Dette er funktionen der kører koden. For debugging's skyld, så printer den lige den genereret kode, 
//ellers kan den også findes inde i mappen "generated_code"
//Udover bare at køre koden, så kører den også vores funktion fra tidligere, for at sikre at processing kan køres.
void runCode() {
  if (canRunProcessingJava()) {
    // Generate the code as a string first for debugging
    String generatedCode = generateCode();
    println("Generated code:");
    println(generatedCode);

    // Save the generated code
    String[] codeLines = generatedCode.split("\n");
    saveStrings("generated_code/generated_code.pde", codeLines);

    // Run the code
    exec("processing-java", "--sketch=" + sketchPath("generated_code"), "--run");
  } else {
    println("Your computer doesn't have processing in its system variables. This is because you're not using the right version of Processing. Please use version 4.3");
  }
}

//Sorterer alle vores blokke lodret.
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
