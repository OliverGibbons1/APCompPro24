class IceTower extends Tower {

  int freezeTime = 3000;
  boolean special = false;

  IceTower (int x, int y) {
    super.delay = freezeTime;
    super.x = x;
    super.y = y;
    super.cost = 100;
    super.damage = 50;
    super.range = 550;
    super.tower = loadImage("towerImages/iceTower.png");
  }

  void attack() {
    e.health -= damage;
    tick++;
    println(" attacked " + tick + " health " + e.health);
    if (tick >= 2) {
      applySpecial();
    }
  }

  void applySpecial() {
    //TODO add ice picture over enemy to indicate frozen-ness
    tick = 0;
    println("Freeze special");
    special = true;
    timer.start();
    if (!timer.isFinished())
      special = false;
  }
}
