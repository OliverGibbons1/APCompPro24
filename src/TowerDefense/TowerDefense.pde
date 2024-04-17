//Oliver Gibbons | March 2024

// TO DO:
// No delay() in applySpecial()
// applySpecial() effects (freeze cube, fire animation)
// Make buttons out of tower spots; tower placement; make checks for tower placement;
// make checks for enemy movement (recursive); make enemy movement;
// mostly tower and enemy, map set up
// MAP: finish extra tower spots; make variables in grid [] [] for different towers if needed
// LAST SESSION: debug e.remove and fix freeze method on iceTower

private int money, round, life, enemyCount;
Map m;
Button startButton, quitButton, loadGameButton, clearSaveButton, saveGameButton, nextRound;
JSONObject saveGame;
private boolean savedGame, play, first;
//public static boolean move;
int mapWidth = 640;
int mapHeight = 640;
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
ArrayList<Enemy> eToRemove = new ArrayList<Enemy>();
Tower t;
Timer attackTimer;

private String s = "Start";
private String q = "Quit";
private String l = "Load Game";
private String c = "Clear Save";
private String i = " ";

void setup() {
  m = new Map();
  size(640, 640);
  life = 100;
  round = 0;
  money = 500;
  enemyCount = 0;
  first = true;
  play = false;
  //move = true;

  saveGame = new JSONObject();

  startButton = new Button(mapWidth/6, mapHeight/3.5, 112, 48);
  quitButton = new Button(mapWidth/2, 3*(mapHeight/4) + 20, 140, 60);
  loadGameButton = new Button((mapWidth/6)*5, mapHeight/3.5, 112, 48);
  clearSaveButton = new Button(mapWidth/2, 3*(mapHeight/4) + 100, 40, 40);
  saveGameButton = new Button(((mapWidth/5) * 4) + 20, 32, 128, 32);
  nextRound = new Button(mapHeight / 2, mapWidth / 2, 300, 300);

  t = new IceTower(96, 416);
  attackTimer = new Timer(1000);
}

void draw() {
  //General stuffs
  rectMode(CENTER);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  //Startscreen--------------------------------------------------
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
        life = saveGame.getInt("life");
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

    //Temporary; eventually check to see that all towers are placed prior to starting
    if (enemy.size() == 0) {
      nextRoundHandle();
    }

    //Enemy stuffs: Count enemies passing Y, remove enemy if dead, attack enemy if in range, display
    for (int j = enemy.size() - 1; j >= 0; j--) {
      Enemy e = enemy.get(j);
      e.display();
      e.move();

      // attack if in range and if timer is finished
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

      if (t.tick >= 3) {
        t.applySpecial();
      }
      if (t.fTimer.isStarted() && t.fTimer.isFinished()) {
        e.unFreeze();
      }

      if (!e.l()) {
        println(" removed ");
        money += e.rewardMoney;
        eToRemove.add(e);
      }
      //Counting
      if (e.passX()) {
        println("Pass X");
        enemyCount++;
        life -= enemyCount; //ToDo health -= enemy.y like rocks;
        eToRemove.add(e);
      }

      // Remove marked enemies
      for (Enemy en : eToRemove) {
        enemy.remove(en);
      }
      eToRemove.clear(); // Clear the list for the next frame
    }
    //Game Over logic
    if (checkGameOver()) {
      m.displayEndMap();
      play = false;
    }
  }
}


void nextRoundHandle() {
  nextRound.x = mapWidth / 2; // Centering the button horizontally
  nextRound.y = mapHeight / 2; // Centering the button vertically
  nextRound.width = 300;
  nextRound.height = 300;
  nextRound.display();
  fill(0);
  String nr = "Click for Next Round";
  text(nr, height / 2, width / 2);
  if (nextRound.pressed()) {
    println("New Round");
    nextRound.remove();
    nr = nr.equals(i) ? i:nr;
    round++;
    nextRound(round);
  }
}

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
  saveGame.setInt("life", life);
  saveGame.setInt("money", money);
  saveGame.setInt("round", round);
  saveGame.setBoolean("savedGame", true);
  saveJSONObject(saveGame, "data/new.json");
  exit();
}

void clearSave() {
  savedGame = false;
  saveGame.setInt("health", 0);
  saveGame.setInt("money", 0);
  saveGame.setInt("round", 0);
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
  text("Life: " + life, (width/5) * 3, 32);
  saveGameButton.display();
  fill(200);
  text("Save Game & Quit", ((width/5) * 4) + 20, 32);
  if (saveGameButton.pressed()) {
    saveGame();
  }
}
