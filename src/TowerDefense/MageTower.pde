class MageTower extends Tower {

  int extraDamage;
  PImage mageTower;

  MageTower (float x, float y) {
    extraDamage = 20;
    super.x = x;
    super.y = y;
    super.cost = 150;
    super.damage = 15;
    super.range = 400;
    super.tower = loadImage("towerImages/magicTower.png");
  }

  void attack(Enemy enemy) {
    enemy.health -= damage;
    tick++;
    println(" attacked " + tick + " health " + enemy.health + " damage " + damage);
  }

  void applySpecial(Enemy enemy) {
    //TODO add spell auora picture over enemy to indicate extra damage taken
    tick = 0;
    mageTimer.start();
    damage += extraDamage;
    println("special damage: " + damage);
    enemy.enemy = loadImage("towerImages/enemy cursed.png");
  }
  void noSpecial(Enemy enemy) {
    damage = 15;
    println("noSpecial: damage " + damage);
  }
}
