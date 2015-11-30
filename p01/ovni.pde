class ovni  {
  boolean flip = false;
  boolean bull = false;
  boolean shot = false;
  float vx;
  float xovni, yovni;
  float murpx, murpy;
  int count = 0;
  ovni(int x, int y, boolean toflip) {
    flip = toflip;
    xovni = x;
    vx=stage;
    yovni = y;
  }
  void display() {
 
    if (flip) {
      pushMatrix();
      if (shot)image(roast, xovni, yovni);
      else {
        scale(-1.0, 1.0);
        image(ovni, -xovni-40, yovni);
      }
      popMatrix();
      xovni-=vx;
    }
    else {
      pushMatrix();
      if (shot)image(roast, xovni, yovni);
      else image(ovni, xovni, yovni);
      popMatrix();
      xovni+=vx;
    }
    if (shot)yovni+=15;
 
 
    if (shot&&count<20) {
      count++;
      vx=0;
      image(explosion, murpx, murpy);
    }
  }
}