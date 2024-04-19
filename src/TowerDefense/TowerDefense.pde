//Oliver Gibbons | March 2024

// TO DO:
// Fix tower button staying
// applySpecial() effects (freeze cube, fire animation)
// Make checks for tower placement;
// make checks for enemy movement (recursive); make enemy movement;
// mostly tower and enemy, map set up
// MAP: finish extra tower spots; make variables in grid [] [] for different towers if needed

private int money, round, life, enemyCount;
Map m;
Button startButton, quitButton, loadGameButton, clearSaveButton, saveGameButton, nextRound;
Button t1, t2, t3, t4, t5;
Button fireSelect, mageSelect, iceSelect, background;
JSONObject saveGame;
private boolean savedGame, play, first, hasPlacedTower;
int mapWidth = 640;
int mapHeight = 640;
int tileW = 64;
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
ArrayList<Enemy> eToRemove = new ArrayList<Enemy>();
ArrayList<Tower> towers = new ArrayList<Tower>(); // Changed name to 'towers'
Timer attackTimer;

private String s = "Start";
private String q = "Quit";
private String l = "Load Game";
private String c = "Clear Save";
private String i = " ";

boolean t2Pressed, finishedSelection;

void setup() {
  m = new Map();
  size(640, 640);
  life = 100;
  round = 0;
  money = 500;
  enemyCount = 0;
  first = true;
  play = false;
  hasPlacedTower = false;

  saveGame = new JSONObject();

  // Start button initialization
  startButton = new Button(mapWidth/6, mapHeight/3.5, 112, 48);
  quitButton = new Button(mapWidth/2, 3*(mapHeight/4) + 20, 140, 60);
  loadGameButton = new Button((mapWidth/6)*5, mapHeight/3.5, 112, 48);
  clearSaveButton = new Button(mapWidth/2, 3*(mapHeight/4) + 100, 40, 40);
  saveGameButton = new Button(((mapWidth/5) * 4) + 20, 32, 128, 32);
  nextRound = new Button(mapHeight / 2, mapWidth / 2, 300, 300);

  attackTimer = new Timer(1000);
}

