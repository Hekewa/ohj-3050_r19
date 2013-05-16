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
  //Pelitilat: 0 Nimivalikko, 1 Tervetuloteksti, 2 Hirviöt lähestyy,
  //3 Varsinainen peli, 4 Peli loppuu, 5 Highscore-taulukko
  private int pelinTila_ = 0;
  //Kahden downcountin vaihtamisen tarkastelu millisekunteina
  private int countertime_ = 0;
  //Pelissä näkyvä laskuri, 0.5 sekuntia
  private int downcount_ = 0;
  //Tulleiden hirviöaaltojen määrä
  private int aaltonro = 1;
  //Käytetään aaltojen hirviöiden lisäämiseen
  private int lahetettavatVihut = 1;

  private int time_ = 0;
  //Tieto tornista, jota vedetään hiirellä
  private Torni kiskottava_ = null;

  //Puolustettava tukikohta
  private Tukikohta tukikohta_ = new Tukikohta(800, height/2, MAX_ELAMAT) ;

  public void alusta() {
    //Luodaan hirviöiden reitti, reitti määräytyy
    //mutkien koordinaattipisteiden mukaan
    reitti_.add(new Koordinaatti(0, height/2));
    reitti_.add(new Koordinaatti(300, height/2));
    reitti_.add(new Koordinaatti(300, 100));
    reitti_.add(new Koordinaatti(600, 100));
    reitti_.add(new Koordinaatti(600, 400));
    reitti_.add(new Koordinaatti(700, 400));
    reitti_.add(new Koordinaatti(700, height/2));
    reitti_.add(new Koordinaatti(800, height/2));
  }


  //  ========================================================================  
  public void piirra() {
    //Switch-case-rakenne pelin tilan mukaan
    switch(pelinTila_) {
      //Nimen valitseminen
    case 0:
      image (taustaKuvat[0], 0, 0);
      fill(255, 215, 0);
      text("Tervetuloa, anna nimesi", 35, 35);
      text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
      break;
      //Tervetulotoivotus
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
      //Odotetaan hetki ennen ensimmäisen hirviöaallon
      //lähetystä
    case 2:
      paivitaCounter();
      piirraKentta();
      fill(255, 215, 0);      
      textFont(f, 32);
      textAlign(CENTER);
      text("Hirviöt lähestyvät!", width/2, height/2);
      textAlign(LEFT);
      //Jos laskuri menee nollaan, aloitetaan peli
      if (downcount <= 0) {
        pelinTila_ = 3;
        countertime = millis();
        lisaaHirvioita(reitti_.get(0));
        downcount = MAX_LASKURI;
      }
      break;
      //Varsinainen peli, päivitetään ajastinta ja piirretään
      //kenttää
    case 3:
      fill(255, 215, 0);      
      textFont(f, 32);
      paivitaCounter();
      piirraKentta();
      break;
      //Peli loppuu
    case 4:
      textFont(f, 32);
      textAlign(CENTER);
      text("Hävisit pelin!", width/2, height/2);
      text("Paina ENTER nähdäksesi highscore-taulukon.", width/2+40, height/2+40);
      noLoop(); //Pysäytetään looppi hetkeksi, jatkuu enterillä
      textAlign(LEFT);
      break;
      //Highscore-valikko
    case 5:
      background(0, 0, 0);
      fill(255, 215, 0);
      textFont(f, 32);
      text("HIGHSCORES", 150, 40);
      //Tulostetaan arvot taulukosta, paras ensin 
      for (int i = 0; i < highscore.length; i++) {
        text(i+1 + ". " + highscore[i].nimi + "    " + highscore[i].pisteet
          + "pistettä", 150, i*40+80);
      }
      text("Sinun pisteesi: " + pelaaja_.palautaPisteet(), 500, 40);
    }
    return;
  }

  //Kentän piirtämiseen
  private void piirraKentta() {
    //Kuvien taakse harmaa tausta
    background(100);

    //Taustakuva kuvataulukosta
    image(taustaKuvat[1], 0, 0);

    //Tulostetaan ajastin- ja aaltotieto
    text("Aalto: " + aaltonro, 10, 30);
    text(downcount, 200, 30);

    //Reitin piirtäminen taustan päälle  
    piirraReitti();

    //Piirretään oikeaan laitaan ostettavien tornien alle
    //tumma laatikko
    stroke(0, 0, 0);
    strokeWeight(0);
    fill(40);
    rect(800, 0, 50, 500);

    //Piirretään myynnissä olevat tornit
    for (int i = 1; i < torniKuvat.length; i++) {
      image(torniKuvat[i], 820 - torniKuvat[i].width/2, i*30+10);
      //Toinen torni vasta, kun aalto 5 tai yli
      if (aaltonro < 5 && i == 1) {
        break;
      }
      //Kolmas torni, kun 10 tai yli
      if (aaltonro < 10 && i == 2) {
        break;
      }
    }
    
    //Piirretään jäljellä olevien elämien määr
    tukikohta_.piirraElamat();

    //Sekä pelaajatiedot
    fill(255, 215, 0);
    textFont(f, 20);
    pelaaja_.tulostaTiedot();
    
    
    //Piirretään kentällä olevat viholliset
    for ( int i = 0; i < viholliset_.size(); i++) {
      //Vihollisille annetaan reittitiedot
      Vihu tmp = viholliset_.get(i);
      int temp = viholliset_.get(i).liiku();
      //Mikäli päästään tukikohtaan, pelaaja menettää elämän
      if (temp >= reitti_.size()) {
        if (tukikohta_.menetaElama()) {
          pelinTila_ = 4;
        }
        //Ja vihollinen poistetaan pelistä
        viholliset_.get(i).kuole();
        viholliset_.remove(i);
        break;
      }
      //Mikäli reitillä on lisää mutkia, otetaan seuraava kohdepiste
      if (temp != 0) {
        viholliset_.get(i).uusiKohde(temp, reitti_.get(temp));
      }
      //Ja lopulta piirretään vihollinen
      tmp.piirra();
    }

    //Tornien piirtäminen
    for ( int i = 0; i < tornit_.size(); i++) {
      Torni tmp = tornit_.get(i);
      tmp.piirra();
      //Tarkastellaan voidaanko jotain vihollista ampua
      for (int k = 0; k < viholliset_.size(); ++k) {
        Vihu kohde = viholliset_.get(k);
        //Jos voidaan ampua
        if (tmp.ammu(kohde.palautaPaikka())) {
          if (viholliset_.get(k).vahennaKestavyytta(tmp.palautaTulivoima())) {
            //Saatu rahamäärä vähenee aaltoluvun mukaan
            int rahat = viholliset_.get(k).annaTapporaha()-int(2*aaltonro/5);
            if (rahat < 0) {
              rahat = 0;
            }
            //Pelaaja saa rahaa ja pisteitä tapoista
            int pisteet = viholliset_.get(k).annaTappopisteet();
            //Vihollinen poistetaan kentältä ja piirretään
            //kuolinkuva
            viholliset_.get(k).kuole();            
            viholliset_.remove(k);
            pelaaja_.lisaaRahaa(rahat, pisteet);
          }
        }
      }
      //Mikäli hiiri viedään ostettavien tornien päälle, niiden
      //tiedot tulostetaan näkyville
      fill(255, 215, 0);
      textFont(f, 20);
      if (mouseX > 800) {
        if ( mouseX <  833 && mouseX > 806
          && mouseY < 67 && mouseY > 40) {
          text("Ostohinta: 150 Taso: 1 Tulivoima: 10 Kantomatka: 75", 10, 475);
        }
      }
      if ( mouseX <  833 && mouseX > 806
        && mouseY < 97 && mouseY > 70
        && aaltonro > 5) {
        text("Ostohinta: 300 Taso: 1 Tulivoima: 30 Kantomatka: 50", 10, 475);
      }
      if ( mouseX <  833 && mouseX > 806
        && mouseY < 128 && mouseY > 100
        && aaltonro > 10) {
        text("Ostohinta: 250 Taso: 1 Tulivoima: 1 Kantomatka: 150", 10, 475);
      }
    }

    //Mikäli jotain tornia ollaan siirtämässä, tulostetaan
    //sen tiedot
    if (kiskottava_ != null) {
      kiskottava_.tulostaTiedot();
    }
  }

  //Mikäli jotain näppäintä painetaan näppäimistöltä
  public void nappainPainettu() {
    //Jos pelin aikana painetaan r aloitetaan peli uudelleen
    if (pelinTila_ == 3) {
      if (key == 'r' || key == 'R') {
        tukikohta_.nollaaElamat();
        for ( int i = 0; i < viholliset_.size(); i++) {
          viholliset_.remove(i);
        }
        for ( int i = 0; i < tornit_.size(); i++) {
          tornit_.remove(i);
        }
        pelaaja_.nollaa();
        pelinTila_ = 2;
        aaltonro = 1;
        downcount = START_COUNTER;
      }
    }
    //Jos pelintila on 2 tai 3 (muu kuin r) ja jotain painetaan, voidaan
    //siirtyä suoraan pois
    if (pelinTila_ != 0 && pelinTila_ != 4 && pelinTila_ != 5) {
      return;
    }

    //Jos kirjoitetaan nimeä
    if (pelinTila_ == 0) {
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

    //Jos halutaan siirtyä Highscore-taulukkoon
    if (pelinTila_ == 4 && key == ENTER) {
      pelinTila_ = 5;
      loop();
      int lisaaTahan = 15;
      for (int i = 0; i < highscore.length; i++) {
        if (highscore[i].pisteet < pelaaja_.palautaPisteet()) {
          lisaaTahan = i;
          break;
        }
      }
      if (lisaaTahan < 10 ) {
        Pisteet tmp1 = highscore[lisaaTahan];
        Pisteet tmp2 = null;
        highscore[lisaaTahan] = new Pisteet(pelaaja_.palautaNimi(), 
        pelaaja_.palautaPisteet());
        for (int i = lisaaTahan+1; i < highscore.length; i++) {
          tmp2 = highscore[i];
          highscore[i] = tmp1;
          tmp1 = tmp2;
        }
      }
      return;
    }
    //Jos halutaan siirtyä Highscoresta pois
    if (pelinTila_ == 5 && key == ENTER) {
      //Pelitietojen nollaus
      print(pelinTila_);
      pelaaja_.nollaa();
      aaltonro = 1;
      pelinTila_ = 0;
      tukikohta_.nollaaElamat();

      //Ennätysten kirjoittaminen taulukkoon
      String[] list = new String[10];
      for (int i = 0; i < highscore.length && i < 10 ; i++) {
        list[i] = highscore[i].nimi + " " + highscore[i].pisteet;
      }
      //Ja tallentaminen tiedostoon
      saveStrings(PISTETIEDOSTO, list);
      print("Tiedosto kirjoitettu");
    }
    //Tornien ja vihollisten nollaus
    for ( int i = 0; i < viholliset_.size(); i++) {
      viholliset_.remove(i);
    }
    for ( int i = 0; i < tornit_.size(); i++) {
      tornit_.remove(i);
    }
  }

  //Uuden tornin lisääminen tornityypin mukaan sekä oikean
  //rahasumman vähentäminen
  public Torni uusiTorni(int tornityyppi) {
    if (tornityyppi > 0 && tornityyppi < 4) {
      Torni uusTorni = new Torni(mouseX, mouseY, tornityyppi);
      if (pelaaja_.vahennaRahaa(uusTorni.hinta_)) {
        tornit_.add(uusTorni);
        return uusTorni;
      }
    }
    return null;
  }

  //Mikäli hiirtä liikutetaan ja jokin torni on valittu siirrettäväksi
  //päivitetään kyseisen tornin sijainti
  public void hiirtaLiikutettu() {
    if (kiskottava_ != null) {
      kiskottava_.uusiPaikka(mouseX-7, mouseY-7);
    }
  }

  //Hiiren painiketta on painettu
  public void hiirtaPainettu() {
    //Mikäli oikeaa hiirenpainiketta painetaan ja jokin
    //torni on valittu, myydään torni
    if (kiskottava_ != null && mouseButton == RIGHT) {
      pelaaja_.lisaaRahaa(kiskottava_.myyTorni(), 0);
      for (int i = 0; i < tornit_.size(); ++i) {
        if (tornit_.get(i) == kiskottava_) {
          tornit_.remove(i);
          kiskottava_ = null;
          break;
        }
      }
    }

    //Mikäli painetaan hiirtä ostettavien tornien päällä
    if (mouseX > 800 && kiskottava_ == null) {
      if ( mouseX <  833 && mouseX > 806
        && mouseY < 67 && mouseY > 40) {
        kiskottava_ = uusiTorni(1);
        if (kiskottava_ != null) {
          kiskottava_.kiskotaan(true);
        }
      }
      if ( mouseX <  833 && mouseX > 806
        && mouseY < 97 && mouseY > 70
        && aaltonro > 5) {
        kiskottava_ = uusiTorni(2);
        if (kiskottava_ != null) {
          kiskottava_.kiskotaan(true);
        }
      }
      if ( mouseX <  833 && mouseX > 806
        && mouseY < 128 && mouseY > 100
        && aaltonro > 10) {
        kiskottava_ = uusiTorni(3);
        if (kiskottava_ != null) {
          kiskottava_.kiskotaan(true);
        }
      }
    }
    //Jos mitään tornia ei ole valittu, tarkastetaan
    //onko kyseisessä kohdassa jokin torni ja otetaan se
    //valituksi
    else if ( kiskottava_ == null) {
      for ( int i = 0; i < tornit_.size(); i++) {
        Torni tmp = tornit_.get(i);
        Koordinaatti paikka = tmp.palautaPaikka();
        if ( mouseX < paikka.x+torniKuvat[1].width && mouseX > paikka.x
          && mouseY < paikka.y+torniKuvat[2].height && mouseY > paikka.y) {
          kiskottava_ = tmp;
          tmp.kiskotaan(true);
        }
      }
    }
    //Mikäli jotain tornia ollaan siirtämässä, tutkitaan
    //onko torni reitin päällä. Mikäli ei torni jää paikalle,
    //muutoin siirtoa ei sallita
    else if (kiskottava_ != null) {
      Koordinaatti edellinen;
      Koordinaatti seuraava;
      int leveys = 15;
      boolean onReitilla = false;
      //Reitti tutkitaan yksi siirtymäväli kerralla
      for (int i = 0; i < reitti_.size()-1; ++i) {
        edellinen = reitti_.get(i);
        seuraava = reitti_.get(i+1);
        if (edellinen.x == seuraava.x) {
          //suunta ylös
          if (edellinen.y > seuraava.y) { 
            if (abs(mouseX - edellinen.x) < leveys && (mouseY > seuraava.y - leveys
              && mouseY < edellinen.y + leveys)) { 
              onReitilla = true;
              break;
            }
          }
          //suunta alas
          else if (edellinen.y < seuraava.y) {
            if (abs(mouseX - edellinen.x) < leveys && (mouseY > edellinen.y + leveys
              && mouseY < seuraava.y - leveys)) {
              onReitilla = true;
              break;
            }
          }
        }

        else if (edellinen.y == seuraava.y) {
          //suunta vasemmalle
          if (edellinen.x > seuraava.x) { 
            if (abs(mouseY - edellinen.y) < leveys && (mouseX > seuraava.x - leveys
              && mouseX < edellinen.x + leveys)) { 
              onReitilla = true;
              break;
            }
          }
          //suunta oikealle
          else if (edellinen.x < seuraava.x) {
            if (abs(mouseY - edellinen.y) < leveys && (mouseX > edellinen.x + leveys
              && mouseX < seuraava.x - leveys)) {
              onReitilla = true;
              break;
            }
          }
        }
      }
      //Tornia yritetään jättää myyntialueelle
      if (!onReitilla && mouseX < 800) {
        for ( int i = 0; i < tornit_.size(); i++) {
          Torni tmp = tornit_.get(i);
          Koordinaatti paikka = tmp.palautaPaikka();
          if ( mouseX < paikka.x+torniKuvat[1].width && mouseX > paikka.x
            && mouseY < paikka.y+torniKuvat[2].height && mouseY > paikka.y) {
            if (kiskottava_ != tmp) {
              return;
            }
          }
        }
        kiskottava_.kiskotaan(false);
        kiskottava_ = null;
      }
    }
  }

  //Hirviön lisääminen, hirviötyyppi arvotaan
  public void lisaaHirvioita(Koordinaatti kohde) {
    Vihu uusvihu = new Vihu(0, height/2, int(random(1, 6)));
    uusvihu.uusiKohde(1, kohde);            
    viholliset_.add(uusvihu);
  } 

  //apufunktio alustusruudun tulostamiseen
  private void alustusRuutu() {
    image (taustaKuvat[0], 0, 0);
    fill(255, 215, 0);
    text("Tervetuloa, anna nimesi", 35, 35);
    text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
  }

  //Laskurin päivitys, lisää myös hirviöt tiettyjen aikavälien
  //mukaan
  private void paivitaCounter() {
    if (countertime+250 <= millis() ) {
      if (countertime+500 <= millis() ) {
        downcount -= 1;
        countertime = millis();
        if ((downcount % int(MAX_LASKURI/aaltonro)) == 0 && pelinTila_ == 3) {
          lahetettavatVihut = int(aaltonro/10+1);
        }
      }
      if (pelinTila_ == 3 && downcount >= 10) { 
        if (lahetettavatVihut != 0) {
          lisaaHirvioita(reitti_.get(0));
          --lahetettavatVihut;
        }
      }
    }
    //Mikäli laskuri menee nollaan, aloitetaan alusta
    if (downcount < 0) {
      downcount = MAX_LASKURI;
      int waittime = millis();
      lisaaHirvioita(reitti_.get(0));
      lahetettavatVihut = int(aaltonro/10+1);
      ++aaltonro;
    }
  }

  //Reitin piirtäminen
  private void piirraReitti() {
    stroke(139, 69, 20);
    strokeWeight(20);
    Koordinaatti edellinen;
    Koordinaatti seuraava;
    for (int i = 0; i < reitti_.size() - 1; ++i) {
      edellinen = reitti_.get(i);
      seuraava = reitti_.get(i+1);
      line (edellinen.x, edellinen.y, seuraava.x, seuraava.y);
    }
  }
}

