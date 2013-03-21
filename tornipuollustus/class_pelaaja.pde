//Pelaaja luokan toteutus

public class Pelaaja {
  private String nimi_ = "";
  private int rahat_ ;
  private int pisteet_;
  private int elama_;
  
  
  public Pelaaja(String nimi){
    nimi_ = nimi;
  }
  
  public void tulostaNimi() {
    text(nimi_, 35, 85);
  }
  
}
