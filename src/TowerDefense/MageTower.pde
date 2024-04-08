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
    if (inRange(e)) {
      e.Ehealth -= damage;
    }
  }

  void applySpecial() {
  }
}
