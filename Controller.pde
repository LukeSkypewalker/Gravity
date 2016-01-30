class Controller {
  SpaceShip ship;
  boolean isLeft =false;
  boolean isRight =false;  
  boolean isUp =false;
  boolean isDown =false;
  boolean isFire =false;
  boolean isRestart =false;

  Controller (SpaceShip s) {
    this.ship = s;
  }

  void readKeys() {
    ship.forcage = false;
    if (isLeft) {
      ship.dir-=0.05;
    }
    if (isRight) {
      ship.dir+=0.05;
    }
    if (isUp) {         
      ship.acceleration.x = ship.accelerationModule * cos(ship.dir);  
      ship.acceleration.y = ship.accelerationModule * sin(ship.dir);
      ship.forcage = true;
    }
    if (isDown) {     
      ship.acceleration.x = -ship.accelerationModule * cos(ship.dir);  
      ship.acceleration.y = -ship.accelerationModule * sin(ship.dir);
    }
    if (isFire) {     
      ship.fire();
    }
  }
}