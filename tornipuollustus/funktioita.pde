//


void alustusRuutu() {
   
  fill(255,215,0);
  text("Tervetuloa, anna nimesi" , 35, 35);
  text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
}

float vihunPaikkax = 0;

void piirraKentta() {
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
  image(torniKuvat[0],torniX,torniY);
  image(vihuKuvat[0],vihunPaikkax,45);
  vihunPaikkax += 0.1;
  if(vihunPaikkax == 650){
    vihunPaikkax = 0;
  }
}

//Päivittää hirviöaaltojen ilmestymistä merkkaavan laskimen
void paivitaCounter(){
  if(countertime+1000 <= millis() ){
    downcount -= 1;
    countertime = millis();
  }
  if(downcount < 0){
    downcount = MAX_LASKURI;
  }
}

