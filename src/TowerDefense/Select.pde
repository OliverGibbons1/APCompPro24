Button[] buttons = new Button[5];
boolean t1Pressed, t2Pressed, t3Pressed, t4Pressed, t5Pressed = false;
boolean[] pressedStates = {t1Pressed, t2Pressed, t3Pressed, t4Pressed, t5Pressed};
Button fireSelect, mageSelect, iceSelect, background;
int tileW = 64;
int count = 0;
float currentButtonX, currentButtonY;
class Select {

  Select() {
    currentButtonX = 0;
    currentButtonY = 0;
    // Tower button initialization
    buttons[0] = new Button(1 * tileW + tileW/2, 6 * tileW + tileW/2, tileW, tileW);
    buttons[1] = new Button(3 * tileW + tileW/2, 1 * tileW + tileW/2, tileW, tileW);
    buttons[2] = new Button(7 * tileW + tileW/2, 4 * tileW + tileW/2, tileW, tileW);
    buttons[3] = new Button(6 * tileW + tileW/2, 7 * tileW + tileW/2, tileW, tileW);
    buttons[4] = new Button(4 * tileW + tileW/2, 4 * tileW + tileW/2, tileW, tileW);
  }

  void display() {
    //instructions on how to select towers later, GUI
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].display();

      if (pressedStates[i]) {
        background.display();
        fireSelect.display();
        mageSelect.display();
        iceSelect.display();
      }
    }
  }

  void finalSelection() {
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].pressed() && !pressedStates[i]) {
        pressedStates[i] = true;
        optionWindow(buttons[i].getX(), buttons[i].getY());
        currentButtonX = buttons[i].getX();
        currentButtonY = buttons[i].getY();
        display();
      }
    }

    for (int i = 0; i < buttons.length; i++) {
      if (pressedStates[i]) {
        if (fireSelect.pressed()) {
          Tower fireTower = new FireTower(currentButtonX, currentButtonY);
          towers.add(fireTower);
          pressedStates[i] = false;
          buttons[i].remove();
          count++;
        }
        if (mageSelect.pressed()) {
          Tower mageTower = new MageTower(currentButtonX, currentButtonY);
          towers.add(mageTower);
          pressedStates[i] = false;
          buttons[i].remove();
          count++;
        }
        if (iceSelect.pressed()) {
          Tower iceTower = new IceTower(currentButtonX, currentButtonY);
          towers.add(iceTower);
          pressedStates[i] = false;
          buttons[i].remove();
          count++;
        }
      }
    }
  }

  void optionWindow(float buttonX, float buttonY) {

    float windowWidth = 190;
    float windowHeight = 100;
    float windowX = constrain(buttonX - windowWidth / 2, 0, width - windowWidth);
    float windowY = buttonY - windowHeight - 50;
    float windowYBelow = buttonY + 50;

    // Calculate button positions relative to the window
    float buttonSize = 40;
    float buttonSpacing = (windowWidth - buttonSize * 3) / 4;
    float buttonYPos = windowY + (windowWidth / 4);

    // Draw the window background
    if (t2Pressed) {
      background = new Button(windowX + windowWidth / 2, windowYBelow + windowHeight / 2, windowWidth, windowHeight);
      fireSelect = new Button(windowX + buttonSpacing + buttonSize / 2, windowYBelow + windowHeight / 1.5 - buttonSize / 2, buttonSize, buttonSize);
      mageSelect = new Button(windowX + 2 * buttonSpacing + 1.5 * buttonSize, windowYBelow + windowHeight / 1.5 - buttonSize / 2, buttonSize, buttonSize);
      iceSelect = new Button(windowX + 3 * buttonSpacing + 2.5 * buttonSize, windowYBelow + windowHeight / 1.5 - buttonSize / 2, buttonSize, buttonSize);
    } else {
      background = new Button(windowX + windowWidth / 2, windowY + windowHeight / 2, windowWidth, windowHeight);
      fireSelect = new Button(windowX + buttonSpacing + buttonSize / 2, buttonYPos, buttonSize, buttonSize);
      mageSelect = new Button(windowX + 2 * buttonSpacing + 1.5 * buttonSize, buttonYPos, buttonSize, buttonSize);
      iceSelect = new Button(windowX + 3 * buttonSpacing + 2.5 * buttonSize, buttonYPos, buttonSize, buttonSize);
    }
  }

  boolean over() {
    if (count == 5) {
      return true;
    } else {
      return false;
    }
  }
}


 // Reference just in case
    //if (t2Pressed) {
    //  if (fireSelect.pressed()) {
    //    Tower fireTower = new FireTower(currentButtonX, currentButtonY);
    //    towers.add(fireTower);
    //    t2Pressed = false;
    //    t2.remove();
    //    count++;
    //  }
    //  if (mageSelect.pressed()) {
    //    Tower mageTower = new MageTower(currentButtonX, currentButtonX);
    //    towers.add(mageTower);
    //    t2Pressed = false;
    //    t2.remove();
    //    count++;
    //  }
    //  if (iceSelect.pressed()) {
    //    Tower iceTower = new IceTower(currentButtonX, currentButtonX);
    //    towers.add(iceTower);
    //    t2Pressed = false;
    //    t2.remove();
    //    count++;
    //  }
    //}
