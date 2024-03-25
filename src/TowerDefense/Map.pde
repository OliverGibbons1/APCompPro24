class Map {
  int [] [] grid;
  int rows, cols;
  PImage startScreen;

  Map () {
    rows = 10;
    cols = 10;
  }
  void displayMap() {
    startScreen = loadImage("images/bestStartScreen.png");
//    startScreen.resize(640, 640);
  }
  void placeTower(int row, int cols, int towerType) {
  }
  boolean isCellEmpty(int row, int cols) {
    return true;
  }
}
