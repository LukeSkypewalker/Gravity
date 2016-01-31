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
    if (sq(planets[i].location.x-mouseX)+sq(planets[i].location.y-mouseY) < sq(planets[i].mass) ) {
      planets[i].stopDragging();
    }
  }
}