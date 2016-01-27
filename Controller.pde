class Controller {
  SpaceShip ship;
  float totalAcceleration = 0.1; 

  Controller (SpaceShip s) {
    this.ship = s;
  }

  void setTotalAcceleration(float a) {
    this.totalAcceleration = a;
  }

  void readKeys() {

    if (keyPressed) {
      if (keyCode == LEFT) {
        ship.dir-=0.05;
      }
      if (keyCode == RIGHT) {
        ship.dir+=0.05;
      }
      if (keyCode == UP) {         
        ship.acceleration.x = totalAcceleration * cos(ship.dir);  
        ship.acceleration.y = totalAcceleration * sin(ship.dir);
      }
      if (key == 32){     
        ship.fire();
      }
    }
  }
}



void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i=0; i<planets.length; i++) {
      if (sq(planets[i].location.x-mouseX)+sq(planets[i].location.y-mouseY) < sq(planets[i].mass) ) {
        planets[i].clicked(mouseX, mouseY);
      }
    }
  }
}

void mouseReleased() {
  for (int i=0; i<planets.length; i++) {
    if (sq(planets[i].location.x-mouseX)+sq(planets[i].location.y-mouseY) < sq(planets[i].mass) ) {
      planets[i].stopDragging();
    }
  }
}