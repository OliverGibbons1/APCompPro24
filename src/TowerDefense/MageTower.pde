class MageTower extends Tower {

  int extraDamage;
  PImage mageTower;

  MageTower () {
    extraDamage = 20;
    super.x = x;
    super.y = y;
    super.cost = 150;
    super.damage = 15;
    super.range = 98;
    super.tower = loadImage("towerImages/magicTower.png");
    //mageTower =
  }

  void attack() {
    e.health -= damage;
    tick++;
    println(" attacked " + tick + " health " + e.health);
    if (tick >= 2) {
      applySpecial();
      tick = 0;
    }
  }

  void applySpecial() {
    damage += extraDamage;
    delay(5000);
    damage = 15;
  }
}
