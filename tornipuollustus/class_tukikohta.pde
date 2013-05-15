public class Tukikohta {
  private int elamat_;
  private int x_;
  private int y_;
  
  public Tukikohta (int x, int y, int elamat) {
    x_ = x;
    y_ = y;
    elamat_ = elamat;
  }
  
  public void piirraElamat() {
    fill(0, 0, 255);
    textFont(f, 24);
    textAlign(CENTER);
    text("Elämät: " + elamat_, 15*width/18, 15*height/18);
    textAlign(LEFT);
    image(torniKuvat[1], 780, 235);
  }
  
  public boolean menetaElama() {
    --elamat_;
    if (elamat_ <= 0) {
      return true;
    }
    else {
      return false;
    }
  }
 
  public void nollaaElamat() {
    elamat_ = MAX_ELAMAT;
  }
}
