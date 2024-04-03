//Oliver Gibbons | March 2024


// TO DO:
// Make buttons out of tower spots; figure out tower class hiearchy; make checks for tower placement;
// make checks for enemy movement (recursive); make enemy movement; display enemy;
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
  round = 0;
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
  imageMode(CENTER);
  if (!play) {
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
  }
  //Start of play------------------------------------------------------
  if (play) {
    m.displayPlayMap();
    infoBar();

    //Temporary enemy.size() != 0; eventually check to see that all towers are placed prior to starting
    // the first round
    if (enemy.size() == 0) {
      round++;
      nextRound(round);
    }
  }

  //Enemy stuffs: Count enemies passing Y
  for (int j = 0; j < enemy.size(); j++) {
    Enemy e = enemy.get(j);
    e.move();
    e.display();
    //Counting
    if (e.passY()) {
      enemy.remove(j);
      enemyCount++;
      health--; //ToDo health -= enemy.y like rocks;
    }
  }
  //Game Over logic
  if (checkGameOver()) {
    m.displayEndMap();
  }
}
void nextRound(int round) {
  int enemyAdd = round * 2;
  for (int i = 0; i < enemyAdd; i ++) {
    enemy.add(new Enemy());
  }
}
boolean checkGameOver() {
  if (enemyCount >= 30) {
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
