class IceTower extends Tower {

  int freezeTime = 3000;

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
      tick = 0;
    }
    if (timer.isFinished()) {
      move = true;
    }
  }

  void applySpecial() {
    //TODO add ice picture over enemy to indicate frozen-ness
    println("Freeze special");
    move = false;
    timer.start();
  }
}
