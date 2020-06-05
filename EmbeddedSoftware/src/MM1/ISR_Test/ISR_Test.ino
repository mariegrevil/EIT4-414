const int Knap = 2;
const int ledPin = 13;
int state = 0;
unsigned long TimePast;

//intl (fjerne bounc/pral)-----------------------------------------------------------
void ISR1() {
  if( 100 < (millis()-TimePast)){ //kontrolere om om det er mere end 100ms siden intruptet sidst blev kaldt
  TimePast = millis(); // ligger tidspunktet koden sidst blev kaldt over i "TimePast"
// Her under er selve SR
  state = !state; 
  Serial.println(state);
 
  }
}
//Setup-----------------------------------------------------------
void setup() {

  Serial.begin(115200);
  pinMode(ledPin, OUTPUT);
  pinMode(Knap, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(Knap), ISR1, LOW); //interrupt på pin 2, Klader ISR -> "ISR1", er aktivt low.
}

//Loop-------------------------------------------------------------

void loop() {
  digitalWrite(ledPin, state);
}
