public class Vihu {
  private Koordinaatti paikka_ = new Koordinaatti(0, 0);
  private Koordinaatti kohde_ = new Koordinaatti(0, 0); 
  private float nopeus_;
  private int kestavyys_;
  private int kuva_;
  private int nykyinenKoordinaatti_ = 0;

  public Vihu(int X, int Y, int tyyppi) {
    paikka_.x = X;
    paikka_.y = Y;
    if (tyyppi == 1) {
      nopeus_ = 1;
      kestavyys_ = 20;
      kuva_ = 1;
    }
    else if (tyyppi == 2) {
      nopeus_ = 2;
      kestavyys_ = 10;
      kuva_ = 2;
    }
    else if (tyyppi == 3) {
      nopeus_ = 0.5;
      kestavyys_ = 50;
      kuva_ = 3;
    }
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
    

  public void piirra() {
    image(vihuKuvat[kuva_], paikka_.x - vihuKuvat[1].width/2, paikka_.y - vihuKuvat[1].height/2); 
  }
  
  public int liiku () {
    if (paikka_.x < kohde_.x) {
      paikka_.x += nopeus_;
      if (paikka_.x > kohde_.x) {
        paikka_.x = kohde_.x;
      }
    }
    if (paikka_.x > kohde_.x) {
      paikka_.x -= nopeus_;
      if (paikka_.x < kohde_.x) {
        paikka_.x = kohde_.x;
      }
    }
    if (paikka_.y > kohde_.y) {
      paikka_.y -= nopeus_;
      if (paikka_.y < kohde_.y) {
        paikka_.y = kohde_.y;
      }
    }
    if (paikka_.y < kohde_.y) {
     paikka_.y += nopeus_;
     if (paikka_.y > kohde_.y) {
        paikka_.y = kohde_.y;
      }
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

