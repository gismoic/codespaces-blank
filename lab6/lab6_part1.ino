const uint8_t LED1_PIN = 2;
const uint8_t LED2_PIN = 3;


void setup() {
  pinMode(LED1_PIN, OUTPUT);
  pinMode(LED2_PIN, OUTPUT);
}

void loop() {
  //part one
  digitalWrite(LED1_PIN, HIGH);
  delay(1000);
  digitalWrite(LED1_PIN, LOW);
  delay(1000);
}
