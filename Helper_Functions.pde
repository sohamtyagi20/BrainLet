import java.util.Collections;

void subjectSelected() {
  
  // Geography was selected
  if (subSelected.equals( "Geography" )) {
    easyFile = loadStrings("Geography/Easy.txt");
    moderateFile = loadStrings("Geography/Moderate.txt");
    hardFile = loadStrings("Geography/Hard.txt");   
  } 
  
  // Biology was selected
  else if (subSelected.equals( "Biology" )) {
    easyFile = loadStrings("Biology/Easy.txt");
    moderateFile = loadStrings("Biology/Moderate.txt");
    hardFile = loadStrings("Biology/Hard.txt");
  }
  
  // Create questions based on the file and mode
  easyQ = new Questions(easyFile, mode);
  moderateQ = new Questions(moderateFile, mode);
  hardQ = new Questions(hardFile, mode);
}


void loadQuestions() {

  // Easy mode was chosen
  if (lvl <= 1) { 
    questionSet = easyQ;
  } 

  // Moderate mode was chosen
  else if (lvl == 2) {
    questionSet = moderateQ;
  }

  // Hard mode was chosen
  else if (lvl == 3) {
    questionSet = hardQ;
  }

  // Get questions and split it
  numOfQuestions = questionSet.fileName.length;
  question = questionSet.getQuestion();
  splitQuestion = question.split("");
  
  // Get the answers and randomize the options
  answer = questionSet.getAnswer(); 
  options = questionSet.randomizeSelection(); 
}


void showText() {

  // Answer's y-value
  int yVal = 330;

  // Displays the question on screen
  question = String.join("", splitQuestion);
  text(question, 200, 130, 500, 500);

  // FOR THE ANSWER
  text("Possible Answers:", 200, 300);
  textSize(20); 
  
  // Add the answer to the array
  optionsArray.add(answer);
  
  // Adds all the remaining options to the array
  for (int i = 0; i < options.length; i++) {
    optionsArray.add(options[i]);
  }
  
  // If the difficulty level has not changed, shuffle options and locate the correct answer
  if (!sliderChanged) {
    Collections.shuffle(optionsArray);
    answerLocation = optionsArray.indexOf(answer);
  }
  
  else {
    current = 0;
    // Makes sure that the answers are still shuffled after changing the bar
    sliderChanged = !sliderChanged; 
  }
  
  // Outputs the remaining options
  for (int i = 0; i < optionsArray.size(); i++) {
    textSize(20); 

    // Creates the remaining options
    text(String.valueOf(i + 1) + ". " + optionsArray.get(i), 200, yVal);

    // Set new y-value
    yVal += 20;
  }
  
  // Empty the array
  optionsArray.clear();
}

void nextQuestion() {
  
  question = questionSet.nextQuestion(current, pastQuestions); // Loads the next question of the set
  answer = questionSet.getAnswer(); // Gets the answer
  options = questionSet.randomizeSelection(); // Chooses the 4 options the user can pick
  splitQuestion = question.split(""); // Splits the question into its parts

  // All the questions have been asked
  if (question.equals( "finished")) {
    windowName = "end";
  }
  
  // If endless mode, rotate through the questions
  if (mode.equals("Endless")) {
    pastQuestions = rotateArrayList(pastQuestions, question, randomness);
  }
  
  // Add the displayed question to the array
  pastQuestions.add(question);
}

void checkAnswer() {
  
  // User selected the answer
  if (buttonClicked == answerLocation) { 
    
    // Turns the buttons that aren't the answer red
    checkLocation(); 
    
    // Ensures that the user can't click the answer button multiple times to get a very high score
    if (!answerSelected) {
      correct++;
      answerSelected = true;
    }
    
    attempts = 0;
  }
  
  // Otherwise, increase their number of attempts and color the button red
  else {
    redButton();
    attempts++; 
  }
  
  // If the user has run out of attempts
  if (numOfTries - attempts == 0) {
    checkLocation(); 
    
    answerSelected = true;
    attempts = 0;
  }
}

// Whatever button the user clicks, color it red if it is incorrect
void redButton() {
  
  // Answer 1 was clicked but is incorrect
  if (buttonClicked == 0) {
    answer1.setLocalColorScheme(GCScheme.RED_SCHEME); 
    answer1.setLocalColor(2, color(0) );
  }
  
  // Answer 2 was clicked but is incorrect
  else if (buttonClicked == 1) {
    answer2.setLocalColorScheme(GCScheme.RED_SCHEME); 
    answer2.setLocalColor(2, color(0) );
  }
  
  // Answer 3 was clicked but is incorrect
  else if (buttonClicked == 2) {
    answer3.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer3.setLocalColor(2, color(0) );
  }
  
  // Answer 4 was clicked but is incorrect
  else if (buttonClicked == 3) {
    answer4.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer4.setLocalColor(2, color(0) );
  }
}

// Depending on the answer's location, color the buttons their relevant colours
void checkLocation() {
  
  // Answer was the first option
  if (answerLocation == 0) {
    answer1.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    answer2.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer3.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer4.setLocalColorScheme(GCScheme.RED_SCHEME);
  }
    
  // Answer was the second option
  else if (answerLocation == 1){
    answer1.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer2.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    answer3.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer4.setLocalColorScheme(GCScheme.RED_SCHEME);
  }
  
  // Answer was the third option
  else if (answerLocation == 2) {
    answer1.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer2.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer3.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    answer4.setLocalColorScheme(GCScheme.RED_SCHEME);
 }
 
  // Answer was the fourth option
  else if (answerLocation == 3) {
    answer1.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer2.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer3.setLocalColorScheme(GCScheme.RED_SCHEME);
    answer4.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  }
  
  // For ease of viewing, turn the font color to black
  answer1.setLocalColor(2, color(0) );
  answer2.setLocalColor(2, color(0) );
  answer3.setLocalColor(2, color(0) );
  answer4.setLocalColor(2, color(0) );
}

// Used for endless mode (prevents the same option from appearing too frequently)
ArrayList<String> rotateArrayList(ArrayList<String> arrayLst, String currentQ, int randomLvl) {
  ArrayList<String> newArrayLst = arrayLst;
  String pastValue;
  
  // If the arrayList is not big enough to be rotated yet, the current question will simply be added.
  if (arrayLst.size() < randomLvl) {
    newArrayLst.add(currentQ); 
  } 
  
  // Otherwise, rotate the arrayList
  else {
    for (int i = 0; i < arrayLst.size()-1; i++) {
      
      if (i == 0) {
        
        // Take the desired value to input into the array and remove the element in its place
        pastValue = arrayLst.get(i); 
        
        // Set the new first position as that element
        newArrayLst.set(i, currentQ); 
      } 
      
      else {
        
        // Takes the past value of the input array and add it to the new array
        pastValue = arrayLst.get(i); 
        
        // Put the value where it's required  
        newArrayLst.set(i, pastValue); 
      }
    }
  }
  return newArrayLst;
  
}


// Calculates the score 
int calculatePercent(float correct, float total) {
  return round((correct/total) * 100);
}
