class Controller {
  SpaceShip ship;
  float totalAcceleration = 0.2; 

  Controller (SpaceShip s) {
    this.ship = s;
  }

  void setTotalAcceleration(float a) {
    this.totalAcceleration = a;
  }

  void readKeys() {

    if (keyPressed && key == CODED) {
      if (keyCode == LEFT) {
        ship.dir-=0.1;
      } else if (keyCode == RIGHT) {
        ship.dir+=0.1;
      }
      if (keyCode == UP) {         
        ship.acceleration.x = totalAcceleration * sin(ship.dir);  
        ship.acceleration.y = -totalAcceleration * cos(ship.dir);
      }
    }
  }
}