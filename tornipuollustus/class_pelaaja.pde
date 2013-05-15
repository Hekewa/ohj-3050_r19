//Pelaaja luokan toteutus

public class Pelaaja {
  public String nimi_ = "";
  private int rahat_ = ALKURAHAT;
  private int pisteet_;
  private int elama_;


  public Pelaaja(String nimi) {
    nimi_ = nimi;
  }

  public Boolean vahennaRahaa(int summa) {
    if (rahat_ - summa < 0 ) {
      return false;
    } 
    rahat_ -= summa;
    return true;
  }
  
  public void lisaaRahaa (int summa) {
    rahat_ += summa;
    ++pisteet_; 
  }

  public void nollaa () {
    rahat_ = ALKURAHAT;
    pisteet_ = 0;
  }
  public void tulostaTiedot() {
    textAlign(RIGHT);
    text("$" + rahat_ + " Pisteet: " + pisteet_, 791, 485);
    textAlign(LEFT);
  }
}

