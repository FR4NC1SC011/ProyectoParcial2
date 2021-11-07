import P5ireBase.library.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ, proximity, light;
int driving, doors_open;

P5ireBase fire;
void setup() {
  size(400, 400);
  fire = new P5ireBase(this, "https://parcial2-7a6f8-default-rtdb.firebaseio.com/");
   
  oscP5 = new OscP5(this, 12000);
  //remoteLocation = new NetAddress("10.0.2.16", 12000);
  remoteLocation = new NetAddress("127.0.0.1", 12001);  
  textAlign(CENTER, CENTER);
  textSize(24);

}

void draw() {
  background(78, 93, 75);
  text("Remote Sensors Info: " + "\n" +
    "x: "+ nfp(accelerometerX, 1, 3) + "\n" +
    "y: "+ nfp(accelerometerY, 1, 3) + "\n" +
    "z: "+ nfp(accelerometerZ, 1, 3) + "\n\n" +
    
    "luz: "+ light + "\n" +
    "proximidad: "+ proximity + "\n", width/2, height/2);              
}

void mousePressed() {
  
  String x = Float.toString(accelerometerX);
  String y = Float.toString(accelerometerY);
  String z = Float.toString(accelerometerZ);

  String p = Float.toString(proximity);
  String l = Float.toString(light);
  
  String driv = Integer.toString(driving);
  String doors = Integer.toString(doors_open);
  
 
  fire.setValue("sensors/-MnSpF2G5-ySw3o4Ec1d/abrir_puertas", doors);
  fire.setValue("sensors/-MnSpF2G5-ySw3o4Ec1d/conduciendo", driv);
  fire.setValue("sensors/-MnSpF2G5-ySw3o4Ec1d/iluminacion", l);
  fire.setValue("sensors/-MnSpF2G5-ySw3o4Ec1d/proximidad", p);
  fire.setValue("sensors/-MnSpF2G5-ySw3o4Ec1d/val_x", x);
  fire.setValue("sensors/-MnSpF2G5-ySw3o4Ec1d/val_y",y);
  fire.setValue("sensors/-MnSpF2G5-ySw3o4Ec1d/val_z", z);

}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("fffffii"))                 
  {
    accelerometerX =  theOscMessage.get(0).floatValue(); 
    accelerometerY =  theOscMessage.get(1).floatValue();
    accelerometerZ =  theOscMessage.get(2).floatValue();
    
    light =  theOscMessage.get(3).floatValue();
    proximity =  theOscMessage.get(4).floatValue();
    
    driving =  theOscMessage.get(5).intValue();
    doors_open =  theOscMessage.get(6).intValue();


  }
}
