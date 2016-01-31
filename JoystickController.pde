//lagers.org.uk/gamecontrol/api.html
//"Controller (XBOX 360 For Windows)"
//"Wireless Controller"
//"Defender COBRA M5 USB Joystick"

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlIO control = ControlIO.getInstance(this);  

class JoystickController extends Controller {
  ControlDevice device;
  ControlButton button;
  ControlSlider Y, Z;

  JoystickController(String joystickName, String buttonName, int y, int z) {
    device = control.getDevice(joystickName);
    button = device.getButton(buttonName);
    Y = device.getSlider(y);
    Z = device.getSlider(z);
    Y.setTolerance(0.1);
    Z.setTolerance(0.1);
  }

  void readController() {
    turn=Z.getValue();
    throttle=-Y.getValue();
    isFire=button.pressed();
  }
}