// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover m;
Attractor[] a = new Attractor[7];
int n=2;
  
void setup() {
  size(1920, 1080);
  m = new Mover(new PVector(0,10), new PVector(3,0)); 
  for (int i=0; i<n; i++) {
    a[i] = new Attractor();
  }
  frameRate(120);
}

void draw() {
  background(255);
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

void mousePressed() {
  for (int i=0; i<n; i++) {
    if (pow((a[i].location.x-mouseX),2)+pow((a[i].location.y-mouseY),2)<pow((a[i].mass),2)) {
      a[i].clicked(mouseX, mouseY);
    }
  }
}

void mouseReleased() {
  for (int i=0; i<n; i++) {
    if (pow((a[i].location.x-mouseX),2)+pow((a[i].location.y-mouseY),2)<pow((a[i].mass),2)) {
      a[i].stopDragging();
    }
  }
}