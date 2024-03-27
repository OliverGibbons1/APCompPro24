class Enemy {
  int health, speed, rewardMoney, x, y;
  int amount; // amount of enemies per round;
  PImage enemy;

  Enemy () {
    x = - 10;
    y = 100;
    this.health = health;
    this.speed = speed;
    this.rewardMoney = rewardMoney;
    this.amount = amount;
    //enemy =
  }
  void move() {
  //recursive function for automated enemy movement
  }
  boolean passX() {
    if (x > width + 15) {
      return true;
    } else {
      return false;
    }
  }
}
