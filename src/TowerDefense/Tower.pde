abstract class Tower {

  protected int cost, range, damage, x, y;
  int tick, delay;
  PImage tower;
  boolean attack;
  Enemy e;
  Timer fTimer;

  Tower () {
    tick = 0;
    attack = false;
    e = new Enemy();
    fTimer = new Timer(delay);
    this.range = range;
  }

  abstract void attack();
  abstract void applySpecial();

  void display() {
    imageMode(CENTER);
    if (mouseX < (x + 32) && mouseY > (y - 32) && mouseX > (x - 32) && mouseY < (y + 32)) {
      fill(#AA4A44, 150);
      circle(x, y, range * 2);
    }
    image(tower, x, y);
    tower.resize(64, 64);
  }

  boolean inRange(Enemy enemy) {
    double squaredDistance = Math.pow(enemy.x - x, 2) + Math.pow(enemy.y - y, 2);
    return squaredDistance <= Math.pow(range, 2);
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
