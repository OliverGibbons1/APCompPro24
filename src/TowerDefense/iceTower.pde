class IceTower extends Tower {

  int freezeTime;

  IceTower (int x, int y) {
    freezeTime = 2000;
    super.x = x;
    super.y = y;
    super.cost = 100;
    super.damage = 50;
    super.range = 250;
    super.tower = loadImage("towerImages/iceTower.png");
  }

  void attack() {
    e.health -= damage;
    tick++;
    println(" attacked " + tick + " health " + e.health);
    if (tick >= 3) {
      applySpecial();
      tick = 0;
    }
  }

  void applySpecial() {
    //  move = false;
    //  delay(freezeTime);
    //  move = true;
    //}
  }
}
