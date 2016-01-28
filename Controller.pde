class Controller {
  SpaceShip ship;
  float totalAcceleration = 0.1; 

  Controller (SpaceShip s) {
    this.ship = s;
  }

  void setTotalAcceleration(float a) {
    this.totalAcceleration = a;
  }


void keyPressed() {
  if (key == 'a')  keyz[0] = true;
  if (key == 'd')  keyz[1] = true;
  if (key == 'w')  keyz[2] = true;
  if (key == 's')  keyz[3] = true;
  if (key == 'f')  keyz[4] = true;
}

void keyReleased() {
  if (key == 'a')  keyz[0] = false;
  if (key == 'd')  keyz[1] = false;
  if (key == 'w')  keyz[2] = false;
  if (key == 's')  keyz[3] = false;
  if (key == 'f')  keyz[4] = false;
}


  void readKeys() {
    ship.forcage = false;
    if (keyz[0]) {
      ship.dir-=0.05;
    }
    if (keyz[1]) {
      ship.dir+=0.05;
    }
    if (keyz[2]) {         
      ship.acceleration.x = totalAcceleration * cos(ship.dir);  
      ship.acceleration.y = totalAcceleration * sin(ship.dir);
      ship.forcage = true;
    }
    if (keyz[4]) {     
      ship.fire();
    }
    if (keyz[3] ) {     
      ships[0] = new SpaceShip();
      //movers.add(ships[0]);
    }
  }


  void readKeys2() {
    ship.forcage = false;

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
        ship.forcage = true;
      }
      if (key == 32) {     
        ship.fire();
      }
      if (key == 'a' ) {     
        ships[0] = new SpaceShip();
        //movers.add(ships[0]);
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