import supercollider.*;
import oscP5.*;
import netP5.*;

World world; // Make the world

void setup() {

  // Set window size to be the full size of the screen.
  //int sizeX = displayWidth;
  //int sizeY = displayHeight;
  
  int sizeX = 500;
  int sizeY = 500;
  size(sizeX, sizeY);
  world = new World(); // make new world.
}

void draw() {
  background(33);
  world.draw();
}

void mousePressed() {
  // on mouse click try and select a rectangle.
  world.rectSelect();

  // if no rectangle was selected make a new rectangle
  if (!world.getRectSelected()) world.makeRect();
}

void mouseDragged() {
  // resize the rectangle when the mouse is dragged.
  world.resizeSelectedRect();
}

void mouseReleased() {
  // when the mouse is released no rectangles will be selected
  // thus unselected them all.
  world.unselectAll();
  //if(world.getRectSelected);
}

void mouseMoved() {

  // each time the mouse is moved all rectangles are unselected to
  // prevent a selection bug - ensuing that the most recent rectangle is selected.
  world.unselectAll();

  // selected a rectangle - this caused rectangles in which the mouse is currently hovering over
  // to be highlighted.
  world.rectSelect();
}

void keyTyped() {

  // clears all rectangles.
  if (int(key) == 127) world.clear();
}

void exit() {
  world.clear();
  super.exit();
}

