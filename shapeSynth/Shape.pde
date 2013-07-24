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
  boolean highlightShape = false;
  boolean shapeSelected;
  boolean topSelected;
  boolean bottomSelected;
  boolean leftSelected;
  boolean rightSelected;
  boolean startShape;
  boolean shapeTooSmall;
  int windowSizeX;
  int windowSizeY;
  Synth synth;

  Shape(int windowWidth, int windowHeight){
    
        windowSizeX = windowWidth;
        windowSizeY = windowHeight;
  }
  
  void display(){
     
    // check is mouse of over the shape
    if(shapeSelected){
      
      // mouse is over the shape so it is highlighted
      stroke(255);
      //fill(48,139,206, 80);   
      
    } else{
      
      // mouse is not over the shape so it is not highlighted
      stroke(48,139,230); 
      fill(48,139,206, 35);
    }
    
    
   
    // prevent a shape being drawn that is too small to select
    if(sWidth == 0 && sHeight == 0){
          // no shape drawn and display boolean updated
          displayShape = false;
          drawShape(); 
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
        shapeSelected = true;
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
  
   void resize(){
    
    //only resize if the shape has been selected.
    if(shapeSelected == true){
         
      // Prevents a new rectangle being drawn when 
      // the mouse is over the rectangle.
      if (startShape == true){
        
       // update the new mouse Possition
       arrayCopy(getMouseCoords(), changingCoords);
        
       // Update the shape parameters
       updateShapeParams();
        
          
      } else {
        
        // Part of the rectangle has been selected
        // test to find out what part to control
        // the type of manipulation that is to be performed.
        
        if(shapeSelected == true && topSelected == false && bottomSelected == false 
            && leftSelected == false && rightSelected == false){
              
              // no edge or corner has been selected
              // move the rectangle.
              //topX = mouseX - mouseOffSetX;
              //topY = mouseY - mouseOffSetY;
              
              int tempTopX = topX+mouseX-pmouseX;
              int tempTopY = topY+mouseY-pmouseY;
              int bottomX = topX+sWidth+mouseX-pmouseX;
              int bottomY = topY+sHeight+mouseY-pmouseY;
              
              // stops the shape moveing out of the window.
              if(tempTopX < 0){
                tempTopX = 0;
                bottomX = tempTopX+sWidth;
              }
              
              if(tempTopY < 0){
                tempTopY = 0;
                bottomY = tempTopY+sHeight;
              }
              
              if(bottomX > windowSizeX){
                bottomX = windowSizeX;
                tempTopX = bottomX-sWidth;
              }
              
              if(bottomY > windowSizeY){
                bottomY = windowSizeY;
                tempTopY = bottomY-sHeight;
              }
                        
              constantCoords[0] = tempTopX;
              constantCoords[1] = tempTopY;
              changingCoords[0] = bottomX;
              changingCoords[1] = bottomY;
          
              updateShapeParams();

              // Calculate the center point of the rectangle
              //centerX = topX + sWidth/2;
              //centerY = topY + sHeight/2;

              
            }else{
              // An Edge of Corner has been selected
    
                  if(topSelected){
                   
                      if(leftSelected){                 
                        // Top left corner is selected
                        // update changing coordinates
                        updateCoords();
                        // Update Shape Parameters
                        updateShapeParams();

                      }else if(rightSelected){
                        // Top Right corner is selected
                        // update changing coordinates
                        updateCoords();
                        // Update Shape Parameters
                        updateShapeParams();
                        
                      }else{
                        // Top Right edge is selected
                        // update changing coordinates
                        updateYCoord();
                        // Update Shape Parameters
                        updateShapeParams();                        
                      }
                    
                  }else if(bottomSelected){
                    
                      if(leftSelected){
                        // Bottom left corner is selected
                        // update changing coordinates
                        updateCoords();
                        // Update Shape Parameters
                        updateShapeParams();
                        
                      }else if(rightSelected){
                        // Bottom right corner is Selected 
                        // update changing coordinates
                        updateCoords();
                        // Update Shape Parameters
                        updateShapeParams();
                        
                      }else{
                        // Bottom edge is selected
                        // update changing coordinates
                        updateYCoord();
                        // Update Shape Parameters
                        updateShapeParams();                      
                      }
                    
                  } else if(leftSelected){
                      // left edge is selected
                      // update changing coordinates
                      updateXCoord();
                      // Update Shape Parameters
                      updateShapeParams();
                      
                  } else if(rightSelected){
                      // Right Edge is selected
                      // update changing coordinates
                      updateXCoord();
                      // Update Shape Parameters
                      updateShapeParams();
                  }
              
            }
    
      }
    }
  } 
   
     void unselectShape() {
    
       // when shape is unselected
       // if width and/or height is negative - update the values,
       // so that topX and topY are always the top left corner.
       if(sWidth < 0){
         topX = topX+sWidth;
         sWidth = -sWidth;
       }   
       if(sHeight < 0){
           topY = topY+sHeight;
           sHeight = -sHeight;
       } 
       
       //unselects the edges
       topSelected = false;
       bottomSelected = false;
       leftSelected = false;
       rightSelected = false;
       
       startShape = false;
       
       shapeSelected = false;
        
       // area calculated
       sArea = sWidth*sHeight;
        
       // selection areas calculated as a
       // percentage of the edge length
       // wEdgeArea = (float(sWidth)/100)*10;
       // hEdgeArea = (float(sHeight)/100)*10;
       
       wEdgeArea = 5;
       hEdgeArea = 5;
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
  
    
  void stop() {
       synth.free();
  }
  
}
