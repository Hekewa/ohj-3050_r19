//Torni luokan toteutus

public class Torni {
  public int hinta_ = 100;
  private int taso_ = 1;
  private int tulivoima_ = 0;
  private int kantama_ = 0;
  private int kuva_;
  private int viive_;
  private int viimeksiAmmuttu_;
  private boolean ollaankoAmpumassa_ = false;


  private boolean kiskotaan_ = false;

  private Koordinaatti ampumakohde_;
  private Koordinaatti paikka_ = new Koordinaatti(0, 0);


  public Torni(int X, int Y, int tyyppi) {
    if (tyyppi == 1) {
      paikka_.x = X;
      paikka_.y = Y;
      hinta_ = 150;
      taso_ = 1;
      kuva_ = 1;
      tulivoima_ = 10;
      kantama_ = 100;
      viive_ = 2500;
    }
    if (tyyppi == 2) {
      paikka_.x = X;
      paikka_.y = Y;
      hinta_ = 400;
      taso_ = 1;
      kuva_ = 2;
      tulivoima_ = 20;
      kantama_ = 70;
      viive_ = 4000;
    }
    if (tyyppi == 3) {
      paikka_.x = X;
      paikka_.y = Y;
      hinta_ = 300;
      taso_ = 1;
      kuva_ = 3;
      tulivoima_ = 5;
      kantama_ = 150;
      viive_ = 1500;
    }
  }

  public void uusiPaikka(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }

  public Koordinaatti palautaPaikka() {
    return paikka_;
  }

  public int palautaTulivoima() {
    return tulivoima_;
  }

  public void tulostaTiedot() {
    fill (255);
    text("Myyntihinta: "+ hinta_/2 + "  Taso: " + taso_ + " Tulivoima: " + tulivoima_ + " Kantomatka: " + kantama_, 10, 475);
  }

  public boolean ammu (Koordinaatti kohde) {
    boolean palaute = false;
    if ((millis() - viimeksiAmmuttu_) > viive_ && !kiskotaan_) {
      if (sqrt(pow((kohde.x - (paikka_.x+torniKuvat[2].width/2)), 2)+pow((kohde.y - (paikka_.y+torniKuvat[2].height/2)), 2)) < kantama_) {
        ampumakohde_ = kohde;
        ollaankoAmpumassa_ = true;
        viimeksiAmmuttu_ = millis();
        palaute = true;
      }
    }
    if (ollaankoAmpumassa_ && millis()-viimeksiAmmuttu_ < 75) {
      stroke(50, 50, 255);
      strokeWeight(15);  
      line(ampumakohde_.x, ampumakohde_.y, paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
      fill(0, 0, 64);      
      textFont(f, 32);
      textAlign(CENTER);
      text("PEW!", paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
      textAlign(LEFT);
    }
    else {
      ollaankoAmpumassa_ = false;
    }
    return palaute;
  }


  public void piirra() {
    image(torniKuvat[kuva_], paikka_.x, paikka_.y);
    if (kiskotaan_) {
      piirraSade();
    }
  }

  public void kiskotaan(boolean arvo) {
    kiskotaan_ = arvo;
  }
  public void piirraSade() {
    ellipseMode(CENTER);
    fill(0, 0, 0, 0);
    stroke(255);
    strokeWeight(2);
    ellipse(paikka_.x+torniKuvat[2].width/2, paikka_.y+torniKuvat[2].height/2, kantama_*2, kantama_*2);
  }
  public int myyTorni() {
    return hinta_/2;
  }
}

