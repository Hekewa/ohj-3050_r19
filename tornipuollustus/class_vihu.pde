public class Vihu {
  private Koordinaatti paikka_ = new Koordinaatti(0, 0);
  private Koordinaatti kohde_ = new Koordinaatti(0, 0); 
  private float nopeus_ = 0.5;
  private int kestavyys_ = 20;
  private int nykyinenKoordinaatti_ = 0;

  public Vihu(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }
  
  public Koordinaatti palautaPaikka () {
    return paikka_;
  }
  
  public boolean vahennaKestavyytta (int vahennys) {
    kestavyys_ -= vahennys;
    if (kestavyys_ <= 0) {
      return true;
    }
    else {
      return false;
    }
  }
    

  public boolean piirra() {
    image(vihuKuvat[1], paikka_.x - vihuKuvat[1].width/2, paikka_.y - vihuKuvat[1].height/2); 
     if (liiku() == -1) {
       return true;
     }
     return false;
  }
  
  public int liiku () {
    if (paikka_.x < kohde_.x) {
      paikka_.x += nopeus_;
    }
    if (paikka_.x > kohde_.x) {
      paikka_.x -= nopeus_;
    }
    if (paikka_.y > kohde_.y) {
      paikka_.y -= nopeus_;
    }
    if (paikka_.y < kohde_.y) {
     paikka_.y += nopeus_;
    }
    
    if (paikka_.y == kohde_.y && paikka_.x == kohde_.x) {
      ++nykyinenKoordinaatti_;
      return nykyinenKoordinaatti_;
    }
    return 0; 
  }
  public void uusiKohde(int kohdenro, Koordinaatti kohde) {
    if (kohdenro != 0) {
      kohde_ = kohde;
    }
  }
}

