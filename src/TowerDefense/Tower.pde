abstract class Tower {

  protected int cost, range, damage, x, y;
  int tick;
  PImage tower;
  boolean attack;
  Enemy e;

  Tower () {
    tick = 0;
    attack = false;
    e = new Enemy();
  }

  abstract void attack();
  abstract void applySpecial();

  void display() {
    imageMode(CENTER);
    if (mouseX < (x + 32) && mouseY > (y - 32) && mouseX > (x - 32) && mouseY < (y + 32)) {
      fill(#AA4A44, 150);
      circle(x, y, range);
    }
      image(tower, x, y);
      tower.resize(64, 64);
  }

  boolean inRange(Enemy enemy) {
    double distance = Math.sqrt(Math.pow(enemy.x - x, 2) + Math.pow(enemy.y - y, 2));
    return distance <= range;
  }

  void upgrade() {
  }

  void getCost() {
  }

  void getRange() {
  }

  void getDamage() {
  }
}
