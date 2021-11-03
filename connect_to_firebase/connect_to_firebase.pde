import P5ireBase.library.*;

P5ireBase fire;
void setup() {
  size(400, 400);
  fire = new P5ireBase(this, "https://parcial2-7a6f8-default-rtdb.firebaseio.com/");//put here ur DB link created in firebase console
}

void mousePressed() {
  fire.setValue("Iluminacion", "10");//Set info to specific key in FireBase
  fire.setValue("Proximidad", "0");//Set info to specific key in FireBase
  fire.setValue("sensors/-MnSpF2G5-ySw3o4Ec1d/val_y", "9.81");//Set info to specific key in FireBase
  println(fire.getValue("Iluminacion"));//Get info from specific key
}

void draw() {
}
