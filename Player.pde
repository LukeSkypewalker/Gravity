class Player extends Mover {

  boolean isAlive = true;
  PVector direction = new PVector(1, 0);
  int throttle = 0;

  Player() {
    location = new PVector(1000, 500);
    velocity = new PVector(0, 0);
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
  
  void update() {
    location.add(direction.mult(throttle));
  }
  
  void fwd() {
    throttle++;
    direction.mult(throttle);
  }

  void back() {
    throttle--;
    direction.mult(throttle);
  }

  void left() {
    direction.x=direction.x*0.707+direction.y*0.707;
    direction.y=-direction.x*0.707+direction.y*0.707;   
    //direction.normalize();
  }

  void right() {
    direction.x=direction.x*0.707-direction.y*0.707;
    direction.y=direction.x*0.707+direction.y*0.707;    
    //direction.normalize();
  }
}