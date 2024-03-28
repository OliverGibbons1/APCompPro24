class Map {
  int [] [] grid;
  int rows, cols, lastRow, lastCol, tile;
  PImage startScreen, endScreen, playScreen;
  PImage tile0, tile1, tile2;

  Map () {
    startScreen = loadImage("towerImages/startscreen.png");
    endScreen = loadImage("towerImages/endscreen.png");
    tile0 = loadImage("towerImages/CobbleStoneTile.png");
    tile1 = loadImage("towerImages/DirtTile.png");
    tile2 =  loadImage("towerImages/PlanksTile.png");
    //playScreen = loadImage("");
    rows = 10;
    cols = 10;
    grid = new int [10] [10];
    lastRow = grid.length - 1;
    lastCol = grid[0].length - 1;
    for (int r = 0; r <= lastRow; r++) {
      for (int c = 0; c <= lastCol; c++) {
        tile = grid [r] [c];
      }
    }
  }
  void displaySSMap() {
    image(startScreen, 0, 0);
    startScreen.resize(640, 640);
  }
  void displayPlayMap() {
    //image(playScreen, 0, 0);
    //playScreen.resize(640, 640);
    //This is where I will set values to the 2D array; they will indicate if:
    //an enemy can traverse that spot on the map; value of 1
    //a tower can be placed on that portion of the map; value of 2
    //nothing can be placed on that portion of the map; value of 0

    //Set all starting positions to 0 (clear slate)
    for (int r = 0; r <= lastRow; r++) {
      for (int c = 0; c <= lastCol; c++) {
        grid [r] [c] = 0;
      }
    }
    //Set spots for towers - five for the first x rounds, then unlock more later with gold
    grid [6] [1] = 2;
    grid [1] [3] = 2;
    grid [4] [4] = 2;
    grid [7] [6] = 2;
    grid [4] [7] = 2;
    //other tower positions to unlock here

    //Places where enemies can traverse
    //See paper for key
    //1
    for (int r = 7; r <= 8; r++) {
      for (int c = 0; c <= 3; c++) {
        grid [r] [c] = 1;
      }
    }
    //2
    for (int r = 2; r <= 3; r++) {
      for (int c = 2; c <= 6; c++) {
        grid [r] [c] = 1;
      }
    }
    //3
    for (int r = 5; r <= 6; r++) {
      for (int c = 5; c <= 8; c++) {
        grid [r] [c] = 1;
      }
    }
    //SQ #1
    for (int r = 4; r <= 5; r++) {
      for (int c = 2; c <= 3; c++) {
        grid [r] [c] = 1;
      }
    }
    //SQ #2
    for (int r = 7; r <= 8; r++) {
      for (int c = 7; c <= 8; c++) {
        grid [r] [c] = 1;
      }
    }
    //OS #1
    grid [6] [2] = 1;
    grid [6] [3] = 1;
    //OS #2
    grid [1] [4] = 1;
    grid [1] [5] = 1;
    grid [1] [6] = 1;
    //OS #3
    grid [4] [5] = 1;
    grid [4] [6] = 1;
    //OS #4
    grid [9] [7] = 1;
    grid [9] [8] = 1;

    //Print check - used for testing only
    //for (int r = 0; r <= lastRow; r++) {
    //  for (int c = 0; c <= lastCol; c++) {
    //    if (grid[r][c] == 0) {
    //      System.out.print("0"); // (nothing can be placed)
    //    } else if (grid[r][c] == 1) {
    //      System.out.print("1"); // (where enemies can traverse)
    //    } else if (grid[r][c] == 2) {
    //      System.out.print("2"); // (where towers can be placed)
    //    }
    //  }
    //  System.out.println(); // Move to the next row
    //}

    //Map display
    for (int r = 0; r <= lastRow; r++) {
      for (int c = 0; c <= lastCol; c++) {
        // Check the value of each cell and print the corresponding symbol
        if (grid[r][c] == 0) {
          image(tile0, c * 64, r * 64);
          tile0.resize(64, 64);
        } else if (grid[r][c] == 1) {
          image(tile1, c * 64, r * 64);
          tile1.resize(64, 64);
        } else if (grid[r][c] == 2) {
          image(tile2, c * 64, r * 64);
          tile2.resize(64, 64);
        }
      }
    }
  }
  void displayEndMap() {
    image(endScreen, 0, 0);
    endScreen.resize(640, 640);
  }
  void placeTower(int tile, String towerType) {
    if (tile == 0) {
    } else if (tile == 1) {
    } else if (tile == 2) {
    }
  }
  boolean canPlaceTower(int row, int cols) {
    return true;
  }
}
