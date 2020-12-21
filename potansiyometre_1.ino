int analogPin[4] = {A0, A1, A2, A3};
byte kanal[4] = {0, 0, 0, 0};
unsigned long T = 20; // in every T ms send channel signals
unsigned long loopTimer, t;
unsigned int packetNumber = 0;
void setup() {
  Serial.begin(57600);
  loopTimer = micros() + T*1000; 
}

void loop() {
  for (int i = 0; i < 4; i++)
    kanal[i] = map(analogRead(analogPin[i]), 0, 1023, 0, 255);
  t = micros();
  packetNumber++;
  Serial.write('h'); Serial.write(kanal, 4); Serial.write((byte*)(&t), 4); Serial.write((byte*)(&packetNumber),2);
  while (loopTimer > micros());
  loopTimer += T*1000;
}
