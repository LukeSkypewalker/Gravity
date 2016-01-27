// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Attractor {
  float mass;    // Mass, tied to size
  final float G=6;       // Gravitational Constant
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

  PVector leapFrogAttractMoverInPoint(Mover m, int k) {
    PVector moverLocationK = PVector.sub(m.location, PVector.mult(m.velocity, k/fRate));
    PVector force = PVector.sub(location, moverLocationK);
    float r = force.mag(); 
    float strength = (G*mass*m.mass)/(r*r); 
    force.normalize();
    force.mult(strength); //possible optimization - (strength/r) without force.normalize()
    return force;
  }

  PVector attract(Mover m) {
    return PVector.add(leapFrogAttractMoverInPoint(m, 0), PVector.div(PVector.sub(leapFrogAttractMoverInPoint(m, -1), leapFrogAttractMoverInPoint(m, 1)), 2));
    //return leapFrogAttractMoverInPoint(m, 0); //without LeapFrog
  }



  void display() {
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    if (dragging) fill (50);
    else if (rollover) fill(100);
    else fill(175, 200);
    ellipse(location.x, location.y, mass*2, mass*2);
  }


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