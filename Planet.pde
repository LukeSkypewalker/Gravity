class Planet extends Attractor {

  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset = new PVector(0.0, 0.0);  // holds the offset for when object is clicked on

  Planet (PVector loc, float m) {
    super(loc, m);
    dragOffset = new PVector(0.0, 0.0);
  }

  void display() {
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    if (dragging) fill (175, 200);
    else if (rollover) fill(100);
    else fill(col);
    ellipse(location.x, location.y, mass*2, mass*2);
  }

  void clicked(int mx, int my) {
    float d = dist(mx, my, location.x, location.y);
    if (d < mass) {
      dragging = true;
      dragOffset.x = location.x-mx;
      dragOffset.y = location.y-my;
    }
  }

  void hover(int mx, int my) {
    float d = dist(mx, my, location.x, location.y);
    if (d < mass) {
      rollover = true;
    } else {
      rollover = false;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag() {
    if (dragging) {
      location.x = mouseX + dragOffset.x;
      location.y = mouseY + dragOffset.y;
    }
  }
}


void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i=0; i<planets.length; i++) {
      if (sq(planets[i].location.x-mouseX)+sq(planets[i].location.y-mouseY) < sq(planets[i].mass) ) {
        planets[i].clicked(mouseX, mouseY);
      }
    }
  }
}

void mouseReleased() {
  for (int i=0; i<planets.length; i++) {
    planets[i].stopDragging();
  }
}