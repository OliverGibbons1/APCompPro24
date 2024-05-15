class IceTower extends Tower {
  int freezeTime = 2000;

  IceTower(float x, float y) {
    this.x = x;
    this.y = y;
    this.cost = 100;
    this.damage = 10;
    this.range = 200;
    this.delay = freezeTime;
    this.tower = loadImage("towerImages/iceTower.png");
    
    // Initialize the fTimer after setting the delay
    this.fTimer = new Timer(this.delay);
  }

  void attack(Enemy enemy) {
    enemy.health -= damage;
    tick++;
    println("IceTower attacked " + tick + " health " + enemy.health + " speed: " + enemy.speed);
  }

  void applySpecial(Enemy enemy) {
    if (!enemy.hasSpecial()) {
      tick = 0;
      fTimer.start();
      enemy.freeze();
    }
  }

  void noSpecial(Enemy enemy) {
    enemy.unFreeze();
    enemy.clearSpecial();
  }
}
