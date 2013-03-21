//Kenttä luokan toteutus

public class Koordinaatti {
  public int x;
  public int y;
  public Koordinaatti(int X, int Y){
    x = X;
    y = Y;
  }
}

public class Kentta  {
  private ArrayList<Koordinaatti> reitti_ = new ArrayList<Koordinaatti>();
  private ArrayList<Vihu> viholliset_ = new ArrayList<Vihu>();
  private ArrayList<Torni> tornit_ = new ArrayList<Torni>();
  private Pelaaja pelaaja_;
  private int pelinTila_ = 0;
  private int countertime_ = 0;
  private int downcount_ = 0;
  private int time_ = 0;
  
  public void alusta(){
   
    
  }
    
  public void piirra(){
   switch(pelinTila_){
     case 0:
       image (taustaKuvat[0] ,0,0);
       fill(255,215,0);
       text("Tervetuloa, anna nimesi" , 35, 35);
       text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
       break;
     case 1:
       image (taustaKuvat[0] ,0,0);
       text("Tervetuloa "+typedText, 35, 85);
       if((time+1000 - millis()) <= 0 ){
         pelinTila_ = 2;
         pelaaja_ = new Pelaaja(typedText);
         countertime = millis();
       }       
       break;
     case 2:
       paivitaCounter();
       piirraKentta();
       break;
     }
    return;
  }
  
  public void nappainPainettu() {
    if(pelinTila_ != 0){
      return;
    }
    if (key >= 'a' && key <= 'z' ||
        key >= 'A' && key <= 'Z') {
      typedText+=char(key);
    }
    if (key != CODED) {
      switch(key) {
        case ENTER:
          if(pelinTila_ == 0){
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
  
  public void hiirtaPainettu(){
    for( int i = 0; i < tornit_.size(); i++){
      
    }
  }
  public void lisaaHirvioita() {
      
   
  } 
  
  private void piirraKentta() {
    background(0);
    image(taustaKuvat[0],0,0);
  
    text("Kenttä 1", 10, 30);
    text(downcount, 200, 30);
    stroke(244, 32, 112);
    strokeWeight(10);  
    strokeJoin(ROUND);
    beginShape();
    line(0, 50, 700, 50);
    line(700, 50, 700, 200);
    line(700, 200, 50, 200);
    line(50, 200, 50, 300);
    line(50, 300, 350, 300);
    line(350, 300, 350, 500);
    endShape();
  
   
   
}
  
  
  private void alustusRuutu() {
    image (taustaKuvat[0] ,0,0);
    fill(255,215,0);
    text("Tervetuloa, anna nimesi" , 35, 35);
    text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
  }
 
 private void paivitaCounter(){
  if(countertime+1000 <= millis() ){
    downcount -= 1;
    countertime = millis();
  }
  if(downcount < 0){
    downcount = MAX_LASKURI;
    lisaaHirvioita();
  }
}

 
  
}
