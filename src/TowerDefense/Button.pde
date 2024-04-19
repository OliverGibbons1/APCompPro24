class Button {
  float x, y, width, height;
  boolean removeT;

  Button(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    removeT = false;
  }

  void display() {
    rect(x, y, width, height);
  }

  boolean pressed() {
    return mouseX >= x - width/2 && mouseX <= x + width/2 &&
      mouseY >= y - height/2 && mouseY <= y + height/2 &&
      mousePressed;
  }

  void remove() {
    x = 640;
    y = 640;
    width = 0;
    height = 0;
    removeT = true;
  }

  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  boolean isRemoved() {
    return removeT;
  }
}
