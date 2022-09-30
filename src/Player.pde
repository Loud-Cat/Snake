
class Player {
  ArrayList<Cell> body;
  int xspeed, yspeed;

  Player() {
    body = new ArrayList<Cell>();
    body.add( new Cell(1, 1, SNAKE_COLOR) );

    xspeed = 1;
    yspeed = 0;
  }

  void show() {
    for (Cell cell : body)
      cell.show();
  }

  void update() {
    Cell head = body.get(body.size() - 1);
    Cell butt = body.get(0);

    int nc = head.col + xspeed;
    int nr = head.row + yspeed;
    if (contains(nr, nc) || outOfBounds(nr, nc)) {
      gameOver();
      return;
    }

    if (nc == apple.col && nr == apple.row) {
      body.add(0, new Cell(butt.row, butt.col, SNAKE_COLOR));
      updateScore();
      randomize();
    }

    butt.row = nr;
    butt.col = nc;
    body.remove(butt);
    body.add(butt);

    butt.cellColor = DARK_SNAKE;
    head.cellColor = SNAKE_COLOR;
  }

  void xSpeed(int xs) { yspeed = 0; xspeed = xs; }
  void ySpeed(int ys) { xspeed = 0; yspeed = ys; }

  void move(char key) {
    if (key == 'w' && yspeed != 1) ySpeed(-1);
    if (key == 's' && yspeed != -1) ySpeed(1);

    if (key == 'a' && xspeed != 1) xSpeed(-1);
    if (key == 'd' && xspeed != -1) xSpeed(1);
  }

  boolean contains(int r, int c) {
    for (Cell cell : body)
      if (cell.row == r && cell.col == c)
        return true;

    return false;
  }
  
  boolean outOfBounds(int r, int c) {
    return r < 0 || r >= SCALE || c < 0 || c >= SCALE;
  }

  int score() { return body.size(); }

  void reset() {
    body.clear();
    body.add( new Cell(1, 1, SNAKE_COLOR) );
    xSpeed(1);
  }
}
