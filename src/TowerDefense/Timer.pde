class Timer {

  int savedTime; // When Timer started
  int totalTime; // How long Timer should last
  boolean started;

  Timer(int last) {
    totalTime = last;
    started = false;
  }

  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
    started = true;
  }

  boolean isFinished() {
    // Check how much time has passed
    int passedTime = millis() - savedTime;
    boolean finished = passedTime > totalTime;
    if (finished) {
      // Reset the timer when it's finished
      started = false;
    }
    return finished;
  }

  boolean isStarted() {
    return started;
  }
}
