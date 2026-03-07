Image background = new Image();
Image[] object = new Image[6];
Image thanos = new Image();
Image ironMan = new Image();
Image[] lifeT = new Image[3];
Image[] lifeI= new Image[3];
Image openingScreen = new Image();
Image thanosScreen = new Image();
Image ironScreen = new Image();
Image loseScreen = new Image();

Music theme = new Music();
Music missSnd = new Music();
Music catchSnd = new Music();
Music thanosWinSnd = new Music();
Music ironWinSnd = new Music();
Music loseSnd = new Music();

Text sentenceT = new Text();
Text sentenceI = new Text();
Text thanosWinTxt = new Text();
Text ironWinTxt = new Text();
Text loseTxt = new Text();
Text openingSentence = new Text();

int livesT = 3;
int livesI = 3;
int scoreT = 0;
int scoreI = 0;
int isPressed = 0;
int obIdx = int(random(0, 5));
boolean soundPlayed = false;

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

  thanosScreen.setImage("Thanos Screen.jpg");
  thanosScreen.x = 0;
  thanosScreen.y = 0;
  thanosScreen.width = 1024;
  thanosScreen.height = 512;

  ironScreen.setImage("Iron Man Screen.jpg");
  ironScreen.x = 0;
  ironScreen.y = 0;
  ironScreen.width = 1024;
  ironScreen.height = 512;

  loseScreen.setImage("Lose Screen.png");
  loseScreen.x = 0;
  loseScreen.y = 0;
  loseScreen.width = 1024;
  loseScreen.height = 512;

  thanos.setImage("Thanos.png");
  thanos.x = 450;
  thanos.y = 370;
  thanos.width = 191;
  thanos.height = 141;

  ironMan.setImage("Iron Man.png");
  ironMan.x = 450;
  ironMan.y = 370;
  ironMan.width = 191;
  ironMan.height = 141;

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

  int x = 0;
  for (int i = 0; i<lifeT.length; i++) {
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

  theme.load("Theme.mp3");
  theme.loop = true;
  theme.play();
  missSnd.load("Miss Sound.mp3");
  catchSnd.load("Catch Sound.mp3");
  thanosWinSnd.load("Thanos Win.mp3");
  ironWinSnd.load("Iron Win.mp3");
  loseSnd.load("Lose.mp3");

  sentenceT.text = "Score: " + scoreT;
  sentenceT.x = 10;
  sentenceT.y = 60;
  sentenceT.textSize = 30;
  sentenceT.brush = color(#9800FF);

  sentenceI.text = "Score: " + scoreI;
  sentenceI.x = 760;
  sentenceI.y = 60;
  sentenceI.textSize = 30;
  sentenceI.brush = color(255, 0, 0);

  openingSentence.text = "Press Any Key To Start";
  openingSentence.x = 435;
  openingSentence.y = 485;
  openingSentence.textSize = 20;
  openingSentence.brush = color(255, 255, 255);


  thanosWinTxt.text = "PLAYER 1 WINS!";
  thanosWinTxt.x = 290;
  thanosWinTxt.y = 70;
  thanosWinTxt.textSize = 80;
  thanosWinTxt.brush = color(#9800FF);

  ironWinTxt.text = "PLAYER 2 WINS!";
  ironWinTxt.x = 30;
  ironWinTxt.y = 80;
  ironWinTxt.textSize = 80;
  ironWinTxt.brush = color(255, 0, 0);

  loseTxt.text = "GAME OVER!";
  loseTxt.x = 30;
  loseTxt.y = 80;
  loseTxt.textSize = 80;
  loseTxt.brush = color(255, 0, 0);
}

void draw() {
  openingScreen.draw();
  openingSentence.draw();
  if (isPressed == 1) {
    background.draw();
    thanos.draw();
    if ((mouseX > 60) && (mouseX < 954)) {
      ironMan.x = mouseX - 95;
    }
    ironMan.draw();
    object[obIdx].draw();

    for (int i = 0; i<livesT; i++) {
      lifeT[i].draw();
    }
    for (int i = 0; i<livesI; i++) {
      lifeI[i].draw();
    }

    sentenceT.draw();
    sentenceT.text = "Score: " + scoreT;

    sentenceI.draw();
    sentenceI.text = "Score: " + scoreI;

    if (thanos.x <= 0) {
      thanos.speed = 0;
    }
    if (thanos.x >= 820) {
      thanos.speed = 0;
    }
    if (object[obIdx].y > 512) {
      obIdx = int(random(0, 5));
      object[obIdx].y = -50;
      object[obIdx].x = int(random(0, 981));
      missSnd.play();
      livesT--;
      livesI--;
    }
  }
  if (thanos.pointInShape(object[obIdx].x, object[obIdx].y)) {
    obIdx = int(random(0, 5));
    object[obIdx].y = -50;
    object[obIdx].x = int(random(0, 981));
    catchSnd.play();
    scoreT++;
  }

  if (ironMan.pointInShape(object[obIdx].x, object[obIdx].y)) {
    obIdx = int(random(0, 5));
    object[obIdx].y = -50;
    object[obIdx].x = int(random(0, 981));
    catchSnd.play();
    scoreI++;
  }

  if (scoreT == 3) {
    thanosScreen.draw();
    thanosWinTxt.draw();
    object[obIdx].speed = 0;
    if (!soundPlayed) {
      thanosWinSnd.play();
      soundPlayed = true;
    }
  }

  if (livesT == 0) {
    thanos.y = -200;
  }
  if (scoreI == 3) {
    ironScreen.draw();
    ironWinTxt.draw();
    object[obIdx].speed = 0;
    if (!soundPlayed) {
      ironWinSnd.play();
      soundPlayed = true;
    }
  }

  if (livesI == 0) {
    ironMan.y = -200;
  }

  if ((livesT == 0) && (livesI == 0)) {
    loseScreen.draw();
    loseTxt.draw();
    object[obIdx].speed = 0;
    if (!soundPlayed) {
      loseSnd.play();
      soundPlayed = true;
    }
  }
}

void keyPressed() {
  isPressed = 1;
  if (keyCode == RIGHT) {
    thanos.speed = 10;
    thanos.direction = Direction.RIGHT;
  }
  if (keyCode == LEFT) {
    thanos.speed = 10;
    thanos.direction = Direction.LEFT;
  }
  if (keyCode == UP) {
    thanos.speed = 0;
  }
}

void mousePressed() {
  isPressed = 1;
}