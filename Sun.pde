

public class Sun {
 PImage img;
 int x, y;
  
 public Sun(int x, int y, int s) {
   img = makeTexture(s);
   this.x = x;
   this.y = y;
 }
  
 void draw() {
   blend(img, 0, 0, img.width, img.height, int(x) - img.width/2, int (y) - img.height/2, img.width, img.height, ADD);
 }
  
  
 PGraphics makeTexture(int r) {
   PGraphics res = createGraphics(r * 6, r * 6, P2D);
   res.beginDraw();
   res.loadPixels();
    
   for(int x = 0; x < res.width; x++) {
     for(int y = 0; y < res.height; y++) {
       float d = min(512, 50* sq(r / sqrt( sq( x - 3 * r) + sq(y - 3 * r))));
       res.pixels[y * res.width + x] = color ( min(255, d), min(255, d*0.8), d * 0.5);
     }
   }
   res.updatePixels();
   res.endDraw();
   return res;
 }
 
}