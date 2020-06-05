const int Knap = 2;
const int ledPin = 13;
int state = 0;
unsigned long TimePast;

//intl (fjerne bounc/pral)-----------------------------------------------------------
void intl() {
  if( 100 < (millis()-TimePast)){ //To remove bouncing
  state = !state;
  Serial.println(state);
  //Serial.println("Test");
  TimePast = millis();
  }
}
//Setup-----------------------------------------------------------
void setup() {

  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(Knap, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(Knap), intl, LOW);
}

//Loop-------------------------------------------------------------

void loop() {
  digitalWrite(ledPin, state);
}
