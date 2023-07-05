import java.util.*;

class Questions {
  String fullLine;
  String[] test;
  String[] optionsSplit;
  String[] fileName;
  String mode;
  
  Questions(String[] fileStrings, String m) {
    
    if (!m.equals("Test")) {
      
      // Loads a random line from the full file
      this.fullLine = fileStrings[round( random( fileStrings.length-1 ))]; 
    }
    
    else {
      
      // Loads the first line from the file
      this.fullLine = fileStrings[0]; 
    }
    
    this.fileName = fileStrings;
    this.optionsSplit = this.fullLine.split("#");
    this.mode = m;
  }
  
  
  String getAnswer() {
    
    // Take the second part of the full line
    String answers = optionsSplit[1]; 
    String[] finalOptions = answers.split(", ");
    
    return finalOptions[0];
  }
  
  
  String getQuestion() {
    
    // Take the first part of the full line
    String question = optionsSplit[0]; 
    
    return question;
  }
  
  String nextQuestion(int questionNum, ArrayList<String> selection) {
    
    // The user chose "test" mode
    if (this.mode.equals("Test")) {
      
      // The last question was reached
      if (questionNum == this.fileName.length) {
        checkAnswer();
        return "finished";
      } 
      
      // There are still unasked questions
      else {

        // Loads and seperates the relevant question from the full file
        this.fullLine = this.fileName[questionNum]; 
        this.optionsSplit = this.fullLine.split("#");
        question = this.optionsSplit[0];
        
        return question;
      }
    } 
    
    // User chose the endless mode
    else { 
       
      for (int i = 0; i < selection.size(); i++) {
        
        while (this.fullLine.contains(selection.get(i))) {
          
          // Try again if already present in the list of previous responses
          this.fullLine = this.fileName[round( random( this.fileName.length-1 ))]; 
        }
      }
      
      this.optionsSplit = this.fullLine.split("#");
      question = this.optionsSplit[0];
      
      return question;
    }
  }
  
  // Randomizes the answers
  String[] randomizeSelection() { 
    String selection = optionsSplit[1];
    
    // Splits the answers wherever there is a comma
    String[] selectionLst = selection.split(", "); 
    String[] choices;
    
    choices = Arrays.copyOfRange(selectionLst, 1, 4);
 
    return choices;
  }
}
