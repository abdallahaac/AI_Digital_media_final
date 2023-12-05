class Wander extends BTNode {

  Guard guard;
  
  Wander(Guard g) {
    guard = g;
  }
  
  Status run() {
    guard.fillcolor = color(0,255,0);
    PVector wander = guard.wander();
    noFill();
    ellipse(guard.location.x, guard.location.y, 400, 400);
    guard.applyForce(wander);
    return Status.Success;
    
    
  }
  
  

}
