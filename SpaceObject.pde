class SpaceObject {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float dir = 0; 
  float mass = 16;
  int radius = 16;
  color col = color(255, 0, 0);

  SpaceObject() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  SpaceObject(PVector loc, PVector vel) {
    location = loc;
    velocity = vel;
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector a = PVector.div(force, mass);
    acceleration.add(a);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    fill(col);
    ellipse(location.x, location.y, radius, radius);
  }

  void wrapAroundTheScreen() {
    if (location.x < 0) location.x += width;
    if (location.x > width) location.x = 0;
    if (location.y < 0) location.y += height;
    if (location.y > height) location.y = 0;
  }
}