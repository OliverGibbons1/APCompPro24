//Oliver Gibbons | March 2024
int money, round, health;
Map M1;

void setup() {
  M1 = new Map();
  size(640, 640);
  health = 100;
  round = 0;
  money = 500;
}

void draw() {
  M1.displayMap();
}

boolean checkGameOver() {
  return false;
}
