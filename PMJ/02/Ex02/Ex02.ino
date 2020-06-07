//low precision floating pt type-----------------------------------------------------//
typedef struct myfloat {
  signed char mantissa;
  signed char exponent;
} myfloat_type;


//convert values from double to low precision (floating point) type
void doub2mydouble(double arg, myfloat_type *res)
{
  int exponent;
  double temp;
  exponent = ceil(log(abs(arg)) / log(2)); //base 2 logarithm
  temp = arg * pow(2, 7 - exponent);
  res->mantissa = (signed char)temp;       //Changing temp from double to signed char
  res->exponent = exponent - 7;
}

//convert from low precision type to double
double myfloat2double(myfloat_type *arg1)
{
  double res = (double)(arg1->mantissa) * pow(2, arg1->exponent);
  return res;
}

//multiply to low precision types
void mult_float(myfloat_type *arg1, myfloat_type *arg2, myfloat_type *result)
{
  int temp;
  unsigned char sign;

  sign = 0x80 & ((unsigned char)arg1->mantissa ^ (unsigned char)arg2->mantissa); //find sign of result

  char i = 0;
  temp = (int)(arg1->mantissa) * (int)(arg2->mantissa);

  temp = temp & 0x7f00; //take away sign from product

  while (abs(temp) > 127)
  {
    i++;
    temp = temp >> 1;
  }

  result->mantissa = (unsigned char) temp;

  result->mantissa = result->mantissa | sign; //add recorded sign

  result->exponent = arg1->exponent + arg2->exponent + i;

}

//Sine function implementation ---- VIRKER IKKE.
float msine[256];

void init_sine() {
  for (int i = 0; i < 256; i++) {
    msine[i] = sin(1.5708 * (float)(i+1) / (float)256);
  }
}

float mysine(float x) {
  int n;
/*  if (x < 0.2) {
    return (x);
  }
*/
  n = ceil(256 * x / 1.5708);
  while (n > 255) {
    n = n - 256;
  }
  while (n < 0) {
    n = n + 256;
  }
  
  return (msine[n]);
}


//--Ex02 start--//
//---------------------------------------------------------------------------------//

double a = 1.001;
const int daSize = 100;
double da[daSize], da2[daSize];
double absError[daSize], relError[daSize];       //relError 1st calculation
double absError2[daSize], relError2[daSize];     //2nd calcultation
myfloat_type mda[daSize], mda2[daSize], f1, f;   //objects of the floating point struct


void setup() {
  Serial.begin(9600);

  //Ex. 1, 2, 4 & 5
  for (int i = 0; i < daSize; i++) {
    da[i] = (float)random(-100, 100) / 20;  //= random(-5.00, 5.00)- Converting random() to a float type
    da2[i] = pow(da[i], 2);                 //Computing da2=da^2
    doub2mydouble(da[i], &mda[i]);          //Converting da[i] to mantissa/exponent form
    mult_float(&mda[i], &mda[i], &mda2[i]); //Computing mda2=mda^2 using "mult_float". (multiplies 2 floating point arrays)
  }

  //Relative error calculation-------------------------------------------------------//
  double meanErr = 0,
         meanErr2 = 0;

  for (int i = 0; i < daSize; i++) {

    //3. Compute the mean relative error between da and mda
    absError[i] = da[i] - myfloat2double(&mda[i]); //Converts mda[i] back to a double type
    if (absError[i] == 0 || da[i] == 0) {
      relError[i] = 0;
    } else {
      relError[i] = abs(absError[i]) * 100 / abs(da[i]);
    }

    //6. Compute the mean relative error between da2 and mda2
    absError2[i] = da2[i] - myfloat2double(&mda2[i]);
    if (absError2[i] == 0 || da2[i] == 0) {          //Does not like 0's in division
      relError2[i] = 0;
    } else {
      relError2[i] = abs(absError2[i]) * 100 / abs(da2[i]);
    }
  }

  //Calculating the sum of relative errors
  for (int i = 0; i < daSize; i++) {
    meanErr  = meanErr  + relError[i];
    meanErr2 = meanErr2 + relError2[i];
  }

  meanErr  = meanErr  / 100;                        //Computing the mean
  meanErr2 = meanErr2 / 100;

  Serial.println("Mean relative error:  " + (String)meanErr  + " %");
  Serial.println("Mean relative error2: " + (String)meanErr2 + " %");


  //7. Iterate a*=da[i] over the size of da---------------------------------------------//
  unsigned long timeStart = micros();
  for (int i = 0; i < daSize; i++) {
    a *= da[i];
  }
  //Compute execution time of above
  unsigned long timeStop = micros();
  unsigned long timePast = timeStop - timeStart;
  Serial.print("Duration of a*=da[i] iterations:                  ");
  Serial.print(timePast);
  Serial.println(" µs");


  //8. Converting 'a' into an object myfloat_type f1-----------------------------------//
  doub2mydouble(a, &f1);


  //9. Iterate "mult_float(&f1,&mda[i],&f); memcpy(&f1,&f,2);" over the length of mda and measure the execution time-----//
  unsigned long timeStart1 = micros();
  for (int i = 0; i < daSize; i++) {
    mult_float(&f1, &mda[i], &f);  //Multiplying f1 with mda, stores in f.
    memcpy(&f1, &f, 2);            //Move 2 bytes from f to f1.
  }
  //Compute execution time of above
  unsigned long timeStop1 = micros();
  unsigned long timePast1 = timeStop1 - timeStart1;
  Serial.print("Duration of multiplication and byte transfer:     ");
  Serial.print(timePast1);
  Serial.println(" µs");


  //10. Compute the relative difference between results from (7) and (9)
  double relDiff;
  relDiff = (timePast - timePast1) * 100 / timePast1;
  Serial.println("Relative difference in execution time: " + (String)relDiff + " %");


  //--VIRKER IKKE--//11. Implement the fastest version of the trigonometric function "sine" that has below 2% relative error.
  init_sine();
  float daSine[daSize];
  float daSine2[daSize];

  //Henrik's funktion
  unsigned long timeStart2 = micros();
  for (int i = 0; i < daSize; i++) {
    daSine[i] = mysine(da[i]);
  }
  //Compute execution time of above
  unsigned long timeStop2 = micros();
  unsigned long timePast2 = timeStop2 - timeStart2;
  Serial.print("Duration of Henrik's sine iterations:             ");
  Serial.print(timePast2);
  Serial.println(" µs");


  //Arduinos egen funktion
  unsigned long timeStart3 = micros();
  for (int i = 0; i < daSize; i++) {
    daSine2[i] = sin(da[i]);
  }
  //Compute execution time of above
  unsigned long timeStop3 = micros();
  unsigned long timePast3 = timeStop3 - timeStart3;
  Serial.print("Duration of Arduino's sine iterations:            ");
  Serial.print(timePast3);
  Serial.println(" µs");

  for (int i = 0; i < daSize; i++) {
    Serial.print(daSine[i]);
    Serial.print("      ");
    Serial.println(daSine2[i]);
  }

}

void loop() {
}
