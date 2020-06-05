#include <krnl.h>
struct k_t *pt1, *pt2; //pointer to hold refrenc task 1;

#define STK 200 //stak size
#define tickspeed 10

char s1[STK], s2[STK]; //staks


void t1(void) { //Task 1
  while (1) {
    Serial.println("Hello world");
    k_eat_msec_time(300); // Sim af kode der tager 300 ms
    k_sleep(100); // delay that is not a delay, corse delay is active wating.
  }
}

void t2(void) { //Task 2
  while (1) {
    Serial.println("blink blink"); 
    if (digitalRead(13)==HIGH){ // Skifter mellem HIGH og LOW på PIN13 (LED pin)
     digitalWrite(13,LOW); 
    }
    else{
    digitalWrite(13,HIGH);
    }
     k_eat_msec_time(30); //Sim af kode
    k_sleep(30); // delay that is not a delay, corse delay is active wating.
  }
}

void setup() {
  Serial.begin(9600); // Pins 8-13 sættes som pinout
  for (int i = 8; i < 14; i++) {
    pinMode(i, OUTPUT);
  }

  k_init(2, 0, 0); //how menny threds to inetilize, how menny semaphors, how menny messages
  pt1 = k_crt_task(t1, 2, s1, STK); //Funktion, priority, stack array, stack size
  pt2 = k_crt_task(t2, 1, s2, STK); //Funktion, priority, stack array, stack size

  
  k_start(tickspeed); // start kernal with "tickspeed" in milli sec
}

extern "C" { //Bruges til at moniter systemet med en occiloscop.
  void k_breakout() // called every task shift from dispatcher
  {
    PORTB = 0x01 << pRun->nr;
  }
}

void loop() {
  // put your main code here, to run repeatedly:

}
