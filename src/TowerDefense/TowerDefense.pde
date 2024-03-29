//Oliver Gibbons | March 2024


// TO DO:
// Make buttons out of tower spots; figure out tower class hiearchy; make checks for tower placement;
// EMENY: make checks for enemy movement (recursive); make enemy movement; display enemy; 
//ENEMY/TOWER: enemy/tower interaction (health, remove);
// mostly tower and enemy, map set up
// MAP: finish extra tower spots; make variables in grid [] [] for different towers if needed
// MAIN: floating box that displays player stats at grid [0] [c]; money, round, health, saveGame button?


int money, round, health, enemyCount;
Map m;
Button startButton, quitButton, loadGameButton, clearSaveButton;
JSONObject saveGame;
boolean savedGame, play;
int mapWidth = 640;
int mapHeight = 640;
ArrayList<Enemy> enemy = new ArrayList<Enemy>();

void setup() {
  m = new Map();
  size(640, 640);
  health = 100;
  round = 1;
  money = 500;
  enemyCount = 0;
  play = false;

  saveGame = new JSONObject();

  startButton = new Button(mapWidth/6, mapHeight/3.5, 112, 48);
  quitButton = new Button(mapWidth/2, 3*(mapHeight/4) + 20, 140, 60);
  loadGameButton = new Button((mapWidth/6)*5, mapHeight/3.5, 112, 48);
  clearSaveButton = new Button(mapWidth/2, 3*(mapHeight/4) + 100, 40, 40);
}

void draw() {
  //General stuffs
  rectMode(CENTER);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  m.displaySSMap();
  noFill();
  stroke(0);
  strokeWeight(2);
  startButton.display();
  quitButton.display();
  loadGameButton.display();
  clearSaveButton.display();

  //Starting buttons
  String s = "Start";
  String q = "Quit";
  String l = "Load Game";
  String c = "Clear Save";
  String i = " ";
  textSize(22);
  text(s, startButton.x, startButton.y);
  text(q, quitButton.x, quitButton.y);
  text(l, loadGameButton.x, loadGameButton.y);
  textSize(8);
  text(c, clearSaveButton.x, clearSaveButton.y);
  fill(0);

  if (startButton.pressed()) {
    play = true;
    s = s.equals(i) ? i:s;
  }
  if (loadGameButton.pressed()) {
    play = true;
    saveGame = loadJSONObject("data/new.json");
    savedGame = saveGame.getBoolean("savedGame");
    if (savedGame) {
      health = saveGame.getInt("health");
      money = saveGame.getInt("money");
      s = s.equals(i) ? i:s;
    } else {
      s = s.equals(i) ? i:s;
      play = true;
    }
  }
  if (quitButton.pressed()) {
    exit();
  }
  if (clearSaveButton.pressed()) {
    clearSave();
  }

  //gameOver check
  if (checkGameOver()) {
    m.displayEndMap();
  }

  //Start of play
  if (play) {
    m.displayPlayMap();
    infoBar();
    //Count enemies passing x and remove them
    for (int j = 0; j < enemy.size(); j++) {
      Enemy e = enemy.get(j);
      if (e.passX()) {
        enemy.remove(j);
        enemyCount++;
        health--;
      }
      if (enemy.size() == 0) {
        round ++;
        nextRound(round);
      }
    }
    //Levels and how to add enemies
  }
}
void nextRound(int round) {
  round *= 2;
  for (int i = 0; i < round; i ++) {
    enemy.add(new Enemy());
  }
}
boolean checkGameOver() {
  if (enemyCount == 30) {
    return true;
  } else {
    return false;
  }
}
void saveGame() {
  savedGame = true;
  saveGame.setInt("health", health);
  saveGame.setInt("money", money);
  saveGame.setBoolean("savedGame", true);
  saveJSONObject(saveGame, "data/new.json");
  exit();
}
void clearSave() {
  savedGame = false;
  saveGame.setInt("health", 0);
  saveGame.setInt("money", 0);
  saveGame.setBoolean("savedGame", false);
  saveJSONObject(saveGame, "data/new.json");
}
void infoBar() {
  rectMode(CENTER);
  fill(150, 150);
  rect(width/2, 32, 600, 50);
  textSize(15);
  fill(0);
  text("Round: " + round, width/4, 32);
  text("Gold: " + money, width/2, 32);
  text("Health: " + health, (width/4) + (width/2), 32);
}
