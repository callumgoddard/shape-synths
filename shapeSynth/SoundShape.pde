
class SoundShape {
  
  int topX;
  int topY;
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
  int windowSizeX;
  int windowSizeY;
  
  Synth synth;
  
  SoundShape(int windowWidth, int windowHeight){
    
        windowSizeX = windowWidth;
        windowSizeY = windowHeight;
        
        // uses default sc server at 127.0.0.1:57110
        // defines what synth to be used
        synth = new Synth("rectSound");
        
        // sets parameters
        synth.set("freq", 400);
        synth.set("pwm", 0.5);
        synth.set("amp",0);
          
        // createsthe synth  
        synth.create();
  }
  
  
  void display(){
    
        // Check if mouse is in the drawn box.
        // if so then the highlight should be drawn.
        
        // Edge of shape is highlighted.  
        if (mouseX >= topX && mouseX <= topX+sWidth && 
            mouseY >= topY && mouseY <= topY+sHeight ){
            
            mouseOverShape = true;
      
            stroke(255);
            fill(153);
        } else {
            stroke(153);
            fill(153);
            mouseOverShape = false;
        }
    
        // Check if the rectangle should be drawn
        // prevents a single pixel rect being drawn
        // prevents sound
        if(sWidth == 0 && sHeight == 0){
          // no shape drawn, volume of synth set to 0
          synth.set("amp", 0);
          displayShape = false;
        }else{
          
         // Shape drawn, volume set to 0.1
         //rectMode(CENTER);
         rect(topX, topY, sWidth, sHeight);
         synth.set("amp",0.1);
         displayShape = true;
        }
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
       
       println("Top left Coord = " + topX +" "+topY+" Dims = "+sWidth+" "+sHeight);
       int[] brc = new int[2];
       brc[0] = topX+sWidth;
       brc[1] = topY+sHeight;
       println("bottom right coord " + brc[0]+" "+brc[1]);
       println("Mouse Possition" + mouseX+" "+mouseY);   
  }
  
