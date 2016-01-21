// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

ArrayList<Mover> Movers = new ArrayList()  ;
Attractor[] a = new Attractor[7];
int n=1;
int fRate = 240;
  
void setup() {
  size(1920, 1080);
  Movers.add (new Mover(new PVector(700,400), new PVector(1,0)) ); 
  for (int i=0; i<n; i++) {
    //a[i] = new Attractor(new PVector(random(width), random(height)), 20);
    a[i] = new Attractor();
  }
  frameRate(fRate);
}

void draw() {
  background(255);
  for (Mover m : Movers)  {     
    for (int i=0; i<n; i++) {
      PVector force = a[i].attract(m);
      m.applyForce(force);
      m.update();
  
      a[i].drag();
      a[i].hover(mouseX, mouseY);
  
      a[i].display();
      m.display();
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i=0; i<n; i++) {
      if (pow((a[i].location.x-mouseX),2)+pow((a[i].location.y-mouseY),2)<pow((a[i].mass),2)) {
        a[i].clicked(mouseX, mouseY);
      }
    }
  }
  if (mouseButton == RIGHT) {
    Movers.add(new Mover(new PVector(0,10), new PVector(3,0)) );
  }
}

void mouseReleased() {
  for (int i=0; i<n; i++) {
    if (pow((a[i].location.x-mouseX),2)+pow((a[i].location.y-mouseY),2)<pow((a[i].mass),2)) {
      a[i].stopDragging();
    }
  }
}