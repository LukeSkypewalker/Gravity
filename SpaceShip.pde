class SpaceShip extends SpaceObject {

  private Controller controller;
  long prevFireTime = 0;
  long fireCooldown = 200;
  float nullGravityModule = 0.1;
  float accelerationModule = 0.2; 
  boolean forcage = false;
  PVector startLocation;
  //boolean isActive = false;

  SpaceShip(Controller controller, PVector loc, color col) {
    this.controller = controller;
    startLocation = new PVector (loc.x, loc.y);
    location = new PVector (loc.x, loc.y);
    velocity = new PVector();
    acceleration = new PVector();
    this.col = col;
  }

  void update() {  
    PVector attForce = new PVector();
    for (int i=0; i<planets.length; i++) {
      attForce.add(planets[i].attract(this));
    }
    readController();
    applyForce(attForce);

    if (isCollision()) {
      resetShip();
      return;
    }  

    acceleration.mult(nullGravityModule);
    //velocity.mult(0.99);
    wrapAroundTheScreen();
    super.update();
  }

  void readController() {
    controller.readController();
    dir+= controller.turn*0.05;
    acceleration.x = controller.throttle * accelerationModule * cos(dir);  
    acceleration.y = controller.throttle * accelerationModule * sin(dir); 
    forcage = controller.throttle > 0 ? true : false;
    if (controller.isFire) { 
      fire();
    }
    if (controller.isRestart) {
      resetShip();
    }
  }

  void fire() {
    if (millis()> prevFireTime + fireCooldown) {
      PVector direction = (new PVector (cos(dir), sin(dir)));
      Bullet b = new Bullet( (new PVector(location.x, location.y)).add(PVector.mult(direction, 30)), 
        PVector.mult(direction, 8+velocity.mag()) );   
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
    fill(col);  
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

  void setAccelerationModule(float a) {
    accelerationModule = a;
  }

  void setController(Controller controller) {
    this.controller = controller;
  }

  void resetShip() {
    location = startLocation.copy();
    velocity.set(0, 0);
    acceleration.set(0, 0);
    dir = 0;
  }

  boolean isCollision() {
    for (int i=0; i<planets.length; i++) {
      if ((sq(planets[i].location.x-location.x)+sq(planets[i].location.y-location.y) < sq(planets[i].mass+mass))) {
        return true;
      }
    }
    return false;
  }
}