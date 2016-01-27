//SpaceShip class inspired by the Tiago Martins 
//http://www.openprocessing.org/sketch/88665

class SpaceShip {
  private PVector location;   
  private PVector velocity;  
  private PVector acceleration; 
  private float dir; 
  private Controller controller;

  SpaceShip() {
    location = new PVector(width/2, height/2, 0);
    velocity = new PVector();
    acceleration = new PVector();
    controller = new Controller(this);
  }

  void update() {

    acceleration.set(0, 0, 0);                     
    velocity.mult(0.99);
    controller.readKeys();
    velocity.add(acceleration);  // add the current accelerationeration to the current velocity
    location.add(velocity);    // add the current velocity to the current locationition
    //wrapAroundTheScreen();
  }





  void drawShip() {
    pushMatrix();

    // use the ship's locationition and dir when drawing it
    translate(location.x, location.y);
    rotate(dir);

    noStroke();

    // draw the ship as a white triangle
    fill(255);  
    triangle(-10, 20, 10, 20, 0, -20); 

    // if the ship is accelerationerating, draw the thruster
    if (acceleration.mag() != 0) {
      // use a random color value so that the thruster is flickering 
      float thrusterCol = random(0, 255);
      fill(thrusterCol, thrusterCol/2, 0);
      triangle(-5, 22, 5, 22, 0, 40);
    }

    popMatrix();
  }
}