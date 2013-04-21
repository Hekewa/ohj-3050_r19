//Torni luokan toteutus

public class Torni {
  public int hinta_ = 100;
  private int taso_ = 1;
  private int tulivoima_ = 0;
  private int kantama_ = 0;
  private int kuva_;

  private Koordinaatti paikka_ = new Koordinaatti(0, 0);


  public Torni(int X, int Y, int hinta, int taso, int kuva) {
    paikka_.x = X;
    paikka_.y = Y;
    hinta_ = hinta;
    taso_ = taso;
    kuva_ = kuva;
  }

  public void uusiPaikka(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }

  public Koordinaatti palautaPaikka() {
    return paikka_;
  }

  public void tulostaTiedot() {
    fill (255);
    text("Myyntihinta: "+ hinta_/2 + "  Taso: " + taso_ + " Tulivoima: " + tulivoima_ + " Kantomatka: " + kantama_, 10, 475);
  }


  public void piirra() {
    image(torniKuvat[kuva_], paikka_.x, paikka_.y);
  }
}

