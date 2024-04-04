class FireTower extends Tower {

  int passiveDamage;
  PImage fireTower;

  FireTower () {
    passiveDamage = 5;
    super.x = x;
    super.y = y;
    super.cost = 200;
    super.damage = 10;
    super.range = 98;
    super.tower = loadImage("towerImages/fireTower.png");
  }

  void attack() {
    if (inRange(e)) {
      e.health -= damage;
    }
  }

  void applySpecial() {
  }
}
