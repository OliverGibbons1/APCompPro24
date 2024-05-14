class FireTower extends Tower {

  int passiveDamage;
  PImage fireTower;
  boolean onFire;

  FireTower (float x, float y) {
    passiveDamage = 5;
    super.x = x;
    super.y = y;
    super.cost = 200;
    super.damage = 10;
    super.range = 400;
    super.tower = loadImage("towerImages/fireTower.png");
  }

  void attack(Enemy enemy) {
    enemy.health -= damage;
    println(" attacked. health " + enemy.health);
    applySpecial(enemy);
  }

  void applySpecial(Enemy enemy) {
    fireTimer.start();
    if (!burnTimer.isStarted()) {
      burnTimer.start();
    }
    enemy.enemy = loadImage("towerImages/enemy fire.png");

  }

  void burn (Enemy enemy) {
    if (burnTimer.isFinished()) {
      // If attackTimer is finished, reset it and perform attack
      burnTimer.start(); // Reset the timer
      enemy.health -= 5;
      println("Fire Special: health " + enemy.health);
    }
  }

  void noSpecial(Enemy enemy) {
    onFire = false;    
    enemy.enemy = loadImage("towerImages/enemy.png");
  }
}
