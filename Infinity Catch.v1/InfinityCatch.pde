Image background = new Image();
Image object1 = new Image();
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
    
    object1.setImage("object 1.png");
    object1.x = int(random(0,981));
    object1.y = -50;
    object1.width = 43;
    object1.height = 57;
    object1.direction = Direction.DOWN;
    object1.speed = 5;
    
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
    sentence.brush = color(255,0,0);
    
    openingSentence.text = "Press Any Key To Start";
    openingSentence.x = 435;
    openingSentence.y = 485;
    openingSentence.textSize = 20;
    openingSentence.brush = color(255,255,255);
    
    
    win.text = "YOU WIN!";
    win.x = 300;
    win.y = 120;
    win.textSize = 80;
    win.brush = color(255,0,0);
    
    lose.text = "GAME OVER!";
    lose.x = 50;
    lose.y = 80;
    lose.textSize = 80;
    lose.brush = color(255,0,0);
}

void draw() {
  openingScreen.draw();
  openingSentence.draw();
  if (isPressed == 1){
    background.draw();
    catcher.draw();
    object1.draw();
    if (lives == 3){
    life1.draw();
    life2.draw();
    life3.draw();
    } else if (lives == 2){
    life1.draw();
    life2.draw();
    } else if (lives == 1){
    life1.draw();
    }
    sentence.draw();
    
    sentence.text = "Score: " + score;
    
    if(catcher.x <= 0){
    catcher.speed = 0;
  }
    if(catcher.x >= 820){
    catcher.speed = 0;
  }
    if(object1.y > 512){
    object1.y = -50;
    object1.x = int(random(0,981));
    missSound.play();
    lives--;
    }
  }
    if(catcher.pointInShape(object1.x,object1.y)){
    object1.y = -50;
    object1.x = int(random(0,981));
    catchSound.play();
    score++;
  }
  
  if(score == 10){
    winScreen.draw();
    win.draw();
    object1.speed = 0;
  }
  
  if(lives == 0){
    loseScreen.draw();
    lose.draw();
    object1.speed = 0;
  }
}

void keyPressed() {
  isPressed = 1;
  if(keyCode == RIGHT){
    catcher.speed = 10;
    catcher.direction = Direction.RIGHT;
  }
    if(keyCode == LEFT){
    catcher.speed = 10;
    catcher.direction = Direction.LEFT;
  }
    if(keyCode == UP){
    catcher.speed = 0;
  }

}
  
