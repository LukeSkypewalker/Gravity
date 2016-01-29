import processing.net.*;

class NetworkHandler {
  Client client;
  byte[] buffer;
  Planet[] planets;
  PApplet applet; String address; int port;
  
  NetworkHandler(PApplet _applet, String _address, int _port) {
    applet = _applet; address = _address; port = _port;
    client = new Client(applet, address, port);
    buffer = new byte[0];
    request();
  }
  
  void request() {
    client.write("{\"signature\": \"__planets_request\"}\n");
  }
  
  Planet[] getPlanets() {
    return planets;
  }
  
  Boolean update() {
    if (!client.active()) {
      client = new Client(applet, address, port);
      request();
      return false;
    }
    if (client.available() == 0)
      return false;
      
    byte[] cur_buffer = new byte[client.available()];
    client.readBytes(cur_buffer);
    buffer = expand(buffer, buffer.length + cur_buffer.length);
    arrayCopy(cur_buffer, 0, buffer, buffer.length - cur_buffer.length, cur_buffer.length); // append to the end
    
    JSONObject obj;
    try {
      obj = parseJSONObject(new String(buffer));
      buffer = expand(buffer, 0);
    } catch (Exception e) {
      obj = parseJSONObject("{\"signature\": \"__invalid\"}");
      print("Unable to parse correct JSON from: <<<");
      for (int i = 0; i < buffer.length; ++i)
        print((char)buffer[i]);
      print(">>>\n");
      return false;
    }
    
    // Example:
    // {"signature": "__planets",
    //  "planets": [
    //    {"points": [{"x": 100, "y": 100, "m": 100}]},
    //    {"points": [{"x": 50, "y": 20, "m": 5}]}
    //  ]}
    if (obj.getString("signature").equals("__planets")) {
      JSONArray all_planets = obj.getJSONArray("planets");
      planets = new Planet[all_planets.size()];
      
      for (int i = 0; i < all_planets.size(); ++i) {
        JSONObject planet = all_planets.getJSONObject(i);
        JSONArray points = planet.getJSONArray("points");
        JSONObject point = points.getJSONObject(0);
        int x = point.getInt("x");
        int y = point.getInt("y");
        int m = point.getInt("m");
        
        planets[i] = new Planet(new PVector(x, y), m);
      }
    }
    
    request();
    return true;
  }
}