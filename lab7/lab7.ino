#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C display = LiquidCrystal_I2C(0x27, 16, 2);

uint8_t input = A0;
uint8_t negative_probe = A1;

void setup() {
  // put your setup code here, to run once:
  display.init();
  display.backlight();

  pinMode(input, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  double positive = analogRead(input);

  double voltage = 5.0 * ((positive)/1023);
  display.setCursor(0, 0);
  display.print(voltage);

}
