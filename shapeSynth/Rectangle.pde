class Rectangle extends Shape {
  
//   Synth synth;
    
   Rectangle(int wW, int wH){
     //updates the super class constructor 
     super(wW, wH); 
      
      // set up the synths the shape controls
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
   
   // draw function to draw the correct shape
   // also controls sound.
   void drawShape(){
       // if shape should be drawn it is
       // volume of sound is increased.
       if(displayShape){     
       synth.set("amp",0.1);
       rect(topX, topY, sWidth, sHeight);
       
       } else {
         // shape is not drawn and volume of shape is set to zero
         synth.set("amp",0);
       }
   }
     
    
   boolean mouseOverShape(){
       
        if (mouseX >= topX && mouseX <= topX+sWidth && 
              mouseY >= topY && mouseY <= topY+sHeight ){
            
            mouseOverShape = true;
        } else {
      
            mouseOverShape = false;
        }
      
        return mouseOverShape; 
   }
  
    boolean shapeSelected(){
    
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
  
}
