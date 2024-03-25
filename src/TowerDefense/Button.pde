class Button {
  int x, y, w, h;

  Button(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean pressed() {
    if (mouseX < x+w && mouseX > x && mouseY < y+h && mouseY > y && mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    rect(x, y, w, h);
  }
}
