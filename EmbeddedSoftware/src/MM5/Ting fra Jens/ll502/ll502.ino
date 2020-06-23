#include <krnl.h>

struct k_t *p1, *p2, *p3;
char st1[100], st2[100], st3[100];

struct k_t *sem1;
void t1()
{
  while (1) {
    k_wait(sem1, 0); // 0 means no timeout - so wait forever if ..
    Serial.println("1234567890");
    k_signal(sem1);

    // k_sleep(10);
  }
}

void t2()
{
  while (1) {

    k_wait(sem1, 0); // 0 means no timeout - so wait forever if ..
    Serial.println("abcdefghijklmn");
    k_signal(sem1);

    // k_sleep(10);
  }
}

void setup()
{

  Serial.begin(9600);
  for (int i = 8; i < 14; i++) {
    pinMode(i, OUTPUT);
  }
  k_init(3, 1, 0); // init with space for one task
  // priority low number higher priority than higher number
  p1 = k_crt_task(t1, 11, st1, sizeof(st1)); // t1 as task, priority 10, 100 B stak
  p2 = k_crt_task(t2, 11, st2, sizeof(st2)); // t1 as task, priority 10, 100 B stak
  //p3 = k_crt_task(t1, 11, st3, sizeof(st3)); // t1 as task, priority 10, 100 B stak

  sem1 = k_crt_sem(1, 10);
  k_start(1); // 1 milli sec tick speed
}

void loop() {}

////////////////////////////////////////////////////

extern "C" {
  void k_breakout() // called every task shift from dispatcher
  {
    PORTB = 0x01 << pRun->nr;
  }
}

/*

   Suggested PORTS TO USE

  UNO
  pin port
  8   PB0
  9   PB1
  10  PB2
  11  PB3
  12  PB4
  13  PB5  LED13
  PB6 and 7  etc not to be used !


  MEGA
  pin port
  78  PA0
  77  PA1
  76  PA2
  75  PA3
  74  PA4
  73  PA5
  72  PA6
  71  PA7
  13  PB7 LED13

  MICRO
  8  PB4
  9  PB5
  10 PB6
  11 PB7
  13 PC7 LED13

  NANO
  D8  PD0
  D9  PD1
  D2  PD2
  D3  PD3
  D4  PD4
  D5  PD5
  D6  PD6
  D7  PD7
  13  PB5  LED13

  PRO MINI
  2  PD2
  3  PD3
  4  PD4
  5  PD5
  6  PD6
  13 PB5 LED13

 * */
