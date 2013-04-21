//Kenttä luokan toteutus

public class Koordinaatti {
  public float x;
  public float y;
  public Koordinaatti(float X, float Y) {
    x = X;
    y = Y;
  }
}

public class Kentta {
  private ArrayList<Koordinaatti> reitti_ = new ArrayList<Koordinaatti>();
  private ArrayList<Vihu> viholliset_ = new ArrayList<Vihu>();
  private ArrayList<Torni> tornit_ = new ArrayList<Torni>();
  private Pelaaja pelaaja_;
  private int pelinTila_ = 0;
  private int countertime_ = 0;
  private int downcount_ = 0;
  private int aaltonro = 1;
  private int lahetetytVihut = 1;
  private int time_ = 0;
  private Boolean dragTorni_ = false;
  private Torni kiskottava_ = null;
  private Tukikohta tukikohta_ = new Tukikohta(800, height/2, 20) ;

  public void alusta() {
  }


  //  ========================================================================  
  public void piirra() {
    switch(pelinTila_) {
    case 0:
      image (taustaKuvat[0], 0, 0);
      fill(255, 215, 0);
      text("Tervetuloa, anna nimesi", 35, 35);
      text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
      break;
    case 1:
      image (taustaKuvat[0], 0, 0);
      text("Tervetuloa "+pelaaja_.nimi_, 35, 85);
      if ((time_+1000 - millis()) <= 0 ) {
        pelinTila_ = 2;
        pelaaja_ = new Pelaaja(typedText);
        countertime = millis();
        downcount = START_COUNTER;
      }       
      break;
    case 2:
      paivitaCounter();
      piirraKentta();
      fill(255, 215, 0);      
      textFont(f, 32);
      textAlign(CENTER);
      text("Hirviöt lähestyvät!", width/2, height/2);
      textAlign(LEFT);
      if (downcount <= 0) {
        pelinTila_ = 3;
        countertime = millis();
        lisaaHirvioita();
        downcount = MAX_LASKURI;
      }
      break;
    case 3:
      fill(255, 215, 0);      
      textFont(f, 32);
      paivitaCounter();
      piirraKentta();
      break;
    case 4:
      textFont(f, 32);
      textAlign(CENTER);
      text("Hävisit pelin!",  width/2, height/2);
      textAlign(LEFT);
      break;
    }
    return;
  }

  //  ========================================================================
  //  
  private void piirraKentta() {
    background(100);
    image(taustaKuvat[1], 0, 0);

    text("Kenttä 1", 10, 30);
    text(downcount, 200, 30);
    stroke(139, 69, 20);
    strokeWeight(20);  
    line(0, height/2, 800, height/2);
    stroke(0, 0, 0);
    strokeWeight(0);
    fill(40);  
    rect(800, 0, 50, 500);
    for (int i = 0; i < torniKuvat.length; i++) {
      image(torniKuvat[i], 820 - torniKuvat[i].width/2, i*30+10);
    }
    for ( int i = 0; i < viholliset_.size(); i++) {
      Vihu tmp = viholliset_.get(i);
      tmp.piirra();
      if (tmp.piirra()) {
        if (tukikohta_.menetaElama()) {
          pelinTila_ = 4;
        }
        viholliset_.remove(i);
      }
    }
    for ( int i = 0; i < tornit_.size(); i++) {
      Torni tmp = tornit_.get(i);
      tmp.piirra();
    }
    
    tukikohta_.piirraElamat();

    fill(255, 215, 0);
    textFont(f, 20);
    pelaaja_.tulostaTiedot();

    if (kiskottava_ != null) {
      kiskottava_.tulostaTiedot();
    }
  }

  //  ========================================================================
  //
  public void nappainPainettu() {
    if (pelinTila_ != 0) {
      return;
    }
    if (key >= 'a' && key <= 'z' ||
      key >= 'A' && key <= 'Z') {
      typedText+=char(key);
    }
    if (key != CODED) {
      switch(key) {
      case ENTER:
        if (pelinTila_ == 0) {
          pelinTila_ = 1;
          time_ = millis();
          pelaaja_ = new Pelaaja(typedText);
        }
        break;
      case BACKSPACE:
        if (typedText.length() != 0) {
          typedText = typedText.substring(0, typedText.length() -1);
        }
        break;
      case ' ':
        typedText+=char(key);
        break;
      }
    }
  }

  //  ========================================================================
  //
  public Torni uusiTorni(int tornityyppi) {
    if (tornityyppi == 0) {
      Torni uusTorni = new Torni(mouseX, mouseY, 100, 1, 0);
        if (pelaaja_.vahennaRahaa(uusTorni.hinta_)) {
        tornit_.add(uusTorni);
        return uusTorni;
        }
    }
    else {
      Torni uusTorni = new Torni(mouseX, mouseY, 200, 2, 1);
        if (pelaaja_.vahennaRahaa(uusTorni.hinta_)) {
        tornit_.add(uusTorni);
        return uusTorni;
      }
    }
    return null;
  }

  //  ========================================================================
  //
  public void hiirtaLiikutettu() {
    if (kiskottava_ != null) {
      kiskottava_.uusiPaikka(mouseX-7, mouseY-7);
    }
  }


  //  ========================================================================
  //
  public void hiirtaPainettu() {
    if (mouseX > 800 && kiskottava_ == null) {
      if ( mouseX <  826 && mouseX > 813
          && mouseY < 22 && mouseY > 10) {
        kiskottava_ = uusiTorni(0);
       }
       if ( mouseX <  833 && mouseX > 806
          && mouseY < 68 && mouseY > 40) {
        kiskottava_ = uusiTorni(1);
       }
    }
    else if ( kiskottava_ == null ) {
      for ( int i = 0; i < tornit_.size(); i++) {
        Torni tmp = tornit_.get(i);
        Koordinaatti paikka = tmp.palautaPaikka();
        if ( mouseX < paikka.x+15 && mouseX > paikka.x
          && mouseY < paikka.y+15 && mouseY > paikka.y) {
          kiskottava_ = tmp;
        }
      }
    }
    else if (kiskottava_ != null && (mouseY < 240 || mouseY > 260) ) {
      kiskottava_ = null;
    }
  }


  //  ========================================================================
  //
  public void lisaaHirvioita() {
    Vihu uusvihu = new Vihu(0, height/2);
    viholliset_.add(uusvihu);
  } 



  //  ========================================================================
  //
  private void alustusRuutu() {
    image (taustaKuvat[0], 0, 0);
    fill(255, 215, 0);
    text("Tervetuloa, anna nimesi", 35, 35);
    text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
  }


  //  ========================================================================
  //
  private void paivitaCounter() {
    if (countertime+500 <= millis() ) {
      downcount -= 1;
      countertime = millis();
      if ((downcount % (MAX_LASKURI/aaltonro)) == 0 && pelinTila_ == 3) {
        lisaaHirvioita();
      }
    }
    if (downcount < 0) {
      downcount = MAX_LASKURI;
      int waittime = millis();
      lisaaHirvioita();
      lahetetytVihut = 1;
      ++aaltonro;
    }
  }
}

