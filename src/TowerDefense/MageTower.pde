class MageTower extends Tower {

  int extraDamage;
  PImage mageTower;

  MageTower (int x, int y) {
    extraDamage = 20;
    super.x = x;
    super.y = y;
    super.cost = 150;
    super.damage = 15;
    super.range = 500;
    super.tower = loadImage("towerImages/magicTower.png");
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
    println("Mage Special");
    damage += extraDamage;
    delay(5000);
    damage = 15;
  }
}
