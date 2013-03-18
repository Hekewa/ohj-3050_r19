

String typedText = "";
final String FONT = "Arial";
final int FONTSIZE = 32;
final int MAX_LASKURI = 60;

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

PImage taustaKuvat[] = new PImage[1];
PImage vihuKuvat[] = new PImage[1];
PImage torniKuvat[] = new PImage[1];
PFont f;

Kentta peliKentta = new Kentta();


void setup() {
  size(850, 500);
  smooth();
  f = createFont(FONT, FONTSIZE, true);
  peliKentta.alusta();
  for (int i = 0; i < taustaKuvat.length; i++){
    taustaKuvat[i] = loadImage("tausta" + nf(i+1, 2) + ".png");
  }for (int i = 0; i < vihuKuvat.length; i++){
    vihuKuvat[i] = loadImage("vihu" + nf(i+1, 2) + ".png");
  }for (int i = 0; i < torniKuvat.length; i++){
    torniKuvat[i] = loadImage("torni" + nf(i+1, 2) + ".png");
  }
  textFont(f,32);
}

void draw() { 
  switch(tila){
     case 0:
       image (taustaKuvat[0] ,0,0);
       fill(255,215,0);
       text("Tervetuloa, anna nimesi" , 35, 35);
       text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
       break;
    case 1:
      peliKentta.piirra();
      break;
  }
}

void keyPressed() {
  if (key >= 'a' && key <= 'z' ||
      key >= 'A' && key <= 'Z') {
    typedText+=char(key);
  }
  if (key != CODED) {
    switch(key) {
      case ENTER:
        if(tila == 0){
         tila = 1;
         time = millis();
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



     
