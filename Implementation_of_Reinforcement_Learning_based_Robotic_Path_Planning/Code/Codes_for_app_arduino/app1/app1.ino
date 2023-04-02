int led1=11;
int led2=12;
int led3=7;

int recieved =0;
int data1=0;
int data2=0;
int data3=0;
int data4=0;
int data5=0;

void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
pinMode(led1,OUTPUT);
pinMode(led2,OUTPUT);
pinMode(led3,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
if(Serial.available()>0)
{
  recieved=Serial.read();
}
if(recieved=='1')
{
 // data1=Serial.read();
  data2=data3=data4=data5=0;
  data1=1;
  Serial.print(data1);
  digitalWrite(led1, HIGH);
  delay(1000);
  digitalWrite(led1, LOW);
  recieved=0;
}
if(recieved=='2')
{
 // data1=Serial.read();
 data1=2;
  data2=data3=data4=data5=0;
  Serial.print(data1);
  digitalWrite(led2, HIGH);
  delay(1000);
  digitalWrite(led2, LOW);
  recieved=0;
}
if(recieved=='a')
{
  data1='a';
 // data1=Serial.read();
  data2=data3=data4=data5=0;
  Serial.print(data1);
  digitalWrite(led3, HIGH);
  delay(1000);
  digitalWrite(led3, LOW);
  recieved=0;
}
}
