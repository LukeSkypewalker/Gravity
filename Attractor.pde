// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Attractor {
  float mass;   
  float G=60; // Gravitational Constant
  PVector location;

  Attractor() {
    location = new PVector(random(width), random(height));
    mass = 50;
  }

  Attractor(PVector loc, float m) {
    location = loc;
    mass = m;
  }
  
  void setLocation(PVector loc){
    this.location=loc;
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
}