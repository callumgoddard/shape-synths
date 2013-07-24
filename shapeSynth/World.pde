class World {
  
  int selectedRectID; // int to track which rectangle in the array is selected
  boolean rectSelected = false; // variable to track is a rectangle is selected
  
  // Code for a dynamic number of shapes
  ArrayList<Rectangle> rectangles;
  Rectangle rectangle;
  
  World(){
    
    // Makes new array to keep the rectanlges.
    rectangles = new ArrayList<Rectangle>();
    
    // makes a rectangle class for individual manipulaition of rectangles
    rectangle  = new Rectangle(displayWidth,displayHeight);
    
  }
  
  void draw(){
    
    // Iterate through the array of rectangles
    // displaying each one.
    for(int i=rectangles.size()-1; i>=0;i--){
     rectangle = rectangles.get(i);
      rectangle.display();
    }
    
    // redraws the selected rectangle so that
    // and GUI updates appear correctly.
    if(rectSelected){
     rectangle = rectangles.get(selectedRectID);
     rectangle.display();
    }
    
  }
  
  void clear(){
    // Clears all the Rectangles.
    // Iterates backwards through the array
    // stoping the sound then removing the rectangle
    // from the array
    for(int i=rectangles.size()-1; i>=0;i--){
      Rectangle rectangle = rectangles.get(i);
      rectangle.stop();
      rectangles.set(i, rectangle);
      rectangles.remove(i);
    }  
  }
  
  void rectSelect(){
    
    // check if array is empty, if it is add the first shape.
    if(rectangles.isEmpty()){
      Rectangle rectangle  = new Rectangle(displayWidth,displayHeight);
      rectangles.add(rectangle);
    }
      
    // Most recently created rectangle
    // is tested to see if it has been selected
    // if it has - a double click event is checked for
    for(int i=rectangles.size()-1; i>=0; i--){
      
      rectangle = rectangles.get(i);
       
      // if the selected shape has been double clicked
      // it is started again
      // otherwise the shape is selected.
      if(rectangle.shapeSelected()){
        if (mouseEvent.getClickCount()==2){
          rectangle.startShape();
          rectangles.set(i, rectangle);         
         } else {
           rectangle.shapeSelected();
           rectangles.set(i, rectangle);
         }
        selectedRectID = i;
        rectSelected = true; // Flag updated to stop a new shape beign drawn if one is selected.
        break;
      }
    }   
  }
  
  void makeRect(){
      // no shape has been selected
      // Start a new rectangle and
      // add it to the rectangles array.
      Rectangle rectangle  = new Rectangle(displayWidth,displayHeight);
      rectangle.startShape();
      rectangles.add(rectangle);
      selectedRectID = rectangles.size()-1;
  }
  
  void resizeSelectedRect(){
    // Get the rectangle that is to be resized
    // resize it and update the values
    Rectangle rectangle = rectangles.get(selectedRectID);
    rectangle.resize();
    rectangle.updateSynth();
    
    // update the value in the ArrayList
    rectangles.set(selectedRectID, rectangle);
  }
  
  void unselectAll(){
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
      rectSelected = false;
  }

  boolean getRectSelected(){
    return rectSelected;
  }
  
 int getselectedRectID(){
    return selectedRectID;
  }
}
 
