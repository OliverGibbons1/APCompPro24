class IceTower extends Tower {

  int freezeTime = 1000;
  boolean special = false;

  IceTower (int x, int y) {
    super.delay = freezeTime;
    super.x = x;
    super.y = y;
    super.cost = 100;
    super.damage = 50;
    super.range = 400;
    super.tower = loadImage("towerImages/iceTower.png");
  }

  void attack() {
    e.health -= damage;
    tick++;
    println(" attacked " + tick + " health " + e.health + " e.speed " + e.speed);
    //if (tick >= 3) {
    //  applySpecial();
    //}
    //if (fTimer.isFinished() && fTimer.isStarted()) {
    //  e.unFreeze();
    //}
  }

  void applySpecial() {
    //TODO add ice picture over enemy to indicate frozen-ness
    //Frozen-ness does not allow tower to continue attacking the enemies. Potental problem with multiple enemies?
    tick = 0;
    fTimer.start();
    e.freeze();
  }
}
