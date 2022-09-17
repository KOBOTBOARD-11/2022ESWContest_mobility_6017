//Face Tracker using OpenCV and Arduino
//by Shubham Santosh

#include<Servo.h>

Servo x, y;
int width = 640, height = 480;  // total resolution of the video
int xpos = 90, ypos = 90;  // initial positions of both Servos
void setup() {

  Serial.begin(9600);
  x.attach(7);
  y.attach(10);
  Serial.print(width);
  Serial.print("\t");
  Serial.println(height);
  x.write(xpos);
  y.write(ypos);
}
const int angle = 5;   // degree of increment or decrement

void loop() {
  if (Serial.available() > 0)
  {
    int x_mid, y_mid;
    if (Serial.read() == 'X')
    {
      x_mid = Serial.parseInt();  // read center x-coordinate
      if (Serial.read() == 'Y')
        y_mid = Serial.parseInt(); // read center y-coordinate
    }
    /* adjust the servo within the squared region if the coordinates
        is outside it
    */
    if (x_mid > width / 2 + 30)
      xpos += angle;
    if (x_mid < width / 2 - 30)
      xpos -= angle;
    if (y_mid < height / 2 + 30)
      ypos -= angle;
    if (y_mid > height / 2 - 30)
      ypos += angle;


    // if the servo degree is outside its range
    if (xpos >= 180)
      xpos = 180;
    else if (xpos <= 0)
      xpos = 0;
    if (ypos >= 180)
      ypos = 180;
    else if (ypos <= 0)
      ypos = 0;

    x.write(xpos);
    y.write(ypos);

    // used for testing
    Serial.print("\t");
    Serial.print(x_mid);
    Serial.print("\t");
    Serial.println(y_mid);
    // delay(5);
  }
}