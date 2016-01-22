// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
import java.util.*;

ArrayList<Mover> Movers = new ArrayList();
Player[] players = new Player[2];
Attractor[] a = new Attractor[16];
int n=5;
int fRate = 60;

void setup() {
  size(1920, 1080);
  Movers.add (new Mover(new PVector(600, 300), new PVector(1, 0)) ); 
  for (int i=0; i<n; i++) {
    a[i] = new Attractor(new PVector(random(width), random(height)), 20);
    //a[i] = new Attractor();
  }
  players[0] = new Player();
  players[1] = new Player();
  frameRate(fRate);
}

void draw() {
  background(255);
  for (int i=0; i<n; i++) {
    a[i].drag();
    a[i].hover(mouseX, mouseY);

    a[i].display();
  }
  
  for (int i=0; i<players.length; i++) {
    players[i].update();
    players[i].display();
  }

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
}

boolean isCollision(Mover m, Attractor a) {
  if ((pow((a.location.x-m.location.x), 2)+pow((a.location.y-m.location.y), 2)<pow((a.mass+m.radius), 2))) {
    return true;
  }
  return false;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i=0; i<n; i++) {
      if (pow((a[i].location.x-mouseX), 2)+pow((a[i].location.y-mouseY), 2)<pow((a[i].mass), 2)) {
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


void keyPressed() {
  if (keyPressed){
    switch (key){
      case 'w': players[0].fwd(); break;
      case 'a': players[0].left(); break;
      case 'd': players[0].right(); break;
    }
  }
}