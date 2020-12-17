int analogPin[4] = {A0, A1, A2, A3};
byte kanal[4] = {'0', '0', '0', '0'};
void setup() {
  Serial.begin(57600);
}

void loop() {
  for (int i = 0; i < 4; i++) {
    kanal[i] = map(analogRead(analogPin[i]), 0, 1023, 0, 255);    
  }
  Serial.write('h');
  Serial.write(kanal, 4);
  delay(20); // her 20ms'de bir yolla yani saniyede 100 kere
}
