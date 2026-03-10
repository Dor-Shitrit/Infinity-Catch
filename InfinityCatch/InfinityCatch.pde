//
//  Infinity Catch
//
//  Created by Dor Shitrit.
//

// Image declaration
Image background = new Image();
Image[] stone = new Image[3];  // now using 3 stones for falling objects
Image thanos = new Image();
Image ironMan = new Image();
Image[] lifeT = new Image[3];
Image[] lifeI = new Image[3];
Image openingScreen = new Image();
Image thanosScreen = new Image();
Image ironScreen = new Image();
Image loseScreen = new Image();

// Music declaration
Music theme = new Music();
Music missSnd = new Music();
Music catchSnd = new Music();
Music thanosWinSnd = new Music();
Music ironWinSnd = new Music();
Music loseSnd = new Music();

// Text declaration
Text sentenceT = new Text();
Text sentenceI = new Text();
Text thanosWinTxt = new Text();
Text ironWinTxt = new Text();
Text loseTxt = new Text();
Text openingSentence = new Text();

// Global variables
int livesT = 3;
int livesI = 3;
int scoreT = 0;
int scoreI = 0;
int isPressed = 0;
boolean soundPlayed = false;
int numStones = 3; // number of stones falling concurrently

void setup() {
  size(1024, 512);

  // Background setup
  background.setImage("Background.png");
  background.x = 0;
  background.y = 0;
  background.width = 1024;
  background.height = 512;

  // Opening screen setup
  openingScreen.setImage("Opening Screen.png");
  openingScreen.x = 0;
  openingScreen.y = 0;
  openingScreen.width = 1024;
  openingScreen.height = 512;

  // Thanos win screen setup
  thanosScreen.setImage("Thanos Screen.jpg");
  thanosScreen.x = 0;
  thanosScreen.y = 0;
  thanosScreen.width = 1024;
  thanosScreen.height = 512;

  // Ironman win screen setup
  ironScreen.setImage("Iron Man Screen.jpg");
  ironScreen.x = 0;
  ironScreen.y = 0;
  ironScreen.width = 1024;
  ironScreen.height = 512;

  // Lose screen setup
  loseScreen.setImage("Lose Screen.png");
  loseScreen.x = 0;
  loseScreen.y = 0;
  loseScreen.width = 1024;
  loseScreen.height = 512;

  // Thanos setup
  thanos.setImage("Thanos.png");
  thanos.x = 450;
  thanos.y = 370;
  thanos.width = 191;
  thanos.height = 141;

  // Ironman setup
  ironMan.setImage("Iron Man.png");
  ironMan.x = 450;
  ironMan.y = 370;
  ironMan.width = 191;
  ironMan.height = 141;

  // Falling stones setup - 3 stones falling concurrently with vertical gaps
  for (int i = 0; i < numStones; i++) {
    stone[i] = new Image();
    // Choose a random object image from 1 to 6
    stone[i].setImage("object " + (int(random(0, 6)) + 1) + ".png");
    stone[i].x = int(random(0, 981));
    stone[i].y = -50 - i * 100;  // each stone starts 100 pixels apart
    stone[i].width = 43;
    stone[i].height = 57;
    stone[i].direction = Direction.DOWN;
    stone[i].speed = 7;
  }
  
  // Life setup
  int x = 0; // Distance between each life
  for (int i = 0; i < lifeT.length; i++) {
    lifeT[i] = new Image();
    lifeT[i].setImage("Thanos Life.png");
    lifeT[i].x = 170 + x;
    lifeT[i].y = 20;
    lifeT[i].width = 30;
    lifeT[i].height = 57;

    lifeI[i] = new Image();
    lifeI[i].setImage("Iron Life.png");
    lifeI[i].x = 900 + x;
    lifeI[i].y = 20;
    lifeI[i].width = 50;
    lifeI[i].height = 57;

    x += 35;
  }

  // Theme music setup
  theme.load("Theme.mp3");
  theme.loop = true;
  theme.play();
  missSnd.load("Miss Sound.mp3");
  catchSnd.load("Catch Sound.mp3");
  thanosWinSnd.load("Thanos Win.mp3");
  ironWinSnd.load("Iron Win.mp3");
  loseSnd.load("Lose.mp3");

  // Thanos score setup
  sentenceT.text = "Score: " + scoreT;
  sentenceT.x = 10;
  sentenceT.y = 60;
  sentenceT.textSize = 30;
  sentenceT.brush = color(#9800FF);

  // Ironman score setup
  sentenceI.text = "Score: " + scoreI;
  sentenceI.x = 760;
  sentenceI.y = 60;
  sentenceI.textSize = 30;
  sentenceI.brush = color(255, 0, 0);

  // Start sentence setup
  openingSentence.text = "Press Any Key To Start";
  openingSentence.x = 435;
  openingSentence.y = 485;
  openingSentence.textSize = 20;
  openingSentence.brush = color(255, 255, 255);

  // Thanos wins sentence
  thanosWinTxt.text = "PLAYER 1 WINS!";
  thanosWinTxt.x = 290;
  thanosWinTxt.y = 70;
  thanosWinTxt.textSize = 80;
  thanosWinTxt.brush = color(#9800FF);

  // Ironman wins sentence
  ironWinTxt.text = "PLAYER 2 WINS!";
  ironWinTxt.x = 30;
  ironWinTxt.y = 80;
  ironWinTxt.textSize = 80;
  ironWinTxt.brush = color(255, 0, 0);

  // Lose sentence
  loseTxt.text = "GAME OVER!";
  loseTxt.x = 30;
  loseTxt.y = 80;
  loseTxt.textSize = 80;
  loseTxt.brush = color(255, 0, 0);
}

void draw() {
  openingScreen.draw();
  openingSentence.draw();
  
  if (isPressed == 1) { // Start game
    background.draw();
    thanos.draw();
    if ((mouseX > 60) && (mouseX < 954)) { // Center Ironman to mouse and keep within boundaries
      ironMan.x = mouseX - 95;
    }
    ironMan.draw();
    
    // Process each falling stone
    for (int i = 0; i < numStones; i++) {
      stone[i].draw();
      
      // Check for miss (stone falls below the screen)
      if (stone[i].y > 512) {
        resetStone(i);
        missSnd.play();
        livesT--;
        livesI--;
      }
      
      // Check if Thanos catches the stone
      if (thanos.pointInShape(stone[i].x, stone[i].y)) {
        resetStone(i);
        catchSnd.play();
        scoreT++;
      }
      
      // Check if Ironman catches the stone
      if (ironMan.pointInShape(stone[i].x, stone[i].y)) {
        resetStone(i);
        catchSnd.play();
        scoreI++;
      }
    }

    // Draw lives counters
    for (int i = 0; i < livesT; i++) {
      lifeT[i].draw();
    }
    for (int i = 0; i < livesI; i++) {
      lifeI[i].draw();
    }

    // Update and draw scores
    sentenceT.text = "Score: " + scoreT;
    sentenceT.draw();
    sentenceI.text = "Score: " + scoreI;
    sentenceI.draw();

    // Thanos boundaries check (if he reaches screen edges)
    if (thanos.x <= 0 || thanos.x >= 820) {
      thanos.speed = 0;
    }
  }
  
  // Win and lose conditions
  if (scoreT == 10) {
    thanosScreen.draw();
    thanosWinTxt.draw();
    for (int i = 0; i < numStones; i++) {
      stone[i].speed = 0;
    }
    if (!soundPlayed) {
      theme.stop();
      thanosWinSnd.play();
      soundPlayed = true;
    }
  }
  
  if (scoreI == 10) {
    ironScreen.draw();
    ironWinTxt.draw();
    for (int i = 0; i < numStones; i++) {
      stone[i].speed = 0;
    }
    if (!soundPlayed) {
      theme.stop();
      ironWinSnd.play();
      soundPlayed = true;
    }
  }
  
  if (livesT <= 0) {
    thanos.y = -200;
  }
  
  if (livesI <= 0) {
    ironMan.y = -200;
  }
  
  if ((livesT <= 0) && (livesI <= 0)) {
    loseScreen.draw();
    loseTxt.draw();
    for (int i = 0; i < numStones; i++) {
      stone[i].speed = 0;
    }
    if (!soundPlayed) {
      theme.stop();
      loseSnd.play();
      soundPlayed = true;
    }
  }
}

// Thanos movement
void keyPressed() {
  isPressed = 1;
  if (keyCode == RIGHT) {
    thanos.speed = 15;
    thanos.direction = Direction.RIGHT;
  }
  if (keyCode == LEFT) {
    thanos.speed = 15;
    thanos.direction = Direction.LEFT;
  }
  if (keyCode == UP) {
    thanos.speed = 0;
  }
}

// Start game on mouse press
void mousePressed() {
  isPressed = 1;
}

// Reset stone with index idx, placing it above the highest falling stone to maintain a gap
void resetStone(int idx) {
  stone[idx].setImage("object " + (int(random(0, 6)) + 1) + ".png");
  stone[idx].x = int(random(0, 981));

  int minY = 512; // start with a value at the bottom of the screen
  for (int j = 0; j < numStones; j++) {
    if (j != idx && stone[j].y < minY) {
      minY = stone[j].y;
    }
  }
  
  // Ensure the stone reappears off-screen at y = -50 or above, with a gap of 100 if possible
  if (minY < -50) {
    stone[idx].y = minY - 100;
  } else {
    stone[idx].y = -50;
  }
}