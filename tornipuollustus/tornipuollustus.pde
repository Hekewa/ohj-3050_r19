String typedText = "";
final String FONT = "Arial";
final int FONTSIZE = 32;
final int MAX_LASKURI = 60;
final int START_COUNTER = 15;
final int MAX_ELAMAT = 5;
final int ALKURAHAT = 300;

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
PImage vihuKuvat[] = new PImage[2];
PImage torniKuvat[] = new PImage[2];
PFont f;

Kentta pelikentta = new Kentta();


void setup() {
  size(850, 500);
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
}

void draw() { 
  pelikentta.piirra();
}

void keyPressed() {
  pelikentta.nappainPainettu();
}

void mouseMoved() {
  pelikentta.hiirtaLiikutettu();
}

void mouseClicked() {
  pelikentta.hiirtaPainettu();
}

