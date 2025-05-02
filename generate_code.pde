ArrayList<Float> heights = new ArrayList<Float>();
//String algoritmekode = ("boolean resultat;  //det sidste resultat der er udregnetint runde = 0;  // hvilken runde vi er på//lav alle algoritme objekterneSoedAlgoritme soedAlgoritme = new SoedAlgoritme();OndAlgoritme ondAlgoritme = new OndAlgoritme();Random random = new Random();Copycat copycat = new Copycat();class Algoritmer {  //klassen der opbevarer vores algoritmer  String navn; //navnet på algoritmen  boolean soed; //om algoritmen er soed i første runde  Algoritmer() {    //alt der skal være i construkteren  }      boolean spil(Table resultater, boolean spiller1) { //metoder der finder ud af hvad en algoritme vil gørereturn (resultat); //returnere hvad den fandt ud af    }          boolean erSoed() {    return (soed);  }      String navn() {    return (navn);      }  }/*======================================= ny algoritme =============================================*/class SoedAlgoritme extends Algoritmer {  //en algoritme der altid er sød  SoedAlgoritme () {    navn = "Sød algoritme";    soed = true;  //den er som sagt sød  }  boolean spil(Table resultater, boolean spiller1) { //grunden til at der er ubrugte indput er så der ikke kommer en error hvis metoden senere bliver kaldt i et for loop med input den ikke bruger    resultat = true;  //den returneere altid true fordi den altid samarbejder    return(resultat);  }  boolean erSoed() {    return (soed);  }  String navn() {    return (navn);      }}/*=======================================ny algoritme=============================================*/class OndAlgoritme extends Algoritmer {  //en algoritme der aldrig samarbejder  OndAlgoritme () {    navn = "Ond algoritme";    soed = false;  //den er som sagt ikke sød  }  boolean spil(Table resultater, boolean spiller1) {    resultat = false;  //den returneere altid false fordi den aldrig samarbejder    return(resultat);  }  boolean erSoed() {    return (soed);  }  String navn() {    return (navn);  }}/*======================================= ny algoritme =============================================*/class Random extends Algoritmer {  //en algoritme der samarbejder tilfældigt  Random () {    navn = "Tilfældig algoritme";    soed = true;  //den vil ikke (nødvendigvis) gå efter at samarbejde i første runde  }  boolean spil(Table resultater, boolean spiller1) {    if (int(random(2)) == 0) { //50/50 chance      resultat = true;  //tilfældigt output    } else {      resultat = false;    }    return(resultat);  }  boolean erSoed() {    return (soed);  }  String navn() {    return (navn);  }}/*=======================================ny algoritme=============================================*/class Copycat extends Algoritmer {  //en algoritme der gør hvad modstanderen gjorde sidst  Copycat() {    navn = "Copycat";    soed = true;  //den starter med at være sød fordi modstanderen ikke har gjort noget endnu  }  boolean spil(Table resultater, boolean spiller1) {    if (runde == 0) {  //hvis det er første runde      resultat = true;   //samarbejd    } else if (spiller1) { //ellers hvis de er spiller 1      if (boolean(resultater.getInt(runde-1, 3))) { //tjek modstanderens sidste træk i tabellen        resultat = true; //hvis de samarbejdede så samarbejd      } else {        resultat = false; // ellers lad vær      }    } else { //hvis de er spiller 2      if (boolean(resultater.getInt(runde-1, 2))) { //tjek spiller 1 sidste træk        //gør det samme som de gjorde        resultat = true;      } else {        resultat = false;      }    }    return(resultat);  }  boolean erSoed() {    return (soed);  }  String navn() {    return (navn);  }}");
String[] linjer;
String sending;

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
    ////print("Fejl under exec: " + e.getMessage());
  }
  return false;
}

//Funktionen der generere koden som vi launcher i et nyt vindue. Lavet i samarbejde med AI, dog med stor egen biddragelse
String generateCode() {
  StringBuilder codeBuilder = new StringBuilder();
  for (String linje : linjer) {
    codeBuilder.append(linje + "\n");
  }

  codeBuilder.append("boolean bygselvspil(Table resultater) {\n");
  codeBuilder.append("int opponentChoice = resultater.getInt(runde, 3); \n");
  codeBuilder.append("int playerChoice = resultater.getInt(runde, 2); \n");
  codeBuilder.append("boolean res = false;\n");

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
  codeBuilder.append("return res;\n");
  codeBuilder.append("}\n");
  return codeBuilder.toString();
}


