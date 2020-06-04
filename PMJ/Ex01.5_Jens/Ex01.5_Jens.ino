unsigned long cyclic1; //Tidspunkt for næste deadline.

void setup() {
  Serial.begin(115200);
  cyclic1 = millis(); //Start med at gemme setuptidspunktet som sidste deadline.
}

//Den kode der skal udføres af kickeren. Den simulerer et program der her tager 100 ms.
int codeCyclic1()
{
  Serial.println("Code has begun executing");
  delay(100); //Lad som om der udføres en masse spændende kode her.
  Serial.println("Code has finished executing");
}

//Kicker kan aktivere andre funktioner med bestemte intervaller.
//(*f)() er adressen til den funktion der skal udføres.
//*t er adressen til den variabel, der gemmer næste deadline.
//per er periodetid, dvs. hvor lang tid (ms) der skal gå imellem deadlines.
int kicker(int (*f)(), unsigned long *t, unsigned long per)
{
  //Hvis nuværende tid + periodetid er større end næste deadline...
  if (millis() + per >= *t) {
    *t += per; //...så læg perioden til forrige deadline for at give den ny deadline.
    return (*f)(); //Udfør den valgte kode.
  }
  return -1; //Skal bare afslutte funktionen uden at gøre noget.
}
//cyclic  millis  millis+per
//132     132     332       kickeren kører fordi millis+per > cyclic
//332     232     432       kickeren kører fordi millis+per > cyclic
//532     332     532       kickeren kører fordi millis+per = cyclic
//732     432     632       kickeren kører IKKE fordi millis+per < cyclic
//732     442     642       kickeren kører STADIG IKKE fordi millis+per < cyclic
//(millis fortsætter med at stige indtil millis+per er større end eller lig med cyclic)
//732     531     731       venter stadig på at millis+per >= cyclic...
//732     532     732       kickeren kører fordi millis+per > cyclic
//932     632     832       kickeren kører IKKE fordi millis+per < cyclic

void loop() {
  //Kør kickeren, så den udfører codeCyclic1 hver 200 ms. deadlineen findes i cyclic1.
  kicker(codeCyclic1 , &cyclic1 , 200);
}
