// SkolTech Augmented Reality Marathon
// ...
// Attractor and Mover classes inspired by Daniel Shiffman - http://natureofcode.com
// SpaceShip class by Tiago Martins - http://www.openprocessing.org/sketch/88665
// Kinect ...

//TODO control:
// multiplayer
// joystick
// KINECT
// ? inertial rotation 
// ? simultanious shooting and rotation
boolean [] keyz = new boolean [5];

import java.util.*;

ArrayList<Mover> movers = new ArrayList();
SpaceShip [] ships = new SpaceShip[1];
Planet [] planets = new Planet[5];
//Starfield starfield;
//Sun sun;
int fRate = 60;

void setup() {
  size(1920, 1080, P2D);
  frameRate(fRate);
  smooth();

  ships[0] = new SpaceShip(new PVector(100,100));
  //ships[1] = new SpaceShip(new PVector(1800,900));
  for (int i=0; i<planets.length; i++) {
    planets[i] = new Planet(new PVector(random(width), random(height)), 20);
  }
}

void draw() {
  //background(0);
  //planets();
  //ships();
  //bullets();
    background(80);
  for (int i = 0; i < keyz.length; i++) {
    if (keyz[i]) {
      rect(i*100, width/2, 100, 50);
    }
  }
}





void planets() {
  for (int i=0; i<planets.length; i++) {
    planets[i].drag();
    planets[i].hover(mouseX, mouseY);
    planets[i].display();
  }
}

void ships() {
  for (int j=0; j<ships.length; j++) {
    PVector attForce = new PVector();
    for (int i=0; i<planets.length; i++) {
      attForce.add(planets[i].attract(ships[j]));
    }
    ships[j].applyForce(attForce);
    ships[j].update();
    ships[j].display();
    if (isCollisionShip(ships[j])) {
      ships[j] = new SpaceShip();
    }
  }
}

void bullets() {
  Mover m;
  Iterator<Mover> it = movers.iterator(); 
  while (it.hasNext()) {
    m = it.next();
    PVector attractionForce = new PVector();
    for (int i=0; i<planets.length; i++) {
      attractionForce.add(planets[i].attract(m));
    }
    m.applyForce(attractionForce);
    m.update();
    m.display();

    if (isCollision(m)) {
      it.remove();
    }
  }
}


//TODO multistar crashs the code
boolean isCollision(Mover m) {
  if ((m.location.x > width || m.location.x < 0) || (m.location.y > height || m.location.y < 0)) {
    return true;
  }
  
  for (int i=0; i<planets.length; i++) {
    if ((sq(planets[i].location.x-m.location.x)+sq(planets[i].location.y-m.location.y) < sq(planets[i].mass+m.mass))) {
      return true;
    }
  }
  
  for (int i=0; i<ships.length; i++) {
   if ((sq(ships[i].location.x-m.location.x)+sq(ships[i].location.y-m.location.y) < sq(ships[i].mass+m.mass))) {
     print("collision");
     ships[0] = new SpaceShip();
     return true;
   }
  }
  return false;
}

boolean isCollisionShip(Mover m) {
  for (int i=0; i<planets.length; i++) {
    if ((sq(planets[i].location.x-m.location.x)+sq(planets[i].location.y-m.location.y) < sq(planets[i].mass+m.mass))) {
      return true;
    }
  }
  return false;
}