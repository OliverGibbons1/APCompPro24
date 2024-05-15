//Oliver Gibbons | March 2024

// TO DO:
// Order for special attacks (not a problem when the towers get spaced out and less range?)
// make checks for enemy movement (recursive); make enemy movement;
// MAP: finish extra tower spots; make variables in grid [] [] for different towers if needed
// Map: extra/unused spots open up when more money is aquired?
// Once finished, extract attack() into tower class (take out print checks)
// SaveGame logic for saving towers?

// Start screen message: description of each tower's special, descriptrion of enemy and levels. 
//   Icetower will only work if no other special effect is invoked (burn != ice, mage != ice)
//   Carful of overdraft fee
//   Price of towers, range of towers, maybe extra screen for tower desc in infobar?

private int money, round, life, enemyCount;
Map m;
Button startButton, quitButton, loadGameButton, clearSaveButton, saveGameButton, nextRound;
JSONObject saveGame;
private boolean savedGame, play, first;
int mapWidth = 640;
int mapHeight = 640;
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
ArrayList<Enemy> eToRemove = new ArrayList<Enemy>();
ArrayList<Tower> towers = new ArrayList<Tower>(); // Changed name to 'towers'
Timer attackTimer;
Select select;

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


  saveGame = new JSONObject();

  // Start button initialization
  startButton = new Button(mapWidth/6, mapHeight/3.5, 112, 48);
  quitButton = new Button(mapWidth/2, 3*(mapHeight/4) + 20, 140, 60);
  loadGameButton = new Button((mapWidth/6)*5, mapHeight/3.5, 112, 48);
  clearSaveButton = new Button(mapWidth/2, 3*(mapHeight/4) + 100, 40, 40);
  saveGameButton = new Button(((mapWidth/5) * 4) + 20, 32, 128, 32);
  nextRound = new Button(mapHeight / 2, mapWidth / 2, 300, 300);

  attackTimer = new Timer(1000);

  select = new Select();
}

void draw() {
  // General setup
  rectMode(CENTER);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);

  // Start screen
  if (!play && first) {
    displayStartScreen();
  }

  // Play mode
  if (play) {
    m.displayPlayMap();
    infoBar();
    handleTowersAndEnemies();
  }

  // Check for next round
  if (enemy.isEmpty() && select.over()) {
    nextRoundHandle();
  }

  // Game over logic
  if (checkGameOver()) {
    m.displayEndMap();
    play = false;
  }
}

void displayStartScreen() {
  // Display start screen elements
  m.displaySSMap();
  noFill();
  stroke(0);
  strokeWeight(2);
  startButton.display();
  quitButton.display();
  loadGameButton.display();
  clearSaveButton.display();

  // Display start screen text
  textSize(22);
  text(s, startButton.x, startButton.y);
  text(q, quitButton.x, quitButton.y);
  text(l, loadGameButton.x, loadGameButton.y);
  textSize(8);
  text(c, clearSaveButton.x, clearSaveButton.y);
  fill(0);

  // Check for button presses
  if (startButton.pressed()) {
    play = true;
    first = false;
  }
  if (loadGameButton.pressed()) {
    play = true;
    first = false;
    saveGame = loadJSONObject("data/new.json");
    savedGame = saveGame.getBoolean("savedGame");
    if (savedGame) {
      life = saveGame.getInt("life");
      money = saveGame.getInt("money");
    }
  }
  if (quitButton.pressed()) {
    exit();
  }
  if (clearSaveButton.pressed()) {
    clearSave();
  }
}

void handleTowersAndEnemies() {
  select.display();
  select.finalSelection();
  
  if (money < 0)
    money = 0;

  for (Tower t : towers) {
    t.display();
  }

  eToRemove.clear();

  for (int j = enemy.size() - 1; j >= 0; j--) {
    Enemy e = enemy.get(j);
    e.display();
    e.move();

    for (Tower t : towers) {
      t.display();

      if (t.inRange(e)) {
        if (!t.attackTimer.isStarted()) {
          t.attackTimer.start();
        } else if (t.attackTimer.isFinished()) {
          t.attackTimer.start();
          t.attack(e);
        }

        if (t.tick >= 3) {
          t.applySpecial(e);
        }

        if (t.fTimer != null && t.fTimer.isStarted() && t.fTimer.isFinished()) {
          t.noSpecial(e);
        }
        if (t.mageTimer.isStarted() && t.mageTimer.isFinished())
          t.noSpecial(e);
        if (t.fireTimer.isStarted() && t.fireTimer.isFinished())
          t.noSpecial(e);
        if (t.burnTimer.isStarted() && !t.fireTimer.isFinished())
          t.burn(e);
      }
    }

    if (!e.l()) {
      money += e.rewardMoney;
      eToRemove.add(e);
    }

    if (e.passX()) {
      enemyCount++;
      life -= enemyCount;
      eToRemove.add(e);
    }
  }

  enemy.removeAll(eToRemove);
}




void nextRoundHandle() {
  nextRound.x = mapWidth / 2;
  nextRound.y = mapHeight / 2;
  nextRound.width = 300;
  nextRound.height = 300;
  nextRound.display();
  fill(0);
  String nr = "Click for Next Round";
  text(nr, mapHeight / 2, mapWidth / 2);
  if (nextRound.pressed()) {
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
