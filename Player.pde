class Player extends Mover {

  boolean isAlive = true;
  PVector direction = new PVector(1, 1);

  Player() {
    location = new PVector(1000, 500);
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
    //mass = 1;
    radius=16;
    col = color(255, 0, 0);
  }

  Player(PVector loc, PVector vel) {
    location = loc;
    velocity = vel;
    acceleration = new PVector(0, 0);
    //mass = 1;
    radius=16;
    col = color(255, 0, 0);
  }

  void fwd() {
    location.add(direction);
  }

  void left() {
    direction.add(new PVector(0, 1));
    direction.normalize();
    location.add(direction);
  }

  void right() {
    direction.add(new PVector(0, -1));
    direction.normalize();
    location.add(direction);
  }
}