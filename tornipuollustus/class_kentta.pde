//Kenttä luokan toteutus

public class Koordinaatti {
  public int x;
  public int y;
}

public class Kentta  {
  private ArrayList<Koordinaatti> reitti_ = new ArrayList<Koordinaatti>();
  private ArrayList<Vihu> viholliset_ = new ArrayList<Vihu>();
  private ArrayList<Torni> tornit_ = new ArrayList<Torni>();
  private Pelaaja pelaaja_ = new Pelaaja();
  private int pelinTila_ = 0;
  private int countertime_ = 0;
  private int downcount_ = 0;
  
  public void alusta(){
   
    
  }
    
  public void piirra(){
   switch(pelinTila_){
     case 0:
       image (taustaKuvat[0] ,0,0);
       text("Tervetuloa "+typedText, 35, 85);
       if((time+1000 - millis()) <= 0 ){
         pelinTila_ = 1;
         pelaaja_.alusta(typedText);
         countertime = millis();
       }       
       break;
     case 1:
       paivitaCounter();
       piirraKentta();
       break;
     }
    return;
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
  }
}

 
  
}
