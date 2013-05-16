public class Tukikohta {

  //Jäsenmuuttujat
  private int elamat_;
  private int x_;
  private int y_;

  //Rakentaja, tarvitsee sijainnin ja haluttujen eläminen määrän
  public Tukikohta (int x, int y, int elamat) {
    x_ = x;
    y_ = y;
    elamat_ = elamat;
  }

  //Tulostaa jäljellä olevien elämien määrän sekä tukikohdan
  public void piirraElamat() {
    fill(0, 0, 255);
    textFont(f, 24);
    textAlign(CENTER);
    text("Elämät: " + elamat_, 15*width/18, 15*height/16);
    textAlign(LEFT);
    image(tukikohtakuva[0], 760, 205);
  }

  //Vähennetään elämä, mikäli elämät loppuu palautetaan true
  //muutoin false
  public boolean menetaElama() {
    --elamat_;
    if (elamat_ <= 0) {
      return true;
    }
    else {
      return false;
    }
  }

  //Tukikohdan nollaaminen
  public void nollaaElamat() {
    elamat_ = MAX_ELAMAT;
  }
}

