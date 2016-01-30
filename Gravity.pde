// SkolTech Augmented Reality Marathon
// ...
// Attractor and SpaceObject classes inspired by Daniel Shiffman - http://natureofcode.com
// SpaceShip class by Tiago Martins - http://www.openprocessing.org/sketch/88665
// Kinect ...

//TODO control:
// multiplayer
// joystick
// KINECT
// ? inertial rotation 
// ? simultanious shooting and rotation

import java.util.*;

ArrayList<SpaceObject> spaceObjects = new ArrayList();
SpaceShip [] ships = new SpaceShip[4];
Planet[] planets = new Planet[5];
//Starfield starfield;
//Sun sun;
int fRate = 60;
boolean [][] keyz = new boolean [2][6];

NetworkHandler networkHandler;

void setup() {
  //networkHandler = new NetworkHandler(this, "127.0.0.1", 12321);

  size(1920, 1080, P2D);
  frameRate(fRate);
  smooth();
  ships[0] = new SpaceShip(new PVector(100, 100));
  ships[1] = new SpaceShip(new PVector(1600, 800));
  //spaceObjects.add(ships[0]);
  //ships[1] = new SpaceShip(new PVector(1800,900));
  for (int i=0; i<planets.length; i++) {
    planets[i] = new Planet(new PVector(random(width), random(height)), 20);
  }
}

void draw() {
  background(0);
  planets();
  ships();
  bullets();
}



void planets() {
  //if (networkHandler.update()) {
  //  planets = networkHandler.getPlanets();
  //}
  for (int i=0; i<planets.length; i++) {
    planets[i].drag();
    planets[i].hover(mouseX, mouseY);
    planets[i].display();
  }
}

void ships() {
  for (int j=0; j<ships.length; j++) {
    if (ships[j] != null) {
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
}

void bullets() {
  SpaceObject m;
  Iterator<SpaceObject> it = spaceObjects.iterator(); 
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
boolean isCollision(SpaceObject m) {
  if ((m.location.x > width || m.location.x < 0) || (m.location.y > height || m.location.y < 0)) {
    return true;
  }

  for (int i=0; i<planets.length; i++) {
    if ((sq(planets[i].location.x-m.location.x)+sq(planets[i].location.y-m.location.y) < sq(planets[i].mass+m.mass))) {
      return true;
    }
  }

  for (int i=0; i<ships.length; i++) {
    if (ships[i] != null) {
      if ((sq(ships[i].location.x-m.location.x)+sq(ships[i].location.y-m.location.y) < sq(ships[i].mass+m.mass))) {
        print("collision");
        ships[0] = new SpaceShip();
        return true;
      }
    }
  }
  return false;
}

boolean isCollisionShip(SpaceObject m) {
  for (int i=0; i<planets.length; i++) {
    if ((sq(planets[i].location.x-m.location.x)+sq(planets[i].location.y-m.location.y) < sq(planets[i].mass+m.mass))) {
      return true;
    }
  }
  return false;
}