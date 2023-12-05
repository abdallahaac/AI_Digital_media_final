class Seek extends BTNode {

  Guard guard;
  
  Seek(Guard g) {
    guard = g;
  }
  
  Status run() {
   
    guard.fillcolor = color(0,0,255);
    PVector seek = guard.seek(new PVector(mouseX, mouseY));
    fill(200,200,255);
    ellipse(guard.location.x, guard.location.y, 400, 400);
    guard.applyForce(seek);
    return Status.Success;
    
  }

}
