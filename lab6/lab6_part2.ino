const uint8_t LED1_PIN = 2;
const uint8_t LED2_PIN = 3;

int pin1Val = 0;
int pin2Val = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED1_PIN, OUTPUT);
  pinMode(LED2_PIN, OUTPUT);
}

void loop() {

  //part two
  digitalWrite(LED2_PIN, HIGH);
  digitalWrite(LED1_PIN, HIGH);
  delay(1000);
  digitalWrite(LED2_PIN, LOW);
  delay(1000);
  digitalWrite(LED1_PIN, LOW);
  digitalWrite(LED2_PIN, HIGH);
  delay(1000);

}
