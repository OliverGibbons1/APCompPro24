class IceTower extends Tower {

  int freezeTime = 2000;

  IceTower (int x, int y) {
    super.delay = freezeTime;
    super.x = x;
    super.y = y;
    super.cost = 100;
    super.damage = 10;
    super.range = 400;
    super.tower = loadImage("towerImages/iceTower.png");
  }

  void attack(Enemy enemy) {
    enemy.health -= damage;
    tick++;
    println(" attacked " + tick + " health " + enemy.health + " e.speed " + enemy.speed);
  }

  void applySpecial(Enemy enemy) {
    //TODO add ice picture over enemy to indicate frozen-ness
    tick = 0;
    fTimer.start();
    enemy.freeze();
  }

  void noSpecial(Enemy enemy) {
    enemy.unFreeze();
  }
}
