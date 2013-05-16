//Torni luokan toteutus

public class Torni {

  //Jäsenmuuttujat
  public int hinta_ = 100;
  private int taso_ = 1;
  private int tulivoima_ = 0;
  private int kantama_ = 0;
  private int kuva_;
  private int viive_;
  private int viimeksiAmmuttu_;
  private int tyyppi_;
  private boolean ollaankoAmpumassa_ = false;


  private boolean kiskotaan_ = false;

  private Koordinaatti ampumakohde_;
  private Koordinaatti paikka_ = new Koordinaatti(0, 0);

  //Rakentaja, tarvitaan tieto sijainnista ja tornin tyypistä 1..3
  public Torni(int X, int Y, int tyyppi) {
    //Jäsenmuuttuja alustetaan annetun tyypin mukaan
    if (tyyppi == 1) {
      paikka_.x = X;
      paikka_.y = Y;
      hinta_ = 150;
      taso_ = 1;
      kuva_ = 1;
      tulivoima_ = 10;
      kantama_ = 75;
      viive_ = 2500;
      tyyppi_ = 1;
    }
    if (tyyppi == 2) {
      paikka_.x = X;
      paikka_.y = Y;
      hinta_ = 300;
      taso_ = 1;
      kuva_ = 2;
      tulivoima_ = 35;
      kantama_ = 50;
      viive_ = 4000;
      tyyppi_ = 2;
    }
    if (tyyppi == 3) {
      paikka_.x = X;
      paikka_.y = Y;
      hinta_ = 250;
      taso_ = 1;
      kuva_ = 3;
      tulivoima_ = 1;
      kantama_ = 150;
      viive_ = 300;
      tyyppi_ = 3;
    }
  }

  //Tornin paikan vaihtaminen
  public void uusiPaikka(int X, int Y) {
    paikka_.x = X;
    paikka_.y = Y;
  }

  //Getter
  public Koordinaatti palautaPaikka() {
    return paikka_;
  }

  //Getter
  public int palautaTulivoima() {
    return tulivoima_;
  }

  //Tornin tietojen tulostus
  public void tulostaTiedot() {
    fill (255);
    text("Myyntihinta: "+ hinta_/2 + "  Taso: " + taso_ + " Tulivoima: " + tulivoima_ + " Kantomatka: " + kantama_, 10, 475);
  }

  //Tarkistetaan voiko torni ampua jotain kohdetta
  public boolean ammu (Koordinaatti kohde) {
    boolean palaute = false;
    //Tarkistetaan, että torni on ollut riittävän kauan ampumatta
    if ((millis() - viimeksiAmmuttu_) > viive_ && !kiskotaan_) {
      if (sqrt(pow((kohde.x - (paikka_.x+torniKuvat[2].width/2)), 2)+pow((kohde.y - (paikka_.y+torniKuvat[2].height/2)), 2)) < kantama_) {
        ampumakohde_ = kohde;
        ollaankoAmpumassa_ = true;
        viimeksiAmmuttu_ = millis();
        palaute = true;
      }
    }
    //Ampumisesta tuleva efekti riippuu tornityypistä
    //Efektiä varten on toteutettu lyhyt viive
    if (ollaankoAmpumassa_ && millis()-viimeksiAmmuttu_ < 75) {
      textAlign(CENTER);
      if (tyyppi_ == 1) {
        stroke(50, 50, 255);
        strokeWeight(15);  
        line(ampumakohde_.x, ampumakohde_.y, paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
        stroke(200, 200, 255);
        strokeWeight(5);  
        line(ampumakohde_.x, ampumakohde_.y, paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
        fill(0, 0, 64);      
        textFont(f, 32);
        text("PEW!", paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
      }
      if (tyyppi_ == 2) {
        stroke(255, 00, 0);
        strokeWeight(45);  
        line(ampumakohde_.x, ampumakohde_.y, paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
        stroke(255, 200, 200);
        strokeWeight(10);  
        line(ampumakohde_.x, ampumakohde_.y, paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
        fill(64, 0, 0);      
        textFont(f, 32);
        text("PEW!", paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
      }
      if (tyyppi_ == 3) {
        stroke(0, 255, 0);
        strokeWeight(10);  
        line(ampumakohde_.x, ampumakohde_.y, paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
        stroke(200, 255, 200);
        strokeWeight(3);  
        line(ampumakohde_.x, ampumakohde_.y, paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
        fill(0, 64, 0);      
        textFont(f, 32);
        text("PEW!", paikka_.x + torniKuvat[kuva_].width/2, paikka_.y + torniKuvat[kuva_].height/2);
      }
      textAlign(LEFT);
    }
    else {
      ollaankoAmpumassa_ = false;
    }
    return palaute;
  }

  //Tornin piirtäminen
  public void piirra() {
    image(torniKuvat[kuva_], paikka_.x, paikka_.y);
    if (kiskotaan_) {
      piirraSade();
    }
  }

  //Setter
  public void kiskotaan(boolean arvo) {
    kiskotaan_ = arvo;
  }

  //Säteen piirto kuvaa tornin kantamaa
  public void piirraSade() {
    ellipseMode(CENTER);
    fill(0, 0, 0, 0);
    stroke(255);
    strokeWeight(2);
    ellipse(paikka_.x+torniKuvat[2].width/2, paikka_.y+torniKuvat[2].height/2, kantama_*2, kantama_*2);
  }
  //Tornin myymishinnan palautus
  public int myyTorni() {
    return hinta_/2;
  }
}

