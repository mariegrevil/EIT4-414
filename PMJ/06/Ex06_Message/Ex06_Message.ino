#include <krnl.h>

struct k_t *pt1, *pt2; //pointer to hold reference task 1;
struct k_t *sem1;

char buffArray[10 * 2]; //Array of 10 intergers each 2 bytes

struct k_msg_t   *pMsg; //pointer to messages

#define STK 200         //stak size
#define tickspeed 10

char s1[STK], s2[STK]; //stak for task 1


void t1(void) {
  int i, b;
  while (1) {
    k_wait(sem1, 0); //Venter for evigt.
    Serial.println("T1 Running - Semaphore received");

    //Receive data and print it
    b = k_receive(pMsg, &i, 0, NULL); //modtag fra pointer "pMsg", læser "i", Timeout -> "-1" = do not wait / "0" Vent for evigt indtil modtaget, Beskeden "NULL" melder intet tabt
    Serial.print("Status -> ");
    Serial.println(b);
    Serial.print("Modtaget er -> ");
    Serial.println(i);
    k_eat_msec_time(30);
    k_sleep(200);                     // delay that is not a delay, bq delay is active wating.

    k_signal(sem1);
    Serial.println("T1 Ended - Semaphore released");
  }
}

void t2(void) {
  int i = 0;
  while (1) {
    Serial.println("T2 Running");
    Serial.println(i);
    k_send(pMsg, &i);                //sender besked til "pMsg" som er en pointer til "buffArray", besked er værdien af "i"
    k_eat_msec_time(30);
    k_sleep(300);

    //increment i
    i += 200;

    Serial.println("T2 Ended");
  }
}

void setup() {
  Serial.begin(9600);
  for (int i = 8; i < 14; i++) {
    pinMode(i, OUTPUT);
  }

  k_init(2, 1, 1);                  //#threds to initialize, #semaphores, #messages.

  pt1 = k_crt_task(t1, 2, s1, STK); //Function, priority, stack array, stack size
  pt2 = k_crt_task(t2, 1, s2, STK); //Function, priority, stack array, stack size

  pMsg = k_crt_send_Q(10, 2, buffArray); //message pointer skal sende til buffArray(buffer array) med 10 ints af 2 bytes
  sem1 = k_crt_sem(1, 10);               //Semaphore with initial val 1, max val 10

  k_start(tickspeed);               // start kernal with "tickspeed" in milli sec
}

extern "C" //Erstatter en funktion "(weak)k_breakout()" med denne som skubber pins High når tilsvarende kernel køre
{
  void k_breakout() // called every task shift from dispatcher
  {
    PORTB = 0x01 << pRun->nr;
  }
}

void loop() {
  // put your main code here, to run repeatedly:

  /*    if (digitalRead(13) == HIGH) {
        digitalWrite(13, LOW);
      }
      else {
        digitalWrite(13, HIGH);
      }*/
}
