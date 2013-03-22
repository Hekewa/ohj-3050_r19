//Torni luokan toteutus

public class Torni {
  public int hinta_ = 100;
  private int taso_ = 1;

  private Koordinaatti paikka_ = new Koordinaatti(0, 0);


  public Torni(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }

  public void uusiPaikka(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }

  public Koordinaatti palautaPaikka() {
    return paikka_;
  }

  public void tulostaTiedot() {
    text("Myyntihinta: "+ hinta_/2 + "  Taso: " + taso_, 10, 475);
  }


  public void piirra() {
    image(torniKuvat[0], paikka_.x, paikka_.y);
  }
}

