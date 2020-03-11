unsigned long cyclic1;

void setup() {
  Serial.begin(115200);
  cyclic1 = millis(); 
}


int codeCyclic1()
{
delay(123); // mimic executio time
  //BUGPRINT("1 ");
}
 
// std kicker
// beware of wrap around after 45 days


int kicker( int (*f)(), unsigned long *t, unsigned long per)
{
  if (millis() + per >= *t) {
    *t += per;
    return (*f)(); // code
  }
  return -1;
}

void dokick()
{
  kicker(codeCyclic1 , &cyclic1 , 200);
  Serial.println("Hej--Hej");
}

void loop() {
  dokick();
}
