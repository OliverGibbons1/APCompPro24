class Enemy {
  int health, speed, rewardMoney, x, y, size;
  PImage enemy;
  Map m;

  int[] rowDir = {-1, 1, 0, 0};
  int[] colDir = {0, 0, -1, 1};

  Enemy () {
    x = 100;
    y = int(random(512, 576));
    this.health = 100;
    this.speed = speed;
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
    //x += 1;
    //y++;
  }
  boolean passY() {
    if (Y > (height + 15)) {
      return true;
    } else {
      return false;
    }
  }
  int getHealth() {
  return health;
  }
  //Recursive move method
}
