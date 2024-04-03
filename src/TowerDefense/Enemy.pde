class Enemy {
  int health, speed, rewardMoney, x, y;
  int amount; // amount of enemies per round;
  PImage enemy;
  Map m;
  
  Enemy () {
    x = 100;
    y = int(random(512, 576));
    this.health = 100;
    this.speed = speed;
    this.rewardMoney = rewardMoney;
    this.amount = amount;
    enemy = loadImage("towerImages/enemy.png");
    m = new Map();
  }
  void display() {
    image(enemy, x, y);
    enemy.resize(100, 100);
  }
  //Recursive move method
  void move() {
  }
  boolean passY() {
    if (Y > (height + 15)) {
      return true;
    } else {
      return false;
    }
  }
}
