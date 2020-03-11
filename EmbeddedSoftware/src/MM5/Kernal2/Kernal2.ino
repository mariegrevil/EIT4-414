#include <krnl.h>
unsigned long TimePast;
struct k_t *pt1, *pt2; //pointer to hold refrenc task 1;
struct k_t *timerTick1;

#define STK 200 //stak size
#define tickspeed 10

char s1[STK], s2[STK]; //stak for task 1

void ISR1() {
  if( 150 < (millis()-TimePast)){ //To remove bouncing
  Serial.println("ISR1 ran");
  TimePast = millis();
  }
}

void t1(void) {
  while (1) {
      k_wait(timerTick1,1);
    Serial.println("Hello world");
    k_eat_msec_time(300);
    k_sleep(100); // delay that is not a delay, corse bq delay is active wating.
     k_signal(timerTick1);
  }
}

void t2(void) {
  while (1) {
    Serial.println("blink blink");
    if (digitalRead(13)==HIGH){
     digitalWrite(13,LOW); 
    }
    else{
    digitalWrite(13,HIGH);
    }
     k_eat_msec_time(100);
    k_sleep(30); // delay that is not a delay, corse bq delay is active wating.
  }
}

void setup() {
  Serial.begin(9600);
  for (int i = 8; i < 14; i++) {
    pinMode(i, OUTPUT);
  }
  pinMode(2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(2), ISR1, LOW);
 
  k_init(2, 1, 0); //how menny threds to inetilize
  pt1 = k_crt_task(t1, 2, s1, STK); //Funktion, priority, stack array, stack size
  pt2 = k_crt_task(t2, 1, s2, STK); //Funktion, priority, stack array, stack size

  timerTick1 = k_crt_sem(0, 10);
  
  k_start(tickspeed); // start kernal with "tickspeed" in milli sec
}

extern "C" {
  void k_breakout() // called every task shift from dispatcher
  {
    PORTB = 0x01 << pRun->nr;
  }
}

void loop() {
  // put your main code here, to run repeatedly:

}
