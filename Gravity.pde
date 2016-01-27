// SkolTech Augmented Reality Marathon
// ...
// Attractor and Mover classes inspired by Daniel Shiffman - http://natureofcode.com
// SpaceShip class by Tiago Martins - http://www.openprocessing.org/sketch/88665
// Kinect ...


import java.util.*;

ArrayList<Mover> Movers = new ArrayList();
SpaceShip [] ships = new SpaceShip[1];
Star [] stars = new Star[5];


int fRate = 60;

void setup() {
  size(1920, 1080);
  
  ships[0] = new SpaceShip();
  

  //Movers.add (new Mover(new PVector(600, 300), new PVector(1, 0)) ); 
  for (int i=0; i<stars.length; i++) {
    stars[i] = new Star(new PVector(random(width), random(height)), 20);
  }
  frameRate(fRate);
}

void draw() {
  background(0);
  for (int i=0; i<stars.length; i++) {
    stars[i].drag();
    stars[i].hover(mouseX, mouseY);
    stars[i].display();
  }

  ships[0].update();
  ships[0].drawShip();
 

  Mover m;
  Iterator<Mover> it = Movers.iterator(); 
  while (it.hasNext()) {
    m = it.next();
    for (int i=0; i<stars.length; i++) {
      PVector force = stars[i].attract(m);
      m.applyForce(force);
      m.update();
      m.display();
      //TODO multistar will crash the code
      if (isCollision(m, stars[i])) it.remove();
    }
    if ((m.location.x > width || m.location.x < 0) || (m.location.y > height || m.location.y < 0)) {
      it.remove();
    }
  }

  //for (int i=0; i<players.length; i++) {
  //  players[i].update();
  //  players[i].display();
  //}
}

boolean isCollision(Mover m, Attractor a) {
  if ((sq(a.location.x-m.location.x)+sq(a.location.y-m.location.y)<sq(a.mass+m.radius))) {
    return true;
  }
  return false;
}



void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i=0; i<stars.length; i++) {
      if (sq(stars[i].location.x-mouseX)+sq(stars[i].location.y-mouseY) < sq(stars[i].mass) ) {
        stars[i].clicked(mouseX, mouseY);
      }
    }
  }
  if (mouseButton == RIGHT) {
    Movers.add(ships[0].fire());
  }
}

void mouseReleased() {
  for (int i=0; i<stars.length; i++) {
    if (sq(stars[i].location.x-mouseX)+sq(stars[i].location.y-mouseY) < sq(stars[i].mass) ) {
      stars[i].stopDragging();
    }
  }
}