// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass = 20;
  int radius;
  color col;
  
  Mover() {
    location = new PVector(1000,500);
    velocity = new PVector(1,0);
    acceleration = new PVector(0,0);
    //mass = 1;
    radius=16;
    col = color(255,0,0);
  }
  
  Mover(PVector loc, PVector vel) {
    location = loc;
    velocity = vel;
    acceleration = new PVector(0,0);
    //mass = 1;
    radius=16;
    col = color(255,255,0);

  }
  
  Mover(PVector loc, PVector vel, PVector a, float m, int r) {
    location = loc;
    velocity = vel;
    acceleration = a;
    mass = m;
    radius=r;
  }
  
  void applyForce(PVector force) {
    PVector a = PVector.div(force,mass);
    acceleration.add(a);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(col);
    ellipse(location.x,location.y,radius,radius);
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }

  }

}