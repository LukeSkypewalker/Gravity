class Bullet extends SpaceObject {

  Bullet(PVector loc, PVector vel) {
    super(loc, vel);
  }

  void update() {
    PVector attractionForce = new PVector();
    for (int i=0; i<planets.length; i++) {
      attractionForce.add(planets[i].attract(this));
    }
    applyForce(attractionForce);
    super.update();
  }

  boolean isCollision() {
    if ((location.x > width || location.x < 0) || (location.y > height || location.y < 0)) {
      return true;
    }

    for (int i=0; i<planets.length; i++) {
      if ((sq(planets[i].location.x-location.x)+sq(planets[i].location.y-location.y) < sq(planets[i].mass+mass))) {
        return true;
      }
    }

    for (int i=0; i<ships.length; i++) {
      if (ships[i] != null) {
        if ((sq(ships[i].location.x-location.x)+sq(ships[i].location.y-location.y) < sq(ships[i].mass+mass))) {
          ships[i].resetShip();
          return true;
        }
      }
    }
    return false;
  }
}