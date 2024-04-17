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

  void attack(Enemy enemy) {
    e.health -= damage;
    tick++;
    println(" attacked " + tick + " health " + e.health);
    if (tick >= 2) {
      applySpecial(e);
      tick = 0;
    }
  }

  void applySpecial(Enemy enemy) {
    print("Fire Special");
  }

  void noSpecial(Enemy enemy) {
    enemy.unFreeze();
  }
}
