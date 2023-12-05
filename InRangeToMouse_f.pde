class InRangeToMouse extends Condition {

  Chaser guard;
  float radius;
  
  InRangeToMouse(Chaser g, float r) {
    
    super();
    
    guard = g;
    radius = r;
   
  }
  
  Status run() {
    float d = PVector.dist(chaser.location, new PVector(mouseX, mouseY));
    super.condition = d < radius;
    return super.run();
  }

}
