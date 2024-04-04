//Oliver Gibbons | March 2024


// TO DO:
// Make buttons out of tower spots; figure out tower class hiearchy; make checks for tower placement;
// make checks for enemy movement (recursive); make enemy movement; display enemy;
// mostly tower and enemy, map set up
// MAP: finish extra tower spots; make variables in grid [] [] for different towers if needed
// LAST SESSION: debug e.remove and fix freeze method on iceTower

int money, round, health, enemyCount;
Map m;
Button startButton, quitButton, loadGameButton, clearSaveButton, saveGameButton, nextRound;
JSONObject saveGame;
boolean savedGame, play, move, first;
int mapWidth = 640;
int mapHeight = 640;
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
Tower t;
Timer attackTimer;

String s = "Start";
String q = "Quit";
String l = "Load Game";
String c = "Clear Save";
String i = " ";

void setup() {
  m = new Map();
  size(640, 640);
  health = 100;
  round = 0;
  money = 500;
  enemyCount = 0;
  first = true;
  play = false;
  move = true;

  saveGame = new JSONObject();

  startButton = new Button(mapWidth/6, mapHeight/3.5, 112, 48);
  quitButton = new Button(mapWidth/2, 3*(mapHeight/4) + 20, 140, 60);
  loadGameButton = new Button((mapWidth/6)*5, mapHeight/3.5, 112, 48);
  clearSaveButton = new Button(mapWidth/2, 3*(mapHeight/4) + 100, 40, 40);
  saveGameButton = new Button(((mapWidth/5) * 4) + 20, 32, 128, 32);
  nextRound = new Button(mapHeight / 2, mapWidth / 2, 300, 300);

  t = new IceTower(96, 416);
  attackTimer = new Timer(2000);
}

void draw() {
  //General stuffs
  rectMode(CENTER);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  if (!play && first) {
    m.displaySSMap();
    noFill();
    stroke(0);
    strokeWeight(2);
    startButton.display();
    quitButton.display();
    loadGameButton.display();
    clearSaveButton.display();
    //Starting buttons

    textSize(22);
    text(s, startButton.x, startButton.y);
    text(q, quitButton.x, quitButton.y);
    text(l, loadGameButton.x, loadGameButton.y);
    textSize(8);
    text(c, clearSaveButton.x, clearSaveButton.y);
    fill(0);

    if (startButton.pressed()) {
      play = true;
      first = false;
      s = s.equals(i) ? i:s;
    }
    if (loadGameButton.pressed()) {
      play = true;
      first = false;
      saveGame = loadJSONObject("data/new.json");
      savedGame = saveGame.getBoolean("savedGame");
      if (savedGame) {
        health = saveGame.getInt("health");
        money = saveGame.getInt("money");
        s = s.equals(i) ? i:s;
      } else {
        s = s.equals(i) ? i:s;
        play = true;
        first = false;
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
    t.display();
    infoBar();
    //Temporary enemy.size() != 0; eventually check to see that all towers are placed prior to starting
    // the first round
    if (enemy.size() == 0) {
      nextRound(1);
      //nextRoundHandle();
    }
    move = true;

    //Enemy stuffs: Count enemies passing Y, remove enemy if dead, attack enemy if in range, display
    for (int j = enemy.size() - 1; j >= 0; j--) {
      Enemy e = enemy.get(j);
      // attack if in range and if timer is finished
      e.display();
      if (move) {
        e.move();
      }
      if (t.inRange(e)) {
        if (!attackTimer.isStarted()) {
          attackTimer.start();
          println("Started");
        } else if (attackTimer.isFinished()) {
          // If attackTimer is finished, reset it and perform attack
          attackTimer.start(); // Reset the timer
          t.attack();
        }
      }

      if (e.getHealth() < 0) { // remove if dead
        print(" removed ");
        enemy.remove(j);
        money += e.rewardMoney;
      }
      //Counting
      if (e.passY()) {
        enemy.remove(j);
        enemyCount++;
        health -= enemyCount; //ToDo health -= enemy.y like rocks;
      }
    }
    //Game Over logic
    if (checkGameOver()) {
      m.displayEndMap();
      play = false;
    }
  }
}


//void nextRoundHandle() {
//  nextRound.display();
//  fill(0);
//  String nr = "Click for Next Round";
//  text(nr, height / 2, width / 2);
//  if (nextRound.pressed()) {
//    nextRound.remove();
//    nr = nr.equals(i) ? i:nr;
//    round++;
//    nextRound(round);
//  }
//}

void nextRound(int round) {
  int enemyAdd = round * 2;
  for (int i = 0; i < enemyAdd; i ++) {
    enemy.add(new Enemy());
  }
}

boolean checkGameOver() {
  return enemyCount >= 30;
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
  text("Round: " + round, width/5, 32);
  text("Gold: " + money, (width/5) * 2, 32);
  text("Health: " + health, (width/5) * 3, 32);
  saveGameButton.display();
  fill(200);
  text("Save Game & Quit", ((width/5) * 4) + 20, 32);
  if (saveGameButton.pressed()) {
    saveGame();
  }
}
