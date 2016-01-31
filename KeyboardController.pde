class KeyboardController extends Controller{
  
  KeyboardController (SpaceShip s) {
    super(s);
  }
  
}


void keyPressed() {
  if (keyCode == LEFT)  ships[0].controller.turn = -1;
  if (keyCode == RIGHT)  ships[0].controller.turn = 1;
  if (keyCode == UP)  ships[0].controller.throtle = 1;
  if (keyCode == DOWN)  ships[0].controller.throtle = -1;
  if (key == 32)  ships[0].controller.isFire = true;
  if (key == '/')  ships[0].resetShip();

  if (key == 'a')  ships[1].controller.turn = -1;
  if (key == 'd')  ships[1].controller.turn = 1;
  if (key == 'w')  ships[1].controller.throtle = 1;
  if (key == 's')  ships[1].controller.throtle = -1;
  if (key == 'g')  ships[1].controller.isFire = true;
  if (key == 'q')  ships[1].resetShip();
}

void keyReleased() {
  if (keyCode == LEFT)  ships[0].controller.turn = 0;
  if (keyCode == RIGHT)  ships[0].controller.turn = 0;
  if (keyCode == UP)  ships[0].controller.throtle = 0;
  if (keyCode == DOWN)  ships[0].controller.throtle = 0;
  if (key == 32)  ships[0].controller.isFire = false;
  if (key == '/')  ships[0].resetShip();

  if (key == 'a')  ships[1].controller.turn = 0;
  if (key == 'd')  ships[1].controller.turn = 0;
  if (key == 'w')  ships[1].controller.throtle = 0;
  if (key == 's')  ships[1].controller.throtle = 0;
  if (key == 'g')  ships[1].controller.isFire = false;
  if (key == 'q')  ships[1].resetShip();
}