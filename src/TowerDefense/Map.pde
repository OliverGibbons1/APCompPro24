class Map {
  int [] [] grid;
  int rows, cols;
  PImage startScreen;

  Map () {
    startScreen = loadImage("towerImages/startscreen.png");
    rows = 10;
    cols = 10;
  }
  void displayMap() {
    image(startScreen, 0, 0);
    startScreen.resize(640, 640);
  }
  void placeTower(int row, int cols, int towerType) {
  }
  boolean isCellEmpty(int row, int cols) {
    return true;
  }
}
