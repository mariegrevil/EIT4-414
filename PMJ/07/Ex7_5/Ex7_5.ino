#include <krnl.h>
// one task loops and blink
// k_sleep is used for delay - and ensure no busy waiting
// if delay(...) is used then you use cpu time 

struct k_t *p1, *p2, *sem;
char stak1[100], stak2[100];
unsigned long Start = k_millis_counter;

void t1()
{
  while (1) {
  k_wait(sem, 0);// Semephone tages
    static unsigned long n = 0;  
    if (k_millis_counter >= Start+(5000*n)){
      Serial.print("T1 start = ");
      Serial.println(k_millis_counter);
      k_eat_ticks(2000);
      Serial.print("T1 stop = "); 
      Serial.println(k_millis_counter);
      n++;
    }
    else{
      k_sleep(10);
    }
  k_signal(sem);// Semephone afleveres tilbage
  }
}

void t2()
{
  while (1) {
  k_wait(sem, 0); // Semephone tages
    static unsigned long n2 = 0;  
    if (k_millis_counter >= Start+(8000*n2)){
      Serial.print("T2 start = ");
      Serial.println(k_millis_counter);
      k_eat_ticks(2000);
      Serial.print("T2 stop = "); 
      Serial.println(k_millis_counter);
      n2++;
    }
    else{
      k_sleep(10);
    }
  k_signal(sem); // Semephone afleveres tilbage
  }
}

void setup()
{
  pinMode(13,OUTPUT);
  k_init(2,1,0);  // init with space for one task

  Serial.begin(9600);
  // priority low number higher priority than higher number
  p1 = k_crt_task(t1,1,stak1,100); // t1 as task, priority 1, 100 B stak <-- Kører først
  p2 = k_crt_task(t2,10,stak2,100); // t2 as task, priority 10, 100 B stak
  sem = k_crt_sem(1, 1);
  k_start(1); // 1 milli sec tick speed
}

void loop() {
}
