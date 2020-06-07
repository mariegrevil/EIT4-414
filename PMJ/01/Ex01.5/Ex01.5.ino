const int interruptPin = 2; //Knappen er sluttet til pin 2.
const int ledPin = 13; //Brug den indbyggede LED på pin 13.
bool state = 0; //Start med at være i stadie 0 (FALSE).
unsigned long lastTrigger = 0; //Gem hvornår der sidst skete et interrupt.

void ISR1 () {
  //Gem den nuværende tid.
  unsigned long newTrigger = micros();

  //Hvis der er gået lang nok tid (1 s = 1.000.000 µs)...
  if ((newTrigger - lastTrigger) > 1000000) {
    //...skift stadie når der sker et interrupt.
    state = !state;
    //...gem hvornår der sidst skete et interrupt.
    lastTrigger = newTrigger;
    //...skriv ud om LED bliver slået til eller fra.
    if (state == 0) {
      Serial.println("LED on");
    }
    else if (state == 1) {
      Serial.println("LED off");
    }
  }
}

void tick (int microSeconds) {
  
}

void setup() {
  Serial.begin(9600);
  pinMode(interruptPin, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT);
  
  //Kør ISR1 når knappen trykkes ned.
  attachInterrupt(digitalPinToInterrupt(interruptPin), ISR1, FALLING);
}

void loop() {
  //Skriv hele tiden stadiet til LED.
  digitalWrite(ledPin, state);
}
