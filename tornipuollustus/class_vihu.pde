

public class Vihu {
  private Koordinaatti paikka_ = new Koordinaatti(0, 0);
  private float nopeus_ = 0.12;
  private int kestavyys_ = 0;

  public Vihu(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }

  public void piirra() {
    image(vihuKuvat[0], paikka_.x, paikka_.y); 
    paikka_.x += nopeus_;
    if (paikka_.x >= 800) {
      paikka_.x = 0;
    }
  }
}

