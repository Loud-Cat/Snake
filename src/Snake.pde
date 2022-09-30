
int DELAY = 10;
int SCALE = 10;
int w, h;

Cell apple;
Player player;
ArrayList<Character> queue = new ArrayList<>();

color SNAKE_COLOR = color(0, 175, 0);
color DARK_SNAKE = color(0, 150, 0);
color APPLE_COLOR = color(225, 0, 0);

boolean playing = false;
boolean gameover = false;
boolean paused = false;

void setup() {
  size(802, 802);
  surface.setTitle("Snake!");
  surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2 - 20);

  frameRate(30);
  textSize(50);
  textAlign(CENTER, CENTER);

  w = width / SCALE;
  h = height / SCALE;

  apple = new Cell(5, 5, APPLE_COLOR);
  player = new Player();
}

void draw() {
  background(50);

  noFill();
  stroke(100);

  for (int r = 0; r < SCALE; r++)
    for (int c = 0; c < SCALE; c++)
      rect(w*c, h*r, w, h);

  apple.show();
  player.show();

  if (paused) pause();
  if (!focused && frameCount > 1) pause();

  if (player.score() == SCALE * SCALE) {
    win();
    return;
  }

  if (frameCount % DELAY == 0) {
    if (queue.size() > 0)
      player.move( queue.remove(0) );

    player.update();
  }
  
  if (!playing) {
    startScreen();
    return;
  }
}

void randomize() {
  int r = -1, c = -1;
  if (player.score() == SCALE * SCALE) return;

  do {
    r = floor( random(0, SCALE) );
    c = floor( random(0, SCALE) );
  } while ( player.contains(r, c) || (r == apple.row && c == apple.col));

  apple.row = r;
  apple.col = c;
}


void freeze() {
  noLoop();

  fill(255, 128);
  rect(0, 0, width, height);

  fill(0);
}

void pause() {
  freeze();
  text("Paused", width/2, h * 1.5);
  text("Press space to unpause", width/2, h * 2.5);
}

void startScreen() {
  freeze();

  text("SNAKE!", width/2, h * 1.5);
  text("Click to start", width/2, h * 2.5);
  text("Use WASD to play", width/2, h * 3.5);
  text("Use space to pause/unpause", width/2, h * 4.5);
}

void gameOver() {
  freeze();

  gameover = true;
  text("Game Over!", width/2, h * 1.5);
  text("Score: " + player.score(), width/2, h * 2.5);
  text("Click to play again", width/2, h * 3.5);
}

void win() {
  freeze();

  text("You Win!", width/2, h * 1.5);
  text("Score: " + player.score(), width/2, h * 2.5);
}

void reset() {
  loop();

  playing = true;
  gameover = false;
  paused = false;

  player.reset();
  queue.clear();

  randomize();
  updateScore();
}

void updateScore() {
  player.highscore = max(player.highscore, player.score());
  String title = String.format("Snake! | Score: %d | High Score: %d", player.score(), player.highscore);
  surface.setTitle(title);
}

void keyPressed() {
  if ("wasd".indexOf(key) != -1 && !queue.contains(key))
    queue.add(key);

  if (keyCode == 32) {
    if (paused) loop();
    paused = !paused;
  }
}

void mouseClicked() {
  if (gameover || !playing)
    reset();
}
