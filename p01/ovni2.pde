class ovni2 {
  boolean flip = false;
  boolean shot = false;
  float vx;
  float xovni1, yovni1;
  ovni2(int x, int y) {
    xovni1 = x;
    vx=stage*2;
    yovni1 = y;
  }
  void display() {
    if (shot) {
      yovni1+=15;
      vx=0;
    }
    if (flip) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(ovni2, -xovni1, yovni1);
      popMatrix();
      xovni1-=vx;
    }
    else {
      pushMatrix();
      image(ovni2, xovni1, yovni1);
      popMatrix();
      xovni1+=vx;
    }
  }
}