//Denne funktion "forstår" blokkens funktioner og indhold, og laver dem om til den kode der bruges i vores generateCode();
String processBlock(Block block, int indentLevel) {
  String indent = getIndent(indentLevel);
  StringBuilder codeBuilder = new StringBuilder();

  if (block.label.equals("Cooperate")) {
    codeBuilder.append(indent + "res = false;\n");
  } else if (block.label.equals("Defect")) {
    codeBuilder.append(indent + "res = true;\n");
  } else if (block.label.equals("Spacer")) {
    return "";
  } else if (block.label.equals("Repeat")) {
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
      } else if (chainBlock.label.equals("Cooperate") || chainBlock.label.equals("Defect")) {
        actionBlock = chainBlock;
      }
    }

    codeBuilder.append(indent + "for (int i = 0; i < " + repeatCount + "; i++) {\n");

    if (actionBlock != null) {
      codeBuilder.append(processBlock(actionBlock, indentLevel + 1)).append("\n");
    }

    codeBuilder.append(indent + "}");
  } else if (block.label.equals("If")) {
    // Process the full horizontal chain to find all parts of the if statement
    ArrayList<Block> chain = new ArrayList<>();
    chain.add(block);

    // Build the complete chain of horizontally connected blocks
    ArrayList<Block> processed = new ArrayList<>();
    processed.add(block);
    buildCompleteChain(block, chain, processed);

    // Extract the components from the chain
    Block value1 = null;
    Block operator = null;
    Block value2 = null;
    Block actionBlock = null;
    Block elseBlock = null;
    Block elseActionBlock = null;

    for (Block chainBlock : chain) {
      if ((chainBlock.label.contains("x") || chainBlock.isVariable()) && value1 == null) {
        value1 = chainBlock;
      } else if ((chainBlock.label.equals("<") || chainBlock.label.equals(">") || chainBlock.label.equals("==")) && operator == null) {
        operator = chainBlock;
      } else if ((chainBlock.label.contains("x") || chainBlock.isVariable()) && value1 != null && value2 == null) {
        value2 = chainBlock;
      } else if (chainBlock.label.equals("Cooperate") || chainBlock.label.equals("Defect")) {
        // If we already found the Else block, this is the else action
        if (elseBlock != null && elseActionBlock == null) {
          elseActionBlock = chainBlock;
        } else if (actionBlock == null) {
          actionBlock = chainBlock;
        }
      } else if (chainBlock.label.equals("Else")) {
        elseBlock = chainBlock;
      }
    }

    // Generate the if statement code
    if (value1 != null && operator != null && value2 != null) {
      String val1 = value1.isVariable() ? value1.getVariableName() : Integer.toString(value1.getNumericValue());
      String val2 = value2.isVariable() ? value2.getVariableName() : Integer.toString(value2.getNumericValue());
      String op = operator.label;

      codeBuilder.append(indent + "if (" + val1 + " " + op + " " + val2 + ") {\n");

      if (actionBlock != null) {
        codeBuilder.append(processBlock(actionBlock, indentLevel + 1)).append("\n");
      }

      codeBuilder.append(indent + "}");

      // Add else block if present
      if (elseBlock != null) {
        codeBuilder.append(" else {\n");

        if (elseActionBlock != null) {
          codeBuilder.append(processBlock(elseActionBlock, indentLevel + 1)).append("\n");
        }

        codeBuilder.append(indent + "}");
      }
    } else {
      codeBuilder.append(indent + "// Incomplete If statement - missing condition or executable blocks");
    }
  } else if (block.label.equals("Else")) {
    // Else blocks are handled within the If block processing
    return "";
  } else if (block.label.contains("x") || block.label.equals("<") || block.label.equals(">") || block.label.equals("==") || block.isVariable()) {
    return "";
  } else {
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



//Dette er funktionen der kører koden. For debugging's skyld, så //printer den lige den genereret kode,
//ellers kan den også findes inde i mappen "generated_code"
//Udover bare at køre koden, så kører den også vores funktion fra tidligere, for at sikre at processing kan køres.
void runCode() {
  if (canRunProcessingJava()) {
    // Generate the code as a string first for debugging
    String generatedCode = generateCode();
    ////print("Generated code:");
    ////print(generatedCode);

    // Save the generated code
    String[] codeLines = generatedCode.split("\n");
    saveStrings("generated_code/generated_code.pde", codeLines);

    // Run the code
    exec("processing-java", "--sketch=" + sketchPath("generated_code"), "--run");
  } else {
    ////print("Your computer doesn't have processing in its system variables. This is because you're not using the right version of Processing. Please use version 4.3");
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
          ////print("Swapped " + i + " med " + (i + 1));
        }
      }
    }
  } while (swapped);
  swapped = false;
}
