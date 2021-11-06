import ketai.sensors.*;
import netP5.*;                                          
import oscP5.*;
import ketai.net.*;

OscP5 oscP5;
KetaiSensor sensor;

NetAddress remoteLocation;
float myAccelerometerX, myAccelerometerY, myAccelerometerZ;
int x, y, p; 
String myIPAddress; 
String remoteAddress = "127.0.1.1";                      

PVector magneticField, accelerometer;
float light, proximity;

void setup()
{
  sensor = new KetaiSensor(this);
  initNetworkConnection();
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  magneticField = new PVector();
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(28);
}

void draw()
{
  background(78, 93, 75);
  text("Accelerometer :" + "\n" 
    + "x: " + nfp(myAccelerometerX, 1, 2) + "\n" 
    + "y: " + nfp(myAccelerometerY, 1, 2) + "\n" 
    + "z: " + nfp(myAccelerometerZ, 1, 2) + "\n"
    + "MagneticField :" + "\n" 
    + "x: " + nfp(magneticField.x, 1, 2) + "\n"
    + "y: " + nfp(magneticField.y, 1, 2) + "\n" 
    + "z: " + nfp(magneticField.z, 1, 2) + "\n"
    + "Light Sensor : " + light + "\n" 
    + "Proximity Sensor : " + proximity + "\n"
    , 20, 0, width, height);
    
  OscMessage myMessage = new OscMessage("sensors");
  myMessage.add(myAccelerometerX);                        
  //myMessage.add(myAccelerometerY);
  //myMessage.add(myAccelerometerZ);
  //myMessage.add(light);
  //myMessage.add(proximity);
  oscP5.send(myMessage, remoteLocation); 
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("iii"))                  
  {
    x =  theOscMessage.get(0).intValue();                 
    y =  theOscMessage.get(1).intValue();
    p =  theOscMessage.get(2).intValue();
  }
}


void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  //accelerometer.set(x, y, z);
  myAccelerometerX = x;
  myAccelerometerY = y;
  myAccelerometerZ = z;
  
}

void onMagneticFieldEvent(float x, float y, float z, long time, int accuracy)
{
  magneticField.set(x, y, z);
}

void onLightEvent(float v)
{
  light = v;
}

void onProximityEvent(float v)
{
  proximity = v;
}

public void mousePressed() { 
  if (sensor.isStarted())
    sensor.stop(); 
  else
    sensor.start(); 
  println("KetaiSensor isStarted: " + sensor.isStarted());
}






void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12001);                         // 9
  remoteLocation = new NetAddress(remoteAddress, 12000);  // 10
  myIPAddress = KetaiNet.getIP();                         // 11
}
