class Enemy {
  int health, rewardMoney, size;
  float speed, x, y;
  PImage enemy;
  Map m;
  boolean frozen;
  String currentSpecial; // Track current special effect

  Enemy() {
    x = 100;
    y = int(random(512, 576));
    health = 100;
    speed = 1;
    rewardMoney = 50;
    enemy = loadImage("towerImages/enemy.png");
    m = new Map();
    size = 100;
    frozen = false;
    currentSpecial = null; // No special effect initially
  }

  void display() {
    image(enemy, x, y);
    enemy.resize(60, 75);
  }

  void move() {
    if (!frozen)
      x += speed;
  }

  boolean passY() {
    return y > (height + 40);
  }

  boolean passX() {
    return x > (width + 40);
  }

  boolean l() {
    return health >= 0;
  }

  void freeze() {
    print(" frozen");
    frozen = true;
    currentSpecial = "freeze"; // Set current special effect to freeze
    enemy = loadImage("towerImages/enemy frozen.png");
  }

  void unFreeze() {
    frozen = false;
    println("Freeze finished: speed " + speed);
    currentSpecial = null; // Clear current special effect
    enemy = loadImage("towerImages/enemy.png");
  }

  // Method to check if the enemy is under any special effect
  boolean hasSpecial() {
    return currentSpecial != null;
  }

  // Method to clear the special effect
  void clearSpecial() {
    currentSpecial = null;
  }
}
