#include <krnl.h>
unsigned long TimePast;
struct k_t *pt1, *pt2; //pointer to hold refrenc task 1;
struct k_t *sem1;

char buffArray[10 * 2]; //Array of 10 intergers each 2 byts

struct k_msg_t   *pMsg; //pointer to messegs

#define STK 200 //stak size
#define tickspeed 10

char s1[STK], s2[STK]; //stak for task 1

void ISR1() {
  if ( 150 < (millis() - TimePast)) { //To remove bouncing
    Serial.println("ISR1 ran");
    TimePast = millis();
  }
}

void t1(void) {
  int i;
  int b;
  while (1) {
    k_wait(sem1, 0); //Venter på semaphor "sem1". Må maksinalt vente "0" ticks. (0 betyder den må vente for altid)(negativ betyder en ikke må ventet)
    Serial.println("Hello world");
    b = k_receive(pMsg, &i, -1, NULL); //modtag fra pointer "pMsg", gem i "i", Timeout -> "-1" = do not wait, Beskeder tabt "NULL" meælder intet tabt
    Serial.print("status -> ");
    Serial.print(b);
    Serial.print(" modtaget er -> ");
    Serial.println(i);
    k_eat_msec_time(30);
    k_sleep(300); // delay that is not a delay, corse bq delay is active wating.
    k_signal(sem1); //giv signal om at sem1 er fri igen.
  }
}

void t2(void) {
  int i=0;
  while (1) {
    Serial.println("blink blink");
    if (digitalRead(13) == HIGH) {
      digitalWrite(13, LOW);
    }
    else {
      digitalWrite(13, HIGH);
    }
    k_send(pMsg, &i); //sender besked til "pMsg2" som er en pointer til "buffArray", besked "2"
    i++;
    k_eat_msec_time(30);
    k_sleep(300); // delay that is not a delay, corse bq delay is active wating.
  }
}

void setup() {
  Serial.begin(9600);
  for (int i = 8; i < 14; i++) {
    pinMode(i, OUTPUT);
  }
  pinMode(2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(2), ISR1, LOW);
  k_init(2, 1, 1); //how menny threds to inetilize


  pt1 = k_crt_task(t1, 2, s1, STK); //Funktion, priority, stack array, stack size
  pt2 = k_crt_task(t2, 1, s2, STK); //Funktion, priority, stack array, stack size

  pMsg = k_crt_send_Q(10, 2, buffArray); //messegs pointer skal sende til array(buffer) med 10 ints med 2 byts
  sem1 = k_crt_sem(1, 10); //Semaphor with start valu 0 to 10

  k_start(tickspeed); // start kernal with "tickspeed" in milli sec
}

extern "C" //Erstatter en funcktion "(week)k_breakout()" med denne som skubber pins High når tilsavarende kernel køre
{
  void k_breakout() // called every task shift from dispatcher
  {
    PORTB = 0x01 << pRun->nr;
  }
}

void loop() {
  // put your main code here, to run repeatedly:

}
