class InRangeToMouse extends Condition {

  Guard guard;
  float radius;
  
  InRangeToMouse(Guard g, float r) {
    
    super();
    
    guard = g;
    radius = r;
   
  }
  
  Status run() {
    float d = PVector.dist(guard.location, new PVector(mouseX, mouseY));
    super.condition = d < radius;
    return super.run();
  }

}
