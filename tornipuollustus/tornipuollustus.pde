import ddf.minim.*;

Minim minim;
AudioPlayer musiikki;

import processing.video.*;

String typedText = "";
final String FONT = "Arial";
final int FONTSIZE = 32;
final int MAX_LASKURI = 60;
final int START_COUNTER = 15;
final int MAX_ELAMAT = 5;
final int ALKURAHAT = 250;

final String PISTETIEDOSTO = "highscore.txt";

//Tila 0-n kertoo draw funktiolle mikä on ohjelman tila
//jotta osataan piirtää ruutu oikein.
int tila = 0; 
//Yleinen muuttuja eri tapahtumien ajoittamiselle
int time = millis();
//Muuttujat laskurille joka laskee MAX_LASKURISTA nollaan 
//ja kertoo
int downcount = MAX_LASKURI;
int countertime = 0;
//Muuttujat tornin paikalle 
int torniX = 600;
int torniY = 125;

PImage taustaKuvat[] = new PImage[2];
PImage vihuKuvat[] = new PImage[4];
PImage torniKuvat[] = new PImage[4];
PFont f;

//Luokka, johon pelaajan pisteet talletetaan
public class Pisteet {
  public String nimi = "AAA";
  public int pisteet =  0;
  public Pisteet(String X, int Y) {
    nimi = X;
    pisteet = Y;
  }
}

//Taulukko johon luetaan pisteet luetaan 
Pisteet highscore[] = new Pisteet[10];

Kentta pelikentta = new Kentta();

//Pelin alustaminen
void setup() {
  size(850, 500);

  //Musiikin alustaminen tiedostosta, musiikkilaitteen alustus
  minim = new Minim(this);
  musiikki = minim.loadFile("musiikki.mp3");

  //Kuvien lataaminen tiedostoista
  smooth();
  f = createFont(FONT, FONTSIZE, true);
  pelikentta.alusta();
  for (int i = 0; i < taustaKuvat.length; i++) {
    taustaKuvat[i] = loadImage("tausta" + nf(i+1, 2) + ".png");
  }
  for (int i = 0; i < vihuKuvat.length; i++) {
    vihuKuvat[i] = loadImage("vihu" + nf(i+1, 2) + ".png");
  }
  for (int i = 0; i < torniKuvat.length; i++) {
    torniKuvat[i] = loadImage("torni" + nf(i+1, 2) + ".png");
  }

  textFont(f, 32);
  for (int i = 0; i < 10 ; i++) {  
    highscore[i] = new Pisteet("AAA", 0);
  }
  //Ennätysten luku tiedostosta
  String lines[] = loadStrings(PISTETIEDOSTO);
  for (int i = 0; i < lines.length && i < 10 ; i++) {
    String[] tmp = split(lines[i], " ");
    highscore[i].nimi = tmp[0];
    highscore[i].pisteet = int(tmp[1]);
  }
  //Musiikin käynnistys
  musiikki.play();
  musiikki.loop();
}

//Piirto-looppi, toteutettu Kentta-classissa
void draw() { 
  pelikentta.piirra();
}

//Näppäimen painallus, toteutettu Kentta-classissa
void keyPressed() {
  pelikentta.nappainPainettu();
}

//Hiiren liikutus, toteutettu Kentta-classissa
void mouseMoved() {
  pelikentta.hiirtaLiikutettu();
}

//Hiiren painallus, toteutettu Kentta-classissa
void mouseClicked() {
  pelikentta.hiirtaPainettu();
}

//Toimenpiteet, kun ohjelma suljetaan
void stop() {
  //lopetaan musiikki
  musiikki.close();
  minim.stop();
  //Kirjoitetaan ennätykset tiedostoon
  String[] list = new String[10];
  for (int i = 0; i < highscore.length && i < 10 ; i++) {
    list[i] = highscore[i].nimi + " " + highscore[i].pisteet;
  }
  saveStrings(PISTETIEDOSTO, list);
  print("lopeta");
  super.stop();
}

