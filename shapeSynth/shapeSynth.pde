import supercollider.*;
import oscP5.*;
import netP5.*;

int sizeX = 500;
int sizeY = 500;
int selectedShape;
boolean shapeIsSelected=false;


// Code for a fixed number of shapes
//Rectangle[] shapes = new Rectangle[10]; // make an array of soundShapes

// Code for a dynamic number of shapes
ArrayList<Rectangle> rectangles;
//Rectangle rectangle;


void setup(){
  // Sets the window size to the screen dimensions
  int sizeX = displayWidth;
  int sizeY = displayHeight;
  size(sizeX,sizeY);
  
  /*
  // initialise each soundshape with a for loop
    for(int i=0; i < shapes.length; i++){
    shapes[i] = new Rectangle(sizeX,sizeY);
  }
  */
  
  // creates and empty array
  rectangles = new ArrayList<Rectangle>();
  //Rectangle rectangle  = new Rectangle(displayWidth,displayHeight);
  
}

void draw(){
  background(51);
  
  //display all shapes
  for(int i=0; i<rectangles.size(); i++){
    Rectangle rectangle = rectangles.get(i);
    
    /*
    // if shape is not to be displayed it is removed.
    // - synth is stopped - updated - then removed from the array
    // to prevent audio issues.
    if(rectangle.displayShape == false){
      rectangle.stop();
      rectangles.set(i, rectangle);
      rectangles.remove(i);
      break;
    }
    */
    rectangle.display();
  }

}

void mousePressed(){
  println(rectangles.size());
  
  // check if array is empty, if it is add the first shape.
  if(rectangles.isEmpty()){
  Rectangle rectangle  = new Rectangle(displayWidth,displayHeight);
  rectangles.add(rectangle);
  }
  
  
  // selects shapes in decending order
  // so the most recent one is selected first.
  for(int i=rectangles.size()-1; i>=0; i--){
    
    Rectangle rectangle = rectangles.get(i);
     
    if(rectangle.shapeSelected()){
      // shape is selected
      // checks for a double click event
      if (mouseEvent.getClickCount()==2){
        // if double clicked start the shape again
        rectangle.startShape();
        rectangles.set(i, rectangle);
        
        // need to add a check to see if shape is to be removed.
        
        
       } else {
         // if not select the shape
         rectangle.shapeSelected();
         rectangles.set(i, rectangle);
       }
      selectedShape = i;
      shapeIsSelected = true; // Flag to stop a new shape beign drawn if one is selected.
      break;
    }
  } 
  
  if(shapeIsSelected == false){
    // no shape has been selected
    // Start a new rectangle and
    // add it to the rectangles array.
    Rectangle rectangle  = new Rectangle(displayWidth,displayHeight);
    rectangle.startShape();
    rectangles.add(rectangle);
    selectedShape = rectangles.size()-1;
  }
  
}

void mouseDragged(){
    
    // Get the rectangle that is to be resized
    // resize it and update the values
    Rectangle rectangle = rectangles.get(selectedShape);
    rectangle.resize();
    rectangle.updateSynth();
    
    // update the value in the ArrayList
    rectangles.set(selectedShape, rectangle);
    
}

void mouseReleased(){
  //shapes[selectedShape].unselectShape();
  
  // shapes are unselected
  for(int i=rectangles.size()-1; i>=0;i--){
    Rectangle rectangle = rectangles.get(i);
    
    rectangle.unselectShape();
    
    // test to see if shape should be removed or not
        if(rectangle.displayShape == false){
          // remove rectangle.
          rectangle.stop();
          rectangles.set(i, rectangle);
          rectangles.remove(i);
          
        } else {
          //update rectangle
          rectangles.set(i, rectangle);
        
        }
  }
  shapeIsSelected = false;
  
  // find all shapes that are size zero and remove them.
}

void exit(){
  // on exit all shapes are stopped
for(int i=0; i<rectangles.size();i++){
    Rectangle rectangle = rectangles.get(i);
    rectangle.stop();
    rectangles.set(i, rectangle);
  }
  super.exit();
}
