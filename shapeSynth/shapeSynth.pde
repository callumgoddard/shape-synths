import supercollider.*;
import oscP5.*;
import netP5.*;

int sizeX = 500;
int sizeY = 500;
int selectedShape;
boolean shapeSelected=false;

Rectangle[] shapes = new Rectangle[10]; // make an array of soundShapes

void setup(){
  int sizeX = displayWidth;
  int sizeY = displayHeight;
  size(sizeX,sizeY);
  
  // initialise each soundshape with a for loop
    for(int i=0; i < shapes.length; i++){ // initialise each soundshape with a for loop
    shapes[i] = new Rectangle(sizeX,sizeY);
  }
  
}

void draw(){
  background(51);
  
  //display all shapes
  for(int i=0; i<shapes.length; i++){
    shapes[i].display();
  }

}

void mousePressed(){
  
    // checks for a double click event
  if (mouseEvent.getClickCount()==2){
    //println("<double click>");
  }
  
  // selects shapes in decending order
  // so the most recent one is selected first.
  for(int i=shapes.length-1; i>=0; i--){
    if(shapes[i].selected()){
      // shape is selected
      // checks for a double click event
      if (mouseEvent.getClickCount()==2){
        // if double clicked start the shape again
        shapes[i].startShape();
       } else {
         // if not select the shape
         shapes[i].selected();
       }
      selectedShape = i;
      shapeSelected = true;
      break;
    }
  } 
  
  if(shapeSelected == false){
    // no shape has been selected
    for(int i=0; i < shapes.length; i++){
      if(shapes[i].displayShape == false){
        println("drawing shape: " + i);
        // start a shape and keep track of it.
        shapes[i].startShape();
        selectedShape = i;
        break;
      }
    }
  }
  
}

void mouseDragged(){
    shapes[selectedShape].resize();
    shapes[selectedShape].updateSynth();
}

void mouseReleased(){
  //shapes[selectedShape].unselectShape();
  
  // shapes are unselected
  for(int i=0; i<shapes.length;i++){
    shapes[i].unselectShape();
    println(i + " is unselected");
  }
  shapeSelected = false;
}

void exit(){
  // on exit all shapes are stopped
  for(int i=0; i<shapes.length;i++){
    shapes[i].stop();
  }
  super.exit();
}
