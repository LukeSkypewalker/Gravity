class Attractor extends SpaceObject {
  float G=60; // Gravitational Constant

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

  PVector leapFrogAttractSpaceObjectInPoint(SpaceObject m, int k) {
    PVector SpaceObjectLocationK = PVector.sub(m.location, PVector.mult(m.velocity, k/fRate));
    PVector force = PVector.sub(location, SpaceObjectLocationK);
    float r = force.mag(); 
    float strength = (G*mass*m.mass)/(r*r); 
    force.normalize();
    force.mult(strength); //possible optimization - (strength/r) without force.normalize()
    return force;
  }

  PVector attract(SpaceObject m) {
    return PVector.add(leapFrogAttractSpaceObjectInPoint(m, 0), PVector.div(PVector.sub(leapFrogAttractSpaceObjectInPoint(m, -1), leapFrogAttractSpaceObjectInPoint(m, 1)), 2));
    //return leapFrogAttractSpaceObjectInPoint(m, 0); //without LeapFrog
  }
}