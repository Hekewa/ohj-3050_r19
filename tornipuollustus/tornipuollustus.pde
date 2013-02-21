// Testi -Saku
String typedText = "";
final String FONT = "Arial";
final int FONTSIZE = 32;

//Tila 0-n kertoo draw funktiolle mikä on ohjelman tila
//jotta osataan piirtää ruutu oikein.
int tila = 0; 
int time1 = millis();
int time2 = millis();

PImage taustatKuva[] = new PImage[1];
PImage vihutKuva[] = new PImage[1];
PImage tornitKuva[] = new PImage[1];
PFont f;


void setup() {
  size(850, 500);
  smooth();
  f = createFont(FONT, FONTSIZE, true);
  for (int i = 0; i < taustatKuva.length; i++){
    taustatKuva[i] = loadImage("tausta" + nf(i+1, 2) + ".png");
  }for (int i = 0; i < vihutKuva.length; i++){
    vihutKuva[i] = loadImage("vihu" + nf(i+1, 2) + ".png");
  }for (int i = 0; i < tornitKuva.length; i++){
    tornitKuva[i] = loadImage("torni" + nf(i+1, 2) + ".png");
  }
  textFont(f,32);
  fill(0);
}

void draw() { 
 switch(tila){
   case 0:
   alustusRuutu();
   break;
   case 1:
   image(taustatKuva[0],0,0);
   text("Tervetuloa "+typedText, 35, 85);
   if((time1+1000 - millis()) <= 0 ){
     tila = 2;
   }
   break;
   case 2:
   piirraKentta();
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
         time1 = millis();
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
        
