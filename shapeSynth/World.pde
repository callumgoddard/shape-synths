class World {

  int selectedRectID; // int to track which rectangle in the array is selected
  boolean rectSelected = false; // variable to track is a rectangle is selected
  // _REMOVE
  //int uniqueRectangleID = 0;
  
  // OSC variables.
  OscP5 osc;
  NetAddress superCollider;
  
  // Code for a dynamic number of shapes
  ArrayList<Rectangle> rectangles;
  Rectangle rectangle;

  World() {

    // Makes new array to keep the rectanlges.
    rectangles = new ArrayList<Rectangle>();
    
    osc = new OscP5(this, 12000); // make a new Osc object which will recieve on port 12000.
    superCollider = new NetAddress("127.0.0.1", 57120); // set the (default) address for SuperCollider
    
    // makes a rectangle class for individual manipulaition of rectangles
    //rectangle  = new Rectangle(displayWidth,displayHeight); // create a placeholder rectangle thus no need to specify ID.
  }

  void draw() {

    // Iterate through the array of rectangles
    // displaying each one.
    for (int i=rectangles.size()-1; i>=0;i--) {
      rectangle = rectangles.get(i);
      rectangle.display();
    }

    // redraws the selected rectangle so that
    // and GUI updates appear correctly.
    if (rectSelected) {
      rectangle = rectangles.get(selectedRectID);
      rectangle.display();
    }
  }

  void clear() {
    // Clears all the Rectangles.
    // Iterates backwards through the array
    // stoping the sound then removing the rectangle
    // from the array
    for (int i=rectangles.size()-1; i>=0;i--) {
      Rectangle rectangle = rectangles.get(i);
      rectangle.stop();
      rectangles.set(i, rectangle);
      rectangles.remove(i);
    }
  }

  void rectSelect() {
    
    if (rectangles.isEmpty()) return; // do nothing if there are no rectangles to select.

    // The most recently created rectangle
    // is tested to see if it has been selected
    // if it has - a double click event is checked for
    // (reminder: -1 used in for loop declaration to accout for ArrayList index starting at 0)
    for (int i=rectangles.size()-1; i>=0; i--) {

      rectangle = rectangles.get(i);

      // if the selected shape has been double clicked
      // it is started again
      // otherwise the shape is selected.
      if (rectangle.shapeSelected()) {
        if (mouseEvent.getClickCount()==2) {
          rectangle.startShape();
          rectangles.set(i, rectangle);
        } 
        else {
          rectangle.shapeSelected();
          rectangles.set(i, rectangle);
        }
        selectedRectID = i;
        rectSelected = true; // Flag updated to stop a new shape beign drawn if one is selected.
        break;
      }
    }
  }

  void makeRect() {

    int rectangleID;
    // find out how many rectangles there are to determine
    // the ID for this rectangle.
    if (rectangles.isEmpty()) {
      // there are no rectangles thus it will have id 0 (same as its 
      rectangleID = 0;
    } 
    else {
      // the rectangle ID will be equal to the current number of
      // rectangles in the arrayList. As lastRectangle's ID = arrayListSize - 1,
      // and the newly created rectangle will be added to the end of the list making its ID lastRectangle + 1.
      rectangleID = rectangles.size();
    }
    // Start a new rectangle and
    // add it to the rectangles array.
    Rectangle rectangle  = new Rectangle(displayWidth, displayHeight, rectangleID, osc, superCollider);
    rectangle.startShape();
    rectangles.add(rectangle);
    selectedRectID = rectangles.size()-1; // return ID of this newly added rectangle.
  }

  void resizeSelectedRect() {
    // Get the rectangle that is to be resized
    // resize it and update the values
    Rectangle rectangle = rectangles.get(selectedRectID);
    rectangle.resize();
    rectangle.updateSynth();

    // update the value in the ArrayList
    rectangles.set(selectedRectID, rectangle);
  }

  void unselectAll() {
    // shapes are unselected
    for (int i=rectangles.size()-1; i>=0;i--) {
      Rectangle rectangle = rectangles.get(i);

      rectangle.unselectShape();

      // test to see if shape should be removed or not
      if (rectangle.displayShape == false) {
        // remove rectangle.
        rectangle.stop();
        rectangles.set(i, rectangle);
        rectangles.remove(i);
      } 
      else {
        //update rectangle
        rectangles.set(i, rectangle);
      }
    }
    rectSelected = false;
  }

  boolean getRectSelected() {
    return rectSelected;
  }

  int getselectedRectID() {
    return selectedRectID;
  }
  
  int getUniqueId() {
    
    // need to add an OSC message which updates the unique ID
    // value in SuperCollider (so they are synchronised!
   
   return uniqueRectangleID++; 
  }
}

