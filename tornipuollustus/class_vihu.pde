public class Vihu {
  //Jäsenmuuttujat
  private Koordinaatti paikka_ = new Koordinaatti(0, 0);
  private Koordinaatti kohde_ = new Koordinaatti(0, 0); 
  private float nopeus_;
  private int kestavyys_;
  private int kuva_;
  private int nykyinenKoordinaatti_ = 0;
  private int tapporaha_;
  private int tappopisteet_;

  //Rakentaja, alkusijainti ja tyyppi
  public Vihu(int X, int Y, int tyyppi) {
    paikka_.x = X;
    paikka_.y = Y;

    //Hirviön ominaisuudet riippuu tyypistä
    if (tyyppi == 1) {
      nopeus_ = 1;
      kestavyys_ = 20;
      kuva_ = 1;
      tapporaha_ = 10;
      tappopisteet_ = 1;
    }
    else if (tyyppi == 2) {
      nopeus_ = 2;
      kestavyys_ = 10;
      kuva_ = 2;
      tapporaha_ = 5;
      tappopisteet_ = 2;
    }
    else if (tyyppi == 3) {
      nopeus_ = 0.5;
      kestavyys_ = 50;
      kuva_ = 3;
      tapporaha_ = 20;
      tappopisteet_ = 3;
    }
  }

  //Getter
  public Koordinaatti palautaPaikka () {
    return paikka_;
  }

  //Mikäli hirviöä ammutaan, palauttaa true, jos hirviö kuolee
  //muutoin false
  public boolean vahennaKestavyytta (int vahennys) {
    kestavyys_ -= vahennys;
    if (kestavyys_ <= 0) {
      return true;
    }
    else {
      return false;
    }
  }

  //Hirviön piirtäminen, kuva riippuu tyypistä
  public void piirra() {
    image(vihuKuvat[kuva_], paikka_.x - vihuKuvat[1].width/2, paikka_.y - vihuKuvat[1].height/2);
  }

  //Liikkuminen, siirtyy kohteeseen, siirtyessä palauttaa 0
  //jos saavuttaa kohteen palauttaa seuraavan reittipisteen
  //numeron
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
  //Seuraavan reittipisteen vaihtaminen
  public void uusiKohde(int kohdenro, Koordinaatti kohde) {
    if (kohdenro != 0) {
      kohde_ = kohde;
    }
  }

  //Getter
  public int annaTapporaha() {
    return tapporaha_;
  }

  //Getter
  public int annaTappopisteet() {
    return tappopisteet_;
  }

  //Efekti, joka tulostetaan hirviön kuollessa
  public void kuole() {
    fill(255, 255, 0);
    stroke(255, 0, 0);
    strokeWeight(20);
    ellipseMode(CENTER);
    ellipse(paikka_.x, paikka_.y, 35, 35);
  }
}

