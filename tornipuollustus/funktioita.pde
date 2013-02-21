void alustusRuutu() {
  image(taustatKuva[0],0,0); 
  fill(200);
  text("Tervetuloa, anna nimesi" , 35, 35);
  text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
}

void piirraKentta() {
  background(0);
  image(taustatKuva[0],0,0);
  image(tornitKuva[0],100,100);
  image(vihutKuva[0],100,200);
  fill(200);  
  text("TOLOLOOOOOOOO!" , 35, 100);
  float x0 = 0;
  float y0 = 0;
  float x1 = width;
  float y1 = height;
  stroke(244, 32, 112);
  strokeWeight(4);
  line(x0, y0, x1, y1);
}
