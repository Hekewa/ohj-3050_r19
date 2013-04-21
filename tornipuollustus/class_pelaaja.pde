//Pelaaja luokan toteutus

public class Pelaaja {
  public String nimi_ = "";
  private int rahat_ = 500;
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



  public void tulostaTiedot() {
    text("$" + rahat_, 801, 485);
  }
}

