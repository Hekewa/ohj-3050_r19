public class Vihu {
  private Koordinaatti paikka_ = new Koordinaatti(0, 0);
  private float nopeus_ = 0.5;
  private int kestavyys_ = 10;

  public Vihu(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }
  
  public Koordinaatti palautaPaikka () {
    return paikka_;
  }
  
  public boolean vahennaKestavyytta (int vahennys) {
    kestavyys_ -= vahennys;
    if (kestavyys_ < 0) {
      return true;
    }
    else {
      return false;
    }
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

