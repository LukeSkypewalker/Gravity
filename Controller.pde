abstract class Controller {
  SpaceShip ship;
  float turn = 0;
  float throtle = 0;
  boolean isFire = false;
  boolean isRestart = false;

  Controller (SpaceShip s) {
    this.ship = s;
  }
    
  void readController() {
    ship.dir+= turn*0.05;
    ship.acceleration.x = throtle * ship.accelerationModule * cos(ship.dir);  
    ship.acceleration.y = throtle * ship.accelerationModule * sin(ship.dir); 
    ship.forcage = throtle > 0 ? true : false;
    if (isFire) { ship.fire();}
  }
  //abstract void readController();
}