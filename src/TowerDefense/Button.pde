class Button {
  float x, y, width, height;

  Button(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  void display() {
    rect(x, y, width, height);
  }

  boolean pressed() {
    if (mouseX < x+width && mouseX > x && mouseY < y+height && mouseY > y && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}
