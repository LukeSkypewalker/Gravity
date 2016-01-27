// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
import java.util.*;

ArrayList<Mover> Movers = new ArrayList();
//SpaceShip [] ships = new SpaceShip[1];
Star [] a = new Star[16];
SpaceShip ship;
int n=2;
int fRate = 60;

void setup() {
  size(1920, 1080);
  
  ship = new SpaceShip();
  

  Movers.add (new Mover(new PVector(600, 300), new PVector(1, 0)) ); 
  for (int i=0; i<n; i++) {
    a[i] = new Star(new PVector(random(width), random(height)), 20);
  }
  frameRate(fRate);
}

void draw() {
  background(0);
  for (int i=0; i<n; i++) {
    a[i].drag();
    a[i].hover(mouseX, mouseY);
    a[i].display();
  }

  ship.update();
  ship.drawShip();
 

  Mover m;
  Iterator<Mover> it = Movers.iterator(); 
  while (it.hasNext()) {
    m = it.next();
    for (int i=0; i<n; i++) {
      PVector force = a[i].attract(m);
      m.applyForce(force);
      m.update();
      m.display();
      //TODO multistar will crash the code
      if (isCollision(m, a[i])) it.remove();
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
    for (int i=0; i<n; i++) {
      if (sq(a[i].location.x-mouseX)+sq(a[i].location.y-mouseY) < sq(a[i].mass) ) {
        a[i].clicked(mouseX, mouseY);
      }
    }
  }
  if (mouseButton == RIGHT) {
    Movers.add(new Mover(new PVector(0, 10), new PVector(1, 0)) );
  }
}

void mouseReleased() {
  for (int i=0; i<n; i++) {
    if (pow((a[i].location.x-mouseX), 2)+pow((a[i].location.y-mouseY), 2)<pow((a[i].mass), 2)) {
      a[i].stopDragging();
    }
  }
}