void draw() {
  //General stuffs
  rectMode(CENTER);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  //Startscreen-----------------------------------------------------------------------------------
  if (!play && first) {
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
    if (quitButton.pressed())
      exit();
    if (clearSaveButton.pressed())
      clearSave();
  }
  //Start of play--------------------------------------------------------------------------------
  if (play) {
    m.displayPlayMap();
    infoBar();

    if (!hasPlacedTower) {
      selectTower();
    }

    if (hasPlacedTower) {
      //Temporary; eventually check to see that all towers are placed prior to starting
      if (enemy.size() == 0)
        nextRoundHandle();

      //Enemy stuffs: Count enemies passing Y, remove enemy if dead, attack enemy if in range, display
      for (int j = enemy.size() - 1; j >= 0; j--) {
        for (Tower t : towers) { // Loop through all towers
          Enemy e = enemy.get(j);
          e.display();
          e.move();
          t.display();

          // attack if in range and if timer is finished
          if (t.inRange(e)) {
            if (!attackTimer.isStarted()) {
              attackTimer.start();
              println("Started");
            } else if (attackTimer.isFinished()) {
              // If attackTimer is finished, reset it and perform attack
              attackTimer.start(); // Reset the timer
              t.attack(e);
            }
          }

          if (t.tick >= 3) {
            t.applySpecial(e);
          }

          if (t.fTimer.isStarted() && t.fTimer.isFinished())
            t.noSpecial(e);
          if (t.mageTimer.isStarted() && t.mageTimer.isFinished())
            t.noSpecial(e);
          if (t.fireTimer.isStarted() && t.fireTimer.isFinished())
            t.noSpecial(e);
          if (t.burnTimer.isStarted() && !t.fireTimer.isFinished())
            t.burn(e);
          if (!e.l()) {
            println("removed ");
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
      }
      //Game Over logic
      if (checkGameOver()) {
        m.displayEndMap();
        play = false;
      }
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

void selectTower() {
  //instructions on how to select towers later, GUI

  // Tower button initialization
  t1 = new Button(1 * tileW + tileW/2, 6 * tileW + tileW/2, tileW, tileW);
  t2 = new Button(3 * tileW + tileW/2, 1 * tileW + tileW/2, tileW, tileW);
  t3 = new Button(7 * tileW + tileW/2, 4 * tileW + tileW/2, tileW, tileW);
  t4 = new Button(6 * tileW + tileW/2, 7 * tileW + tileW/2, tileW, tileW);
  t5 = new Button(4 * tileW + tileW/2, 4 * tileW + tileW/2, tileW, tileW);

  t1.display();
  t2.display();
  t3.display();
  t4.display();
  t5.display();


  if (t1.pressed()) {
    optionWindow(t1.getX(), t1.getY());
  }
  if (t2.pressed()) {
    t2Pressed = true;
    optionWindow(t2.getX(), t2.getY());
  }
  if (t3.pressed()) {
    optionWindow(t3.getX(), t3.getY());
  }
  if (t4.pressed()) {
    optionWindow(t4.getX(), t4.getY());
  }
  if (t5.pressed()) {
    optionWindow(t5.getX(), t5.getY());
  }

  //  Tower firstTower = new FireTower(96, 416);
  //  towers.add(firstTower);
}

void optionWindow(float buttonX, float buttonY) {

  finishedSelection = false;

  float windowWidth = 190;
  float windowHeight = 100;
  float windowX = constrain(buttonX - windowWidth / 2, 0, width - windowWidth);
  float windowY = buttonY - windowHeight - 50;
  float windowYBelow = buttonY + 50;

  // Calculate button positions relative to the window
  float buttonSize = 40;
  float buttonSpacing = (windowWidth - buttonSize * 3) / 4;
  float buttonYPos = windowY + (windowWidth / 4);

  // Draw the window background
  if (t2Pressed) {
    background = new Button(windowX + windowWidth / 2, windowYBelow + windowHeight / 2, windowWidth, windowHeight);
    fireSelect = new Button(windowX + buttonSpacing + buttonSize / 2, windowYBelow + windowHeight / 1.5 - buttonSize / 2, buttonSize, buttonSize);
    mageSelect = new Button(windowX + 2 * buttonSpacing + 1.5 * buttonSize, windowYBelow + windowHeight / 1.5 - buttonSize / 2, buttonSize, buttonSize);
    iceSelect = new Button(windowX + 3 * buttonSpacing + 2.5 * buttonSize, windowYBelow + windowHeight / 1.5 - buttonSize / 2, buttonSize, buttonSize);
    t2Pressed = false;
  } else {
    background = new Button(windowX + windowWidth / 2, windowY + windowHeight / 2, windowWidth, windowHeight);
    fireSelect = new Button(windowX + buttonSpacing + buttonSize / 2, buttonYPos, buttonSize, buttonSize);
    mageSelect = new Button(windowX + 2 * buttonSpacing + 1.5 * buttonSize, buttonYPos, buttonSize, buttonSize);
    iceSelect = new Button(windowX + 3 * buttonSpacing + 2.5 * buttonSize, buttonYPos, buttonSize, buttonSize);
  }

  background.display();
  fireSelect.display();
  mageSelect.display();
  iceSelect.display();

  // Handle button presses and remove buttons and window
  do {
  if (fireSelect.pressed() || mageSelect.pressed() || iceSelect.pressed()) {
    if (fireSelect.pressed()) {
      Tower fireTower = new FireTower(mouseX, mouseY);
      towers.add(fireTower);
      finishedSelection = true;
    } else if (mageSelect.pressed()) {
      Tower mageTower = new MageTower(mouseX, mouseY);
      towers.add(mageTower);
      finishedSelection = true;
    } else if (iceSelect.pressed()) {
      Tower iceTower = new IceTower(mouseX, mouseY);
      towers.add(iceTower);
      finishedSelection = true;
    }
    fireSelect.remove();
    mageSelect.remove();
    iceSelect.remove();
    background.remove();
  } else if (anotherButtonPressed()) {
    fireSelect.remove();
    mageSelect.remove();
    iceSelect.remove();
    background.remove();
    finishedSelection = true; // Reset optionWindowActive
  }
  } while (!finishedSelection);

  t1.remove();
  t2.remove();
  t3.remove();
  //hasPlacedTower = true;
}

boolean anotherButtonPressed() {
  return (t1.pressed() || t2.pressed() || t3.pressed() || t4.pressed() || t5.pressed());
}
