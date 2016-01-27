// SkolTech Augmented Reality Marathon
// ...
// Attractor and Mover classes inspired by Daniel Shiffman - http://natureofcode.com
// SpaceShip class by Tiago Martins - http://www.openprocessing.org/sketch/88665
// Kinect ...


import java.util.*;

ArrayList<Mover> Movers = new ArrayList();
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
  //starfield.draw();
  //sun.draw();
  
  for (int i=0; i<planets.length; i++) {
    planets[i].drag();
    planets[i].hover(mouseX, mouseY);
    planets[i].display();
  }

  ships[0].update();
  ships[0].drawShip();


  Mover m;
  Iterator<Mover> it = Movers.iterator(); 
  while (it.hasNext()) {
    m = it.next();
    for (int i=0; i<planets.length; i++) {
      PVector force = planets[i].attract(m);
      m.applyForce(force);
      m.update();
      m.display();
      //TODO multistar will crash the code
      if (isCollision(m, planets[i])) it.remove();
    }
    if ((m.location.x > width || m.location.x < 0) || (m.location.y > height || m.location.y < 0)) {
      it.remove();
    }
  }
}

boolean isCollision(Mover m, Attractor a) {
  if ((sq(a.location.x-m.location.x)+sq(a.location.y-m.location.y)<sq(a.mass+m.radius))) {
    return true;
  }
  return false;
}