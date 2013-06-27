class Shape {
  
  int topX;   // X coordinate of the top corner of the shape
  int topY;   // Y coordinate of the top corner of the shape 
  int[] constantCoords = new int[2];
  int[] changingCoords = new int[2];
  int[] topLeftCorner = new int[2];
  //int[] topRightCorner = new int[2];
  //int[] bottomLeftCorner = new int[2];
  //int[] bottomRightCorner = new int[2];
  int[] shapeDims = new int[2];
  int[] mouseCoords = new int[2];
  int[] constantOffset= new int[2];
  int centerX;
  int centerY;
  int sWidth;
  int sHeight;
  int lowerBoundX;
  int lowerBoundY;
  int upperBoundX;
  int upperBoundY;
  int mouseOffSetX;
  int mouseOffSetY;
  int sArea;
  float wEdgeArea;
  float hEdgeArea;
  float pwm;
  float freq;
  float panning;
  boolean mouseOverShape = false;
  boolean displayShape = true;
  boolean shapeSelected;
  boolean topSelected;
  boolean bottomSelected;
  boolean leftSelected;
  boolean rightSelected;
  boolean startShape;
  boolean shapeTooSmall;
  int windowSizeX;
  int windowSizeY;

  Shape(int windowWidth, int windowHeight){
    
        windowSizeX = windowWidth;
        windowSizeY = windowHeight;
  }
  
  void display(){
     
    // check is mouse of over the shape
    if(mouseOverShape){
      
      // mouse is over the shape so it is highlighted
      stroke(255);      
    } else{
      
      // mouse is not over the shape so it is not highlighted
      stroke(153); 
    }
    
    fill(153);
   
    // prevent a shape being drawn that is too small to select
    if(sWidth == 0 && sHeight == 0){
          // no shape drawn and display boolean updated
          displayShape = false;
        }else{
          // shape is draw and display boolean updated
         displayShape = true;
         drawShape(); 
        }
  }
  
  
  void drawShape(){
    
    // place holder - will be overridden by shape subclassses
    
  }
  
  
   void startShape(){
        
        // mouse Possitions to work out the shape
        // coordinates are set
        arrayCopy(getMouseCoords(), constantCoords);
        arrayCopy(getMouseCoords(), changingCoords);
        
        // shape prameters are updated.
        updateShapeParams();
        
        // nothing is selected boolean states updated to
        // reflect this
        mouseOverShape=false;
        shapeSelected = false;
        topSelected = false;
        bottomSelected = false;
        leftSelected = false;
        rightSelected = false;
        
        // Indicate that the Shape should be started
        startShape = true;
   }
  

   int[] getMouseCoords(){
      
        // gets the mouseCoordinates 
        // and returns them as an array
        mouseCoords[0] = mouseX;
        mouseCoords[1] = mouseY;
        
        return mouseCoords;
   }
    
    
   boolean mouseOverShape(){
    // depends on shape - overwritten by subclass
    
    return mouseOverShape;
   }
  
    
    
   void updateCoords(){

          // update changing coordinates
          mouseOffSetX = mouseX-constantCoords[0];
          if(mouseOffSetX < 0){
            changingCoords[0] = constantCoords[0]+mouseOffSetX-constantOffset[0];
          }else{
            changingCoords[0] = constantCoords[0]+mouseOffSetX+constantOffset[0];
          }
          
          mouseOffSetY = mouseY- constantCoords[1];
          if(mouseOffSetY < 0){
            changingCoords[1] = constantCoords[1]+mouseOffSetY-constantOffset[1];
          } else{
            changingCoords[1] = constantCoords[1]+mouseOffSetY+constantOffset[1];
          }

  }
  
  void updateShapeParams(){
       
       // prevents a shape going outside of the window
       for(int i = 0; i < constantCoords.length; i++){
         
         if(constantCoords[i] < 0){
           constantCoords[i] = 0;
         }
       }
      
       if(constantCoords[0] > windowSizeX){
         constantCoords[0] = windowSizeX;
       }
       
       if(constantCoords[1] > windowSizeY){
           constantCoords[1] = windowSizeY;
       }
         
       for(int i = 0; i < changingCoords.length; i++){
         if(changingCoords[i] < 0){
           changingCoords[i] = 0;
         }
       }
     
       if(changingCoords[0] > windowSizeX){
         changingCoords[0] = windowSizeX;
       }
       
       if(changingCoords[1] > windowSizeY){
           changingCoords[1] = windowSizeY;
       }
         
        
       // Calculates the  top left Corner coordinate   
       topX = min(constantCoords[0], changingCoords[0]);
       topY = min(constantCoords[1], changingCoords[1]);
       
       // Calculates the width + height
       sWidth = max(constantCoords[0], changingCoords[0]) - min(constantCoords[0], changingCoords[0]);
       sHeight = max(constantCoords[1], changingCoords[1]) - min(constantCoords[1], changingCoords[1]);
       
       // Calculates the Center Coordinates
       centerX = topX + sWidth/2;
       centerY = topY + sHeight/2;
   }
  
  void updateXCoord() {
          // updates only the X Coordinate of the changing coordinate
          mouseOffSetX = mouseX-constantCoords[0];
          if(mouseOffSetX < 0){
            
            changingCoords[0] = constantCoords[0]+mouseOffSetX-constantOffset[0];
          }else{
            changingCoords[0] = constantCoords[0]+mouseOffSetX+constantOffset[0];
          }
  }
  
  void updateYCoord(){
          // updates only the Y Coordinate of the changing coordinate
          mouseOffSetY = mouseY- constantCoords[1];
          if(mouseOffSetY < 0){
            changingCoords[1] = constantCoords[1]+mouseOffSetY-constantOffset[1];
          } else{
            changingCoords[1] = constantCoords[1]+mouseOffSetY+constantOffset[1];
          } 
  }
  
}
