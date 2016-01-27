// SkolTech Augmented Reality Marathon
// ...
// Attractor and Mover classes inspired by Daniel Shiffman - http://natureofcode.com
// SpaceShip class by Tiago Martins - http://www.openprocessing.org/sketch/88665
// Kinect ...


//TODO control:
// multiplayer
// joystick
// KINECT
// inertial rotation 
// simultanious shooting and rotation


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

  //starfield = new Starfield(100);
  //sun = new Sun(width/2, height/2, 100);

  ships[0] = new SpaceShip();
  for (int i=0; i<planets.length; i++) {
    planets[i] = new Planet(new PVector(random(width), random(height)), 20);
  }
}

void draw() {
  background(0);
  //starfield.display();
  //sun.display();
  planets();
  ships();
  bullets();
}





void planets() {
  for (int i=0; i<planets.length; i++) {
    planets[i].drag();
    planets[i].hover(mouseX, mouseY);
    planets[i].display();
  }
}

void ships() {
  PVector attForce = new PVector();
  for (int i=0; i<planets.length; i++) {
    attForce.add(planets[i].attract(ships[0]));
  }
  ships[0].applyForce(attForce);
  ships[0].update();
  ships[0].display();
  if (isCollision(ships[0], planets)) {
    ships[0] = new SpaceShip();
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

    if (isCollision(m, planets)) {
      it.remove();
    }
  }
}


//TODO multistar crashs the code
boolean isCollision(Mover m, Attractor [] a) {
  if ((m.location.x > width || m.location.x < 0) || (m.location.y > height || m.location.y < 0)) {
    return true;
  }
  for (int i=0; i<planets.length; i++) {
    if ((sq(a[i].location.x-m.location.x)+sq(a[i].location.y-m.location.y)<sq(a[i].mass+m.radius))) {
      return true;
    }
  }
  return false;
}