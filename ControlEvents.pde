void keyPressed() {
  if (keyCode == LEFT)  ships[0].controller.isLeft = true;
  if (keyCode == RIGHT)  ships[0].controller.isRight = true;
  if (keyCode == UP)  ships[0].controller.isUp = true;
  if (key == DOWN)  ships[0].controller.isDown = true;
  if (key == 32)  ships[0].controller.isFire = true;
  if (key == '/')  ships[0].controller.isRestart = true;

  if (key == 'a')  ships[1].controller.isLeft = true;
  if (key == 'd')  ships[1].controller.isRight = true;
  if (key == 'w')  ships[1].controller.isUp = true;
  if (key == 's')  ships[1].controller.isDown = true;
  if (key == 'g')  ships[1].controller.isFire = true;
  if (key == 'q')  ships[1].controller.isRestart = true;
}

void keyReleased() {
 if (keyCode == LEFT)  ships[0].controller.isLeft = false;
  if (keyCode == RIGHT)  ships[0].controller.isRight = false;
  if (keyCode == UP)  ships[0].controller.isUp = false;
  if (key == DOWN)  ships[0].controller.isDown = false;
  if (key == 32)  ships[0].controller.isFire = false;
  if (key == '/')  ships[0].controller.isRestart = false;

  if (key == 'a')  ships[1].controller.isLeft = false;
  if (key == 'd')  ships[1].controller.isRight = false;
  if (key == 'w')  ships[1].controller.isUp = false;
  if (key == 's')  ships[1].controller.isDown = false;
  if (key == 'g')  ships[1].controller.isFire = false;
  if (key == 'q')  ships[1].controller.isRestart = false;
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
    if (sq(planets[i].location.x-mouseX)+sq(planets[i].location.y-mouseY) < sq(planets[i].mass) ) {
      planets[i].stopDragging();
    }
  }
}