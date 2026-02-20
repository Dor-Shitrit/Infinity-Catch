Image background = new Image();
Image[] object = new Image[6];
Image catcher = new Image();
Image life1 = new Image();
Image life2 = new Image();
Image life3 = new Image();
Image openingScreen = new Image();
Image winScreen = new Image();
Image loseScreen = new Image();

Music theme = new Music();
Music missSound = new Music();
Music catchSound = new Music();

Text sentence = new Text();
Text win = new Text();
Text lose = new Text();
Text openingSentence = new Text();

int lives = 3;
int score = 0;
int isPressed = 0;
int obIdx = 0;

void setup() {
  size(1024, 512);

  background.setImage("Background.png");
  background.x = 0;
  background.y = 0;
  background.width = 1024;
  background.height = 512;

  openingScreen.setImage("Opening Screen.png");
  openingScreen.x = 0;
  openingScreen.y = 0;
  openingScreen.width = 1024;
  openingScreen.height = 512;

  winScreen.setImage("Win Screen.jpg");
  winScreen.x = 0;
  winScreen.y = 0;
  winScreen.width = 1024;
  winScreen.height = 512;

  loseScreen.setImage("Lose Screen.jpg");
  loseScreen.x = 0;
  loseScreen.y = 0;
  loseScreen.width = 1024;
  loseScreen.height = 512;

  catcher.setImage("Catcher.png");
  catcher.x = 450;
  catcher.y = 370;
  catcher.width = 191;
  catcher.height = 141;

  for (int i = 0; i<object.length; i++) {
    object[i] = new Image();
    object[i].setImage("object " + (i + 1) + ".png");
    object[i].x = int(random(0, 981));
    object[i].y = -50;
    object[i].width = 43;
    object[i].height = 57;
    object[i].direction = Direction.DOWN;
    object[i].speed = 5;
  }
  /*
   object[0].setImage("object 1.png");
   //object[0].x = 512;
   object[0].x = int(random(0,981));
   object[0].y = -50;
   object[0].width = 43;
   object[0].height = 57;
   object[0].direction = Direction.DOWN;
   object[0].speed = 5;
   
   object[1].setImage("object 2.png");
   //object[0].x = 512;
   object[1].x = int(random(0,981));
   object[1].y = -50;
   object[1].width = 43;
   object[1].height = 57;
   object[1].direction = Direction.DOWN;
   object[1].speed = 5;
   
   object[2].setImage("object 3.png");
   //object[0].x = 512;
   object[2].x = int(random(0,981));
   object[2].y = -50;
   object[2].width = 43;
   object[2].height = 57;
   object[2].direction = Direction.DOWN;
   object[2].speed = 5;
   
   object[3].setImage("object 4.png");
   //object[0].x = 512;
   object[3].x = int(random(0,981));
   object[3].y = -50;
   object[3].width = 43;
   object[3].height = 57;
   object[3].direction = Direction.DOWN;
   object[3].speed = 5;
   
   object[4].setImage("object 5.png");
   //object[0].x = 512;
   object[4].x = int(random(0,981));
   object[4].y = -50;
   object[4].width = 43;
   object[4].height = 57;
   object[4].direction = Direction.DOWN;
   object[4].speed = 5;
   
   object[5].setImage("object 6.png");
   //object[0].x = 512;
   object[5].x = int(random(0,981));
   object[5].y = -50;
   object[5].width = 43;
   object[5].height = 57;
   object[5].direction = Direction.DOWN;
   object[5].speed = 5;
   */

  life1.setImage("Lives.png");
  life1.x = 170;
  life1.y = 20;
  life1.width = 30;
  life1.height = 57;

  life2.setImage("Lives.png");
  life2.x = 200;
  life2.y = 20;
  life2.width = 30;
  life2.height = 57;

  life3.setImage("Lives.png");
  life3.x = 230;
  life3.y = 20;
  life3.width = 30;
  life3.height = 57;

  theme.load("Theme.mp3");
  theme.loop = true;
  theme.play();
  missSound.load("Miss Sound.mp3");
  catchSound.load("Catch Sound.mp3");

  sentence.text = "Score: " + score;
  sentence.x = 10;
  sentence.y = 60;
  sentence.textSize = 30;
  sentence.brush = color(255, 0, 0);

  openingSentence.text = "Press Any Key To Start";
  openingSentence.x = 435;
  openingSentence.y = 485;
  openingSentence.textSize = 20;
  openingSentence.brush = color(255, 255, 255);


  win.text = "YOU WIN!";
  win.x = 300;
  win.y = 120;
  win.textSize = 80;
  win.brush = color(255, 0, 0);

  lose.text = "GAME OVER!";
  lose.x = 50;
  lose.y = 80;
  lose.textSize = 80;
  lose.brush = color(255, 0, 0);
}

void draw() {
  openingScreen.draw();
  openingSentence.draw();
  if (isPressed == 1) {
    background.draw();
    catcher.draw();
    object[obIdx].draw();
    if (lives == 3) {
      life1.draw();
      life2.draw();
      life3.draw();
    } else if (lives == 2) {
      life1.draw();
      life2.draw();
    } else if (lives == 1) {
      life1.draw();
    }
    sentence.draw();

    sentence.text = "Score: " + score;

    if (catcher.x <= 0) {
      catcher.speed = 0;
    }
    if (catcher.x >= 820) {
      catcher.speed = 0;
    }
    if (object[obIdx].y > 512) {
      obIdx = int(random(0, 5));
      object[obIdx].y = -50;
      object[obIdx].x = int(random(0, 981));
      missSound.play();
      lives--;
    }
  }
  if (catcher.pointInShape(object[obIdx].x, object[obIdx].y)) {
    obIdx = int(random(0, 5));
    object[obIdx].y = -50;
    object[obIdx].x = int(random(0, 981));
    catchSound.play();
    score++;
  }

  if (score == 10) {
    winScreen.draw();
    win.draw();
    object[obIdx].speed = 0;
  }

  if (lives == 0) {
    loseScreen.draw();
    lose.draw();
    object[obIdx].speed = 0;
  }
}

void keyPressed() {
  isPressed = 1;
  if (keyCode == RIGHT) {
    catcher.speed = 10;
    catcher.direction = Direction.RIGHT;
  }
  if (keyCode == LEFT) {
    catcher.speed = 10;
    catcher.direction = Direction.LEFT;
  }
  if (keyCode == UP) {
    catcher.speed = 0;
  }
}
