int analogPin[4] = {A0, A1, A2, A3};
byte kanal[4] = {0, 0, 0, 0};
unsigned long T = 20; // in every T ms send channel signals
void setup() {
  Serial.begin(57600);
}

void loop() {
  for (int i = 0; i < 4; i++)
    kanal[i] = map(analogRead(analogPin[i]), 0, 1023, 0, 255);
  Serial.write('h'); Serial.write(kanal, 4);
  delay(T);
}
