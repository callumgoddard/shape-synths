class Triangle extends Shape{
  
  Synth synth;
  
  // constructor
  Triangle(int wW, int wH){
     //updates the super class constructor 
     super(wW, wH); 
      
      // set up the synths the shape controls
      // uses default sc server at 127.0.0.1:57110
      // defines what synth to be used
      synth = new Synth("circSound");
      
      // sets parameters
      synth.set("freq",400);
      synth.set("amp",0);
        
      // createsthe synth  
      synth.create();
   }
   
   boolean mouseOverShape(){
     
     return mouseOverShape;
   }
   
   boolean shapeSelected(){
    
    return shapeSelected;
   }
   
   void updateSynth(){
     
   }
   
   void stop() {
       synth.free();
  }
  
}
