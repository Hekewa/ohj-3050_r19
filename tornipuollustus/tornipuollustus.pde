// Testi -Saku
String typedText = "";
final String FONT = "Arial";
final int FONTSIZE = 32;

//Tila 0-n kertoo draw funktiolle mikä on ohjelman tila
//jotta osataan piirtää ruutu oikein.
int tila = 0; 
int time1 = millis();
int time2 = millis();

PFont f;


void setup() {
  size(640, 360 );
  smooth();
  f = createFont(FONT, FONTSIZE, true);
  textFont(f,32);
  fill(0);
}

void draw() { 
 background(255);
 switch(tila){
   case 0:
   alustusRuutu();
   break;
   case 1:
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
        tila = 1;
        time1 = millis();
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
        
