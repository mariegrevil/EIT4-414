/*
   ----------------------------------------------------------------------------------------------------------------------------
  Low level precision floating point lib
  Author: Henrik Schiøler
*/
//!!!!!!!!!!!!!!!Husk disse funktioner er lavet og uleveret af Henrik
//low precision floating pt type
typedef struct myfloat
{
  signed char mantissa;
  signed char exponent;
} myfloat_type;


//convert from double to low precision type
void doub2mydouble(double arg, myfloat_type *res)
{
  int exponent;
  double temp;
  exponent = ceil(log(abs(arg)) / log(2)); //base 2 logarithm
  temp = arg * pow(2, 7 - exponent);
  res->mantissa = (signed char)temp;
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

  sign = 0x80 & ((unsigned char)arg1-> mantissa ^ (unsigned char)arg2-> mantissa); //find sign of result

  char i = 0;
  temp = (int)(arg1-> mantissa) * (int)(arg2-> mantissa);

  temp = temp & 0x7f00; //take away sign from product

  while (abs(temp) > 128)
  {
    i++;
    temp = temp >> 1;
  }

  result->mantissa = (unsigned char) temp;

  result->mantissa = result->mantissa | sign; //add recorded sign

  result->exponent = arg1->exponent + arg2->exponent + i;

}
//----------------------------------------------------------------------------------------------------------------------------

// Dettte løser opgave 1-10. dvs. at opgave 11 mangler... Held og lykke
const int daSiz = 100;
int start;
int stopp;
int time1;
int time2;
myfloat_type f1;
myfloat_type f;
double a=1.001;
double AbEr;
double AbEr2;
double ReEr;
double ReEr2;
double ReEr3;
double ReErMean;
double ReErMean2;
double da[daSiz];
double da2[daSiz];
myfloat_type mda[daSiz]; //Make an array of myfloat_type objects
myfloat_type mda2[daSiz];
//Setup-----------------------------------------------------------

void setup() {

  Serial.begin(115200);

  for (int i = 0; i < daSiz; i++) //fill arrays
  {
    da[i] = random(-5, 5); //random tal mellem -5 og 5
    doub2mydouble(da[i], &mda[i]); //convert array "da" to myfloat_type "mda"
  }

  for (int i = 0; i < daSiz; i++) {
    if(da[i]==0){ //To remove errors when dividing with zero
      AbEr=0;
      ReEr =0;
      }
      else{
    AbEr = abs(da[i] - myfloat2double(&mda[i])); //Abserlut error between da and mda
    ReEr = AbEr / abs(da[i]);   //Relative error between da and mda
      }
    ReErMean += ReEr;
  }
  ReErMean = ReErMean / daSiz;   //Relative mean error

  //mda^2 og da^2----------------------------------------------
  for (int i = 0; i < daSiz; i++) {
    mult_float(&mda[i],&mda[i],&mda2[i]);
    da2[i] = pow(da[i], 2);
  }

  for (int i = 0; i < daSiz; i++) {
     if(da2[i]==0){ //To remove errors when dividing with zero
      AbEr2=0;
      ReEr2=0;
      }
      else{
    AbEr2 = abs(da2[i] - myfloat2double(&mda2[i])); //Abserlut error between da2 and mda2
    ReEr2 = AbEr2 / abs(da2[i]); //Relative error between da2 and mda2
      }
    ReErMean2 += ReEr2;
  }
  ReErMean2 = ReErMean2 / daSiz; //Relative mean error
//------------- Printing ---------------------------------------
for (int i = 0; i < daSiz; i++){
  Serial.print("da= ");
  Serial.print(da[i]);
  Serial.print(" mda= ");
  Serial.println(myfloat2double(&mda[i]));
  
}
Serial.print("Mean relativ error da->mda ");
Serial.println(ReErMean);

for (int i = 0; i < daSiz; i++){
  Serial.print("da2= ");
  Serial.print(da2[i]);
  Serial.print(" mda2= ");
  Serial.println(myfloat2double(&mda2[i]));

}
Serial.print("Mean relativ error da2->mda2 ");
Serial.println(ReErMean2);
//---------------------------------------------------------
//-- Tid floting vs interger
doub2mydouble(a, &f1);

start=micros();
for (int i = 0; i < daSiz; i++){
a*=da[i];
}

stopp=micros();
time1=stopp-start;
Serial.print("time a* ");
Serial.print(time1);
Serial.println(" Mikrosekunder");

start=micros();
for (int i = 0; i < daSiz; i++){
  mult_float(&f1,&mda[i],&f);
  memcpy(&f1,&f,2);
}
stopp=micros();
time2=stopp-start;
Serial.print("time f1* ");
Serial.print(time2);
Serial.println(" Mikrosekunder");

ReEr3=abs((a-myfloat2double(&f1)))/abs(a);
Serial.print("Mean relativ error a->f1 ");
Serial.println(ReEr3);
}
void loop() {

}
