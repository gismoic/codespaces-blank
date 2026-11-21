uint8_t LED_pin = 2;

uint8_t source_pin = 10;
uint8_t input_pin = 9;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED_pin, OUTPUT);
  pinMode(input_pin, INPUT);
  pinMode(source_pin, OUTPUT);

  digitalWrite(source_pin, LOW);

}

void loop() {
  // put your main code here, to run repeatedly:
  if(digitalRead(input_pin)){
    digitalWrite(LED_pin, HIGH);
  }else{
    digitalWrite(LED_pin, LOW);
  }

}