  boolean selected(){
    
      // checks if the mouse is over the box
      // if it is, checks what part of the shape is clicked
      // if an edge is clicked the shape is resizable with a mouse drag.
      // if the mouse is just in the shape the mouse offset is
      // calculated relative to the rectangle's top coordinates.
      // The shape then moves when mouse is dragged.
      
      // if the mouse is not in the shape coordinates for the start of
      // a new shape are updated.
      
      if (mouseX > centerX-sWidth/2 && mouseX < centerX+sWidth/2 && 
          mouseY > centerY-sHeight/2 && mouseY < centerY+sHeight/2 ){
            
            // Indicates shape is currently selected.
            shapeSelected = true;
            
            // Calculates the mouse offset from the top corner
            mouseOffSetX = mouseX - topX;
            mouseOffSetY = mouseY - topY; 
            
            //Check if the top edge area is selected
            if(mouseX >= topX && mouseX <= topX+sWidth &&
               mouseY >= topY && mouseY <= topY + hEdgeArea){
                 
                 // updates the area selected to top
                 topSelected = true;
                 
               } 
             
            // Check if the bottom edge area is selected
            if(mouseX >= topX && mouseX <= topX+sWidth &&
               mouseY >= topY+sHeight-wEdgeArea && mouseY <= topY+sHeight){
                 
                 // updates the area selected to bottom.
                 bottomSelected  = true;
               } 
               
             // Check if left side is Selected
             if(mouseX >= topX && mouseX <= topX+wEdgeArea &&
                mouseY >= topY && mouseY <= topY+sHeight){
                 
                 // updates the area selected to left.
                 leftSelected    = true;
                 
               } 
               
             // Check if right side is Selected
             if(mouseX >= topX+sWidth-wEdgeArea && mouseX <= topX+sWidth &&
                mouseY >= topY && mouseY <= topY+sHeight){
                  
                 // updates the area selected to right.
                 rightSelected   = true;
             } 
             
                  // find which specific part of the shape is selected
                  if(topSelected){
                      if(leftSelected){                 
                        // Top left corner is selected its coordinates will change
                        changingCoords[0] = topX;
                        changingCoords[1] = topY;
                        
                        // find the coords of the opposite corner
                        // This is used as the reference point for
                        // resizing the shape.
                        constantCoords[0] = topX+sWidth;
                        constantCoords[1] = topY+sHeight;
                        
                        //update constantOffset
                        constantOffset[0] = abs(changingCoords[0]-mouseX);
                        constantOffset[1] = abs(changingCoords[1]-mouseY);
                        
                      }else if(rightSelected){
                        // Top Right corner is selected its coordinates will change
                        
                        changingCoords[0] = topX+sWidth;
                        changingCoords[1] = topY;
                        
                        // find the coords of the opposite corner
                        // This is used as the reference point for
                        // resizing the shape.
                        constantCoords[0] = topX;
                        constantCoords[1] = topY + sHeight;
                        
                        //update constantOffset
                        constantOffset[0] = abs(changingCoords[0]-mouseX);
                        constantOffset[1] = abs(changingCoords[1]-mouseY);
                        
                      }else{
                        // Top Right edge is selected selected its Y coordinates will change
                        //changingCoords[0] = topX;
                        changingCoords[1] = topY;
                        
                        // find the coords of the opposite corner
                        // This is used as the reference point for
                        // resizing the shape.
                        //constantCoords[0] = topX+sWidth;
                        constantCoords[1] = topY+sHeight;
                        
                        //update constantOffset
                        //constantOffset[0] = abs(changingCoords[0]-mouseX);
                        constantOffset[1] = abs(changingCoords[1]-mouseY);
                        
                      }
                    
                  }else if(bottomSelected){
                    
                      if(leftSelected){
                        // Bottom left corner is selected its coordinates will change
                        changingCoords[0] = topX;
                        changingCoords[1] = topY+sHeight;
                        
                        // find the coords of the opposite corner
                        // This is used as the reference point for
                        // resizing the shape.
                        constantCoords[0] = topX+sWidth;
                        constantCoords[1] = topY;
                        
                        //update constantOffset
                        constantOffset[0] = abs(changingCoords[0]-mouseX);
                        constantOffset[1] = abs(changingCoords[1]-mouseY);
                        
                      }else if(rightSelected){
                        // Bottom right corner is Selected its coordinates will change
                        changingCoords[0] = topX+sWidth;
                        changingCoords[1] = topY+sHeight;
                        // find the coords of the opposite corner
                        // This is used as the reference point for
                        // resizing the shape. 
                        constantCoords[0] = topX;
                        constantCoords[1] = topY;
                        
                        //update constantOffset
                        constantOffset[0] = abs(changingCoords[0]-mouseX);
                        constantOffset[1] = abs(changingCoords[1]-mouseY);

                      }else{
                        // Bottom edge is selected
                        //changingCoords[0] = topX;
                        changingCoords[1] = topY+sHeight;
                        
                        // find the coords of the opposite corner
                        // This is used as the reference point for
                        // resizing the shape.
                        //constantCoords[0] = topX+sWidth;
                        constantCoords[1] = topY;
                        
                        //update constantOffset
                        //constantOffset[0] = abs(changingCoords[0]-mouseX);
                        constantOffset[1] = abs(changingCoords[1]-mouseY);
                        
                      }
                    
                  } else if(leftSelected){
                      // left edge is selected its X coordinates will change
                        changingCoords[0] = topX;
                        //changingCoords[1] = topY;
                        
                        // find the coords of the opposite corner
                        // This is used as the reference point for
                        // resizing the shape.
                        constantCoords[0] = topX+sWidth;
                        //constantCoords[1] = topY+sHeight;
                        
                        //update constantOffset
                        constantOffset[0] = abs(changingCoords[0]-mouseX);
                        //constantOffset[1] = abs(changingCoords[1]-mouseY);

                      
                  } else if(rightSelected){
                      // Right Edge Selected its X coordinates will change
                        
                        changingCoords[0] = topX+sWidth;
                        //changingCoords[1] = topY;
                        
                        // find the coords of the opposite corner
                        // This is used as the reference point for
                        // resizing the shape.
                        constantCoords[0] = topX;
                        //constantCoords[1] = topY + sHeight;
                        
                        //update constantOffset
                        constantOffset[0] = abs(changingCoords[0]-mouseX);
                        //constantOffset[1] = abs(changingCoords[1]-mouseY);
                      
                  }
            }
          else {
             // shape is not selected
             shapeSelected = false;
             
             //unselects the edges
             topSelected = false;
             bottomSelected = false;
             leftSelected = false;
             rightSelected = false;
          }  
          
          return shapeSelected;
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
        
       // area calculated
       sArea = sWidth*sHeight;
        
       // selection areas calculated as a
       // percentage of the edge length
       wEdgeArea = (float(sWidth)/100)*10;
       hEdgeArea = (float(sHeight)/100)*10;
  }
  
  void resize(){
    
    //only resize in mouse is over the shape.
    if(mouseOverShape == true){
         
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
        
        if(mouseOverShape == true && topSelected == false && bottomSelected == false 
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
  
  void updateSynth() {
       // updating synth values. 
       
       // frequency is related to the the shape's area.
       // area calculated.  
       // shape freq = window area - shape area
       // (inversed to make big shapes make low frequencies.)
       // finally need to divided by 12.5 to scale it to audio range.
       // but using 100 to make max freq = 2500hz
       
       sArea = sWidth*sHeight;
       freq = (windowSizeX*windowSizeY-sArea)/4000;
      
       // PWM should be determined by the ratio of the shape, compared to the square it could make.
       if(sHeight > sWidth){
         
           float largerShape = float(sHeight)*float(sHeight);
           float smallerShape = float(sArea);
           
           pwm = smallerShape/largerShape;
           
       } 
       if (sWidth > sHeight){
         
           float largerShape = float(sWidth)*float(sWidth);
           float smallerShape = float(sArea);
           
           pwm = smallerShape/largerShape;   
       }
      
       if(sHeight == sWidth){
           pwm = 0.5;
       }
      
       //println("pwm = " + pwm);
      
       // panning value.
       // calculated by finding position of the shapes center
       // relative to the window's width.
       panning = (((float(centerX)/float(windowSizeX))-0.5)*2);
      
       // update the synth values
       synth.set("freq", freq);
       synth.set("pwm", pwm);
       synth.set("panning",panning);
  }
  
  void stop() {
       synth.free();
  }
}
