class Character {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  float mass = 1;
  float maxforce = 0.1;
  
  float wanderAngle = 0;
  
  color fillcolor;
  
  int radius;
  /*
  Constructor
  */
  Character(color c) {
    
    location = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 2.5;
    fillcolor = c;
    
  }
 
  
  
  
  /*
  Display the character
  */
  void display() {
    
    float angle = atan2(velocity.y, velocity.x);
    
    rectMode(CENTER);
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle + PI/2);
    
    stroke(0);
    fill(fillcolor);
    
    beginShape();
    vertex(0,0);
    vertex(-10,25);
    vertex(10,25);
    vertex(0,0);
    endShape();
    popMatrix();
    
  }
  
  /*
  Bounded by edges
  */
  void checkEdges() {
    
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
    
  }

  /*
  Apply Steering Force
  */
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  /*
  Update character
  */
  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);
    
  }
  
  /* 
  Seek steering behaviour
  */
  PVector seek(PVector target) {
    
    PVector desired = PVector.sub(target,location);
    desired.normalize();
    desired.mult(topspeed);
    
    PVector steer = PVector.sub(desired,velocity);
    
    steer.limit(maxforce);
    return steer;
    
  }
  
  /*
  Arrive steering behaviour
  */
  PVector arrive(PVector target, float r) {
    PVector desired = PVector.sub(target,location);
    float distance = desired.mag();
    desired.normalize();
    
    if (distance < r) {
      // map the speed by the distance from the target
      float speed = (distance/r) * topspeed;
      desired.mult(speed);
    } else {
      desired.mult(topspeed);
    }
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
    
  }
   PVector wander() {
  
    float wanderRadius = 25;         // Radius for our "wander circle"
    float wanderDist = 80;         // Distance for our "wander circle"
    float change = 0.3;
    
    PVector prediction = velocity.copy();
    prediction.normalize();
    prediction.mult(wanderDist);
    prediction.add(location);
    
    wanderAngle += random(-change, change);
    
    float currentDirection = atan2(velocity.y, velocity.x);
    float newDirection = currentDirection + wanderAngle;
    
    float x = wanderRadius * cos(newDirection);
    float y = wanderRadius * sin(newDirection);
    
    PVector targetOffset = new PVector(x, y);
    PVector target = PVector.add(prediction, targetOffset);
    
    return seek(target);
  }
  
  void setRadius(int radius){
    
    this.radius = radius;
  
  }
  
  int getRadius(){
  
  return radius;
  }
  
}
