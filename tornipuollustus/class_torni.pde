//Torni luokan toteutus

public class Torni {
  public int hinta_ = 100;
  private int taso_ = 1;
  private int tulivoima_ = 0;
  private int kantama_ = 0;
  private int kuva_;
  private int viive_;
  private int viimeksiAmmuttu_;

  private Koordinaatti paikka_ = new Koordinaatti(0, 0);


  public Torni(int X, int Y, int tyyppi) {
    if (tyyppi == 1) {
      paikka_.x = X;
      paikka_.y = Y;
      hinta_ = 100;
      taso_ = 1;
      kuva_ = 0;
      tulivoima_ = 5;
      kantama_ = 40;
      viive_ = 1000;
    }
     if (tyyppi == 2) {
      paikka_.x = X;
      paikka_.y = Y;
      hinta_ = 200;
      taso_ = 2;
      kuva_ = 1;
      tulivoima_ = 10;
      kantama_ = 50;
      viive_ = 2000;
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
    if ((millis() - viimeksiAmmuttu_) > viive_) {
      if (sqrt(pow((kohde.x - paikka_.x),2)+pow((kohde.y - paikka_.y),2)) < kantama_) {
        stroke(255);
        strokeWeight(20);  
        line(kohde.x, kohde.y, paikka_.x + torniKuvat[kuva_].width/2 , paikka_.y + torniKuvat[kuva_].height/2);
        viimeksiAmmuttu_ = millis();
        return true;
      }
    }
    return false;
  }
      

  public void piirra() {
    image(torniKuvat[kuva_], paikka_.x, paikka_.y);
  }
}

