// SkolTech Augmented Reality Marathon
// ...
// Attractor and SpaceObject classes inspired by Daniel Shiffman - http://natureofcode.com
// SpaceShip class by Tiago Martins - http://www.openprocessing.org/sketch/88665
// Kinect ...

//TODO control:
// net multiplayer
// KINECT
// ? inertial rotation 

// does multistar(couple stars in same point) crashed the code ?

import java.util.*;

//NetworkHandler networkHandler;

ArrayList<SpaceObject> spaceObjects = new ArrayList();
SpaceShip [] ships = new SpaceShip[2];
Planet[] planets = new Planet[1];
//Starfield starfield;
//Sun sun;

int fRate = 60;


void setup() {
  //networkHandler = new NetworkHandler(this, "127.0.0.1", 12321);

  size(1920, 1080, P2D);
  frameRate(fRate);
  smooth();
  ships[0] = new SpaceShip( new PVector(100, 100));
  ships[0].setController(new KeyboardController(ships[0]));
  ships[1] = new SpaceShip(new PVector(1600, 80));
  ships[1].setController(new KeyboardController(ships[1]));
  ships[1].col = color (0, 255, 255);
  //ships[2] = new SpaceShip(new PVector(100, 800));
  //ships[2].setController(new JoystickController((ships[2]),"Controller (XBOX 360 For Windows)", "Button 0", 4, 1));  //0, 1
  //ships[2].col = color (0,255,0);
  //ships[3] = new SpaceShip(new PVector(1600, 800));
  //ships[3].setController(new JoystickController((ships[3]), "Defender COBRA M5 USB Joystick", "Button 1", 0, 1));
  //ships[3].col = color (255,128,0);
  //spaceObjects.add(ships[0]);

  //sun = new Sun(width/2, height/2, 100);
  //starfield = new Starfield(100);

  for (int i=0; i<planets.length; i++) {
    planets[i] = new Planet(new PVector(random(width), random(height)), random(10, 30));
    planets[i].col = color (random(0, 255), random(0, 255), random(0, 255));
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
      ships[j].update();
      ships[j].display();
    }
  }
}

void bullets() {
  SpaceObject m;
  Iterator<SpaceObject> it = spaceObjects.iterator(); 
  while (it.hasNext()) {
    m = it.next();   
    m.update();
    m.display();
    if (m.isCollision()) {
      it.remove();
    }
  }
}