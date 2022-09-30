
class Cell {
  int row, col;
  color cellColor;
  
  Cell(int r, int c) {
    row = r;
    col = c;
    cellColor = color(50);
  }
  
  Cell(int r, int c, color cc) {
    row = r;
    col = c;
    cellColor = cc;
  }
  
  void show() {
    fill(cellColor);
    rect(w * col, h * row, w, h);
  }
}
