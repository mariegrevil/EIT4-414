unsigned long cyclic1;

void setup() {
  Serial.begin(115200);
  cyclic1 = millis(); // Sætttes til at starte på 0
}


int codeCyclic1()
{
delay(123); // mimic executio time
Serial.println("Kode eksekvered");
}
 
// beware of wrap around after 45 days


int kicker( int (*f)(), unsigned long *t, unsigned long per)
{
  if (millis()>= *t) { // Kontrolere om der er mere end 200 ms siden koden kørete sidst
    *t += per; // Ligger 200 til "cyclicl" variabel
    Serial.println(*t);
    return (*f)(); // Kalder koden "codeCyclicl" code
  }
  return -1;
}


void loop() {
  kicker(codeCyclic1 , &cyclic1 , 200);
}
