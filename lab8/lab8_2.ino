#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C display = LiquidCrystal_I2C(0x27, 16, 2);

uint8_t positive_probe = A0;
uint8_t negative_probe = A1;

void setup() {
  // put your setup code here, to run once:
  display.init();
  display.backlight();

  pinMode(positive_probe, INPUT);
  pinMode(negative_probe, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  double positive = analogRead(positive_probe);
  double negative = analogRead(negative_probe);

  double differential = 5.0 * ((positive - negative)/1024);
  display.setCursor(0, 0);
  display.print(differential);

}
