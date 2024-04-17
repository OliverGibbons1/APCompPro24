abstract class Tower {

  protected int cost, range, damage, x, y;
  int tick, delay;
  PImage tower;
  boolean attack;
  Enemy e;
  Timer fTimer, mageTimer, fireTimer;

  Tower () {
    tick = 0;
    attack = false;
    e = new Enemy();
    this.delay = delay;
    fTimer = new Timer(delay);
    mageTimer = new Timer(2000);
    fireTimer = new Timer(2000);
  }

  abstract void attack(Enemy enemy);
  abstract void applySpecial(Enemy enemy);
  abstract void noSpecial(Enemy enemy);
  
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
