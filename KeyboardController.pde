void keyPressed() {
  if (keyCode == LEFT) keys[0][0] = true;
  if (keyCode == RIGHT) keys[0][1] = true;
  if (keyCode == UP) keys[0][2] = true;
  if (key == DOWN) keys[0][3] = true;
  if (key == 32) keys[0][4] = true;
  if (key == '/' || key == '?') keys[0][5] = true;

  if (key == 'a' || key == 'A') keys[1][0] = true;
  if (key == 'd' || key == 'D') keys[1][1] = true;
  if (key == 'w' || key == 'W') keys[1][2] = true;
  if (key == 's' || key == 'S') keys[1][3] = true;
  if (key == 'g' || key == 'G') keys[1][4] = true;
  if (key == 'q' || key == 'Q') keys[1][5] = true;
}

void keyReleased() {
  if (keyCode == LEFT) keys[0][0] = false;
  if (keyCode == RIGHT) keys[0][1] = false;
  if (keyCode == UP) keys[0][2] = false;
  if (key == DOWN) keys[0][3] = false;
  if (key == 32) keys[0][4] = false;
  if (key == '/' || key == '?') keys[0][5] = false;

  if (key == 'a' || key == 'A') keys[1][0] = false;
  if (key == 'd' || key == 'D') keys[1][1] = false;
  if (key == 'w' || key == 'W') keys[1][2] = false;
  if (key == 's' || key == 'S') keys[1][3] = false;
  if (key == 'g' || key == 'G') keys[1][4] = false;
  if (key == 'q' || key == 'Q') keys[1][5] = false;
}


abstract class Controller {
  float turn = 0;
  float throttle   = 0;
  boolean isFire = false;
  boolean isRestart = false;

  abstract void readController();
}



boolean [][] keys = new boolean[2][6];

class KeyboardControllerCURSOR extends Controller {

  void readController() {     
    turn = 0;
    if (keys[0][0]) turn = -1;    
    if (keys[0][1]) turn = 1;
    if (keys[0][0] && keys[0][1]) turn = 0;   
    
    throttle=0;
    if (keys[0][2]) throttle = 1;
    if (keys[0][3]) throttle = -1;
    if (keys[0][2] && keys[0][3]) throttle = 0; 
    
    isFire = keys[0][4] ? true : false;
    isRestart = keys[0][5] ? true : false;   
  }
}


class KeyboardControllerWASD extends Controller {

  void readController() {
    turn = 0;
    if (keys[1][0]) turn = -1;    
    if (keys[1][1]) turn = 1;
    if (keys[1][0] && keys[1][1]) turn = 0;   
    
    throttle=0;
    if (keys[1][2]) throttle = 1;
    if (keys[1][3]) throttle = -1;
    if (keys[1][2] && keys[1][3]) throttle = 0; 
    
    isFire = keys[1][4] ? true : false;
    isRestart = keys[1][5] ? true : false;    
  }
}