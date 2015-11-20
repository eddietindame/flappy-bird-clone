#define echoPin 11 // Echo Pin
#define trigPin 12 // Trigger Pin float distance;

long distance,
     duration;

void setup(){ 
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}
void loop(){ 
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = duration/58.2;
  //note that we use write() not print() because we will send this value //to Processing via serial communication later
  Serial.write(distance);
  delay(100);
}
