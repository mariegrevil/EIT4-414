#include <krnl.h>
// one task loops and blink
// k_sleep is used for delay - and ensure no busy waiting
// if delay(...) is used then you use cpu time

struct k_t *p, *Q;
char stackp[100], stackQ[100];
unsigned int counter = 0;

void t1() {
  while (1) {

    //k_sleep pauses the current task.
    //Serial.println("HIGH");
    digitalWrite(13, HIGH);
    k_sleep(50);

    //Serial.println("LOW");
    digitalWrite(13, LOW);
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
  pinMode(13, OUTPUT);
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
