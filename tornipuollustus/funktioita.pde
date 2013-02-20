void alustusRuutu() {
  text("Tervetuloa, anna nimesi" , 35, 35);
  text(typedText+(frameCount/20 % 2 == 0 ? "_" : ""), 35, 85);
}

void piirraKentta() {
  image(images[0],0,10);
  fill(0, 102, 153);
  text("TROLOLOOOOOOOO!" , 35, 100);
}
