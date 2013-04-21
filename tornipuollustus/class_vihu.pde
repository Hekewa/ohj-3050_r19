public class Vihu {
  private Koordinaatti paikka_ = new Koordinaatti(0, 0);
  private float nopeus_ = 0.5;
  private int kestavyys_ = 0;

  public Vihu(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }

  public boolean piirra() {
    image(vihuKuvat[1], paikka_.x - vihuKuvat[1].width/2, paikka_.y - vihuKuvat[1].height/2); 
    paikka_.x += nopeus_;
    if (paikka_.x >= 800) {
      return true;
    }
    return false;
  }
}

