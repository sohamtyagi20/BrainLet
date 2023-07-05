// TITLE: Brainlet //<>//
// DESCRIPTION: A software program that allows users to test their geography/biology knowledge by answering questions
// PROGRAMMERS: Nadia Anwar, Eric Bao, Soham Tyagi
// DATE: May 23, 2023

import g4p_controls.*;  
Questions easyQ, moderateQ, hardQ, questionSet;

String[] easyFile, moderateFile, hardFile; 
String[] splitQuestion;
String[] options; 

String answer, question;
String windowName;
String subSelected; // Selected subject

int randomness = 4; // How "random" the questions are
int numOfTries = 1; // Initial number of tries
int lvl; // Difficulty level
int current = 0; // Current question
int correct = 0; // Number of correct answers
int attempts;
int numOfQuestions;
int answerLocation = 0;
int buttonClicked;

boolean sliderChanged = false;
boolean answerSelected = false;

PImage mainMenu, questionScreen, endingScreen ; 

// CHANGEABLE VALUES
String mode = "Test"; // Possible options: Test, Endless

ArrayList<String> optionsArray = new ArrayList<String>();
ArrayList<String> pastQuestions = new ArrayList<String>();
 //<>//
void setup() { //<>//
  size(800, 500);
  
  // Load background images
  mainMenu = loadImage("background.jpg");
  questionScreen = loadImage("startquiz.jpg");
  endingScreen = loadImage("endingImage.jpg");
  //<>//
  createGUI(); //<>//
  mainMenu(); 
}

void draw() {
  
  // Display the other screens //<>//
  displayScreen();  //<>//
} //<>//
