#include <krnl.h>
// one task loops and blink
// k_sleep is used for delay - and ensure no busy waiting
// if delay(...) is used then you use cpu time

const int interruptPin = 2; //Knappen er sluttet til pin 2.
const int ledPin = 13; //Brug den indbyggede LED på pin 13.
unsigned long lastCounter = 0;

struct k_t *p, *Q, *sem;
char stackp[100], stackQ[100];
unsigned int counter = 0;

void ISR1()
{
  if ((counter - lastCounter) > 0) {
    Serial.print("Interrupt: ");
    Serial.println(counter - lastCounter);
    counter += 100;
    k_eat_ticks(1000);
    lastCounter = counter;
  }
}

void t1() {
  while (1) {

    //k_sleep pauses the current task.
    //Serial.println("HIGH");
    digitalWrite(ledPin, HIGH);
    k_sleep(50);

    //Serial.println("LOW");
    digitalWrite(ledPin, LOW);
    k_sleep(50);

  }
}

void t2() {
  while (1) {
    Serial.println(counter);
    counter ++;
    k_sleep(400);
  }
}

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(interruptPin, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(interruptPin), ISR1, FALLING);
  Serial.begin(9600);

  //Starter Jens' kernel.
  k_init( 2,  /*Max number of tasks at one time*/
          0,  /*Number of semaphores*/
          0); /*Number of message queues*/

  // priority low number higher priority than higher number
  p = k_crt_task( t1,    /*Task function created*/
                  10,    /*Task priority (low number=high priority)*/
                  stackp, /*Stack-array used for task*/
                  100);  /*Stack size for array "stack"*/
  Q = k_crt_task( t2,    /*Task function created*/
                  9,     /*Task priority (low number=high priority)*/
                  stackQ, /*Stack-array used for task*/
                  100);  /*Stack size for array "stack"*/
              
  Serial.println("Setup done");
  k_start(1); // 1 milli sec tick speed
}

void loop() {
}
