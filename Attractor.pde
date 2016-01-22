// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Attractor {
  float mass;    // Mass, tied to size
  float G=6;       // Gravitational Constant
  PVector location;   // Location
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on

  Attractor() {
    location = new PVector(width/2, height/2);
    //location = new PVector(random(width), random(height));
    mass = 50;
    dragOffset = new PVector(0.0, 0.0);
  }

  Attractor(PVector loc, float m) {
    location = loc;
    mass = m;
    dragOffset = new PVector(0.0, 0.0);
  }

  PVector subforce(Mover m, int k) {
    PVector force = PVector.sub(location, PVector.sub(m.location, PVector.mult(m.velocity, k/fRate)));   // Calculate direction of force
    float d = force.mag(); 
    int n = 128;
    float strength = 0;
    force.normalize();
    //strength = (G*mass*m.mass)/(d*d);
    for (int i=-n/2; i<n/2; i++) {
      strength += (G * mass/n * m.mass) / ((d+d*i/n) * (d+d*i/n));     // Calculate gravitional force magnitude
    }
    force.mult(strength); 
    return force;
  }

  PVector attract(Mover m) {
    return PVector.add(subforce(m, 0), PVector.div(PVector.sub(subforce(m, -1), subforce(m, 1)), 2));
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    if (dragging) fill (50);
    else if (rollover) fill(100);
    else fill(175, 200);
    ellipse(location.x, location.y, mass*2, mass*2);
  }

  // The methods below are for mouse interaction
  void clicked(int mx, int my) {
    float d = dist(mx, my, location.x, location.y);
    if (d < mass) {
      dragging = true;
      dragOffset.x = location.x-mx;
      dragOffset.y = location.y-my;
    }
  }

  void hover(int mx, int my) {
    float d = dist(mx, my, location.x, location.y);
    if (d < mass) {
      rollover = true;
    } else {
      rollover = false;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag() {
    if (dragging) {
      location.x = mouseX + dragOffset.x;
      location.y = mouseY + dragOffset.y;
    }
  }
}