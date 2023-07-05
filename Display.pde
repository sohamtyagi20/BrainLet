void mainMenu() {

  // Set the window name to "start" and hide GUI window
  windowName = "start";
  window1.setVisible(false);
  start.setVisible(true);
  subjectSelection.setVisible(true);
}


void displayScreen() {

  // Displays the starting screen
  if (windowName.equals("start")) {

    // Text formatting
    fill(255);
    textSize(50);
    textAlign(CENTER);

    // Image formatting 
    mainMenu.resize(800, 500);
    background(mainMenu);
    
    text("Welcome to Brainlet", width/2, 225);
  }

  // Start button was clicked
  else if (windowName.equals("play")) {
    
    // Hide the "restart" button
     //restart.setVisible(false);

    // Text formatting
    textSize(20);
    textAlign(LEFT);

    // Image formatting
    questionScreen.resize(800, 500);
    background(questionScreen);
   
    loadQuestions();
    showText();
    noLoop();
  } 

  // Ending screen
  else if (windowName.equals("end")) {
      
    // Text formatting
    textSize(50);
    textAlign(CENTER);

    float percent = calculatePercent(correct, numOfQuestions);
    
    // Image formatting
    endingScreen.resize(800, 500);
    background(endingScreen);

   text("You have reached the end", width/2, 250);
    
    textSize(25);
    text("Your score: " + String.valueOf(percent) + "%", width/2, 300); 
  }
}
