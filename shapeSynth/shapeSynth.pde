import supercollider.*;
import oscP5.*;
import netP5.*;

World world; // Make the world

void setup(){
  int sizeX = displayWidth;
  int sizeY = displayHeight;
  size(sizeX,sizeY);
  world = new World();
}

void draw(){
  background(33);
  world.draw();
}

void mousePressed(){
  world.rectSelect();
  if(!world.getRectSelected()) world.makeRect();
}

void mouseDragged(){
  world.resizeSelectedRect();  
}

void mouseReleased(){
   world.unselectAll();
   //if(world.getRectSelected);
}

void mouseMoved(){
  world.unselectAll();
  world.rectSelect(); 
}

void keyTyped(){
   if(int(key) == 127) world.clear();
}

void exit(){
   world.clear();
   super.exit();
}
