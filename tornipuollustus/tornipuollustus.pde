String typedText = "";
final String FONT = "Arial";
final String PISTETIEDOSTO = "highscore.txt";
final int FONTSIZE = 32;
final int MAX_LASKURI = 60;
final int START_COUNTER = 15;
final int MAX_ELAMAT = 1;
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
PImage vihuKuvat[] = new PImage[4];
PImage torniKuvat[] = new PImage[4];
PFont f;

Kentta pelikentta = new Kentta();

public class Pisteet {
  public String nimi = "AAA";
  public int pisteet =  0;
  public Pisteet(String X, int Y){
    nimi = X;
    pisteet = Y;
  }
}

//Taulukko johon luetaan pisteet luetaan 
Pisteet highscore[] = new Pisteet[10];

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

  for (int i = 0; i < 10 ; i++) {  
    highscore[i] = new Pisteet("AAA", 0);
  }

  String lines[] = loadStrings(PISTETIEDOSTO);
  for (int i = 0; i < lines.length && i < 10 ; i++) {
    String[] tmp = split(lines[i], " ");
    highscore[i].nimi = tmp[0];
    highscore[i].pisteet = int(tmp[1]);
  }
}

void stop(){
  String[] list = new String[10];
  for (int i = 0; i < highscore.length && i < 10 ; i++) {
     list[i] = highscore[i].nimi + " " + highscore[i].pisteet;
  }
  saveStrings(PISTETIEDOSTO, list);
  print("lopeta");
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

