class Enemy {
  int health, rewardMoney, size;
  float speed, x, y;
  PImage enemy;
  Map m;
  int[] rowDir = {-1, 1, 0, 0};
  int[] colDir = {0, 0, -1, 1};

  Enemy () {
    x = 100;
    y = int(random(512, 576));
    health = 100;
    speed = 1;
    rewardMoney = 50;
    enemy = loadImage("towerImages/enemy.png");
    m = new Map();
    size = 100;
  }

  void display() {
    image(enemy, x, y);
    enemy.resize(100, 100);
  }

  void move() {
    x += speed;
    //y++;
  }

  boolean passY() {
    if (y > (height + 40)) {
      return true;
    } else {
      return false;
    }
  }

  //testing only
  boolean passX() {
    if (x > (width + 40)) {
      return true;
    } else {
      return false;
    }
  }
  boolean l() {
    if (health >= 0)
    {
      return true;
    } else {
      return false;
    }
  }
  void freeze() {
    speed = speed/2;
    println("Freeze special: new speed " + speed);
  }
  void unFreeze() {
    speed = 1;
    println("Freeze finished: speed" + speed);
  }
}
