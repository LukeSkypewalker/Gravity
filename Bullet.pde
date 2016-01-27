class Bullet extends Mover{

 
  Bullet(PVector loc, PVector vel) {
    super(loc,vel);
  }

  Bullet(PVector loc, PVector vel, PVector a, float m) {
    super(loc,vel,a,m);
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(col);
    ellipse(location.x, location.y, radius, radius);
  }

}