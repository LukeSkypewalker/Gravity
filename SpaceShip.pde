class SpaceShip extends SpaceObject {

  private Controller controller;
  long prevFireTime = 0;
  long fireCooldown = 200;
  float nullGravityModule = 1;
  float accelerationModule = 0.05; 
  boolean forcage = false;
  //boolean isActive = false;


  SpaceShip() {
    location = new PVector(width/2, height/2, 0);
    velocity = new PVector();
    acceleration = new PVector();
    controller = new Controller(this);
  }

  SpaceShip(PVector loc) {
    location = loc;
    velocity = new PVector();
    acceleration = new PVector();
    controller = new Controller(this);
  }

  void update() {  
    controller.readKeys();
    acceleration.mult(nullGravityModule);
    //velocity.mult(0.99);
    velocity.add(acceleration); 
    location.add(velocity);
    acceleration.set(0, 0, 0);    
    wrapAroundTheScreen();
  }

  void fire() {
    if (millis()> prevFireTime + fireCooldown) {
      PVector direction = (new PVector (cos(dir), sin(dir)));
      SpaceObject b = new SpaceObject((new PVector(location.x, location.y)).add(PVector.mult(direction, 30)), PVector.mult(direction, 8));   
      spaceObjects.add(b); 
      prevFireTime = millis();
    }
  }



  void display() {
    pushMatrix();

    // use the ship's locationition and dir when drawing it
    translate(location.x, location.y);
    rotate(dir+PI/2);

    noStroke();

    // draw the ship as a white triangle
    fill(255, 255, 0);  
    triangle(-10, 20, 10, 20, 0, -20); 

    // if the ship is accelerationerating, draw the thruster
    if (forcage) {
      // use a random color value so that the thruster is flickering 
      float thrusterCol = random(0, 255);
      fill(thrusterCol, thrusterCol/2, 0);
      triangle(-5, 22, 5, 22, 0, 40);
    }

    popMatrix();
  }

  void setaccelerationModule(float a) {
    accelerationModule = a;
  }
}