abstract class Tower {
  protected int cost, range, damage, delay;
  protected float x, y;
  int tick;
  PImage tower;
  Enemy e;
  Timer attackTimer, fTimer, mageTimer, fireTimer, burnTimer;

  Tower() {
    tick = 0;
    e = new Enemy();
    attackTimer = new Timer(1000); // Each tower has its own attack timer
    fTimer = null; // Initialize as null, set it later in the subclass
    mageTimer = new Timer(2000);
    fireTimer = new Timer(10000);
    burnTimer = new Timer(500);
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

  void burn(Enemy enemy) {
  }

  void upgrade() {
  }

  int getCost() {
    return cost;
  }
  int getRange() {
    return range;
  }
  int getDealy() {
    return delay;
  }
}
