String input = "";
final String FONT = "Arial";
final int FONTSIZE = 32;

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
 text(input, 20, 50);
}

void keyPressed() {
  if (key >= 'a' && key <= 'z' ||
      key >= 'A' && key <= 'Z') {
    input+=char(key);
  }
  if (key != CODED) {
    switch(key) {
      case ENTER:
        String tervetuloa = "Tervetuloa ";
        tervetuloa+=input;
        tervetuloa+="!";
        text(tervetuloa, 64,64);
        break;
      case BACKSPACE:
        if (input.length() != 0) {
        input = input.substring(0, input.length() -1);
        }
        break;
      case ' ':
        input+=char(key);
        break;
    }
  }
}
        
