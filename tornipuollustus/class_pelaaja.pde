//Pelaaja luokan toteutus

public class Pelaaja {

  //Jäsenmuuttujat
  public String nimi_ = "";
  private int rahat_ = ALKURAHAT;
  private int pisteet_;
  private int elama_;

  //Rakentaja tarvitsee ainoastaan nimen
  public Pelaaja(String nimi) {
    nimi_ = nimi;
  }

  //Mikäli halutaan vähentää rahaa, nollan alle ei kuitenkaan
  //voi mennä
  public Boolean vahennaRahaa(int summa) {
    if (rahat_ - summa < 0 ) {
      return false;
    } 
    rahat_ -= summa;
    return true;
  }

  //Rahan ja pisteiden lisääminen
  public void lisaaRahaa (int summa, int pisteet) {
    rahat_ += summa;
    pisteet_+=pisteet;
  }

  //Getter
  public String palautaNimi() {
    return nimi_;
  }

  //Getter
  public int palautaPisteet() {
    return pisteet_;
  }

  //Pelaajan palauttaminen alkutilanteeseen
  public void nollaa () {
    rahat_ = ALKURAHAT;
    pisteet_ = 0;
  }

  //Pelaajan tietojen tulostaminen
  public void tulostaTiedot() {
    textAlign(RIGHT);
    text("$" + rahat_ + " Pisteet: " + pisteet_, 791, 485);
    textAlign(LEFT);
  }
}

