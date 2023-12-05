abstract class State {

  abstract void enterState(Chaser chaser);
  
  abstract void updateState(Chaser chaser, Target target);
  
}


class WanderState extends State {

  void enterState(Chaser chaser) {
    chaser.fillcolor = color(0, 255, 0);
  }

  void updateState(Chaser chaser, Target target) {
    PVector wander = chaser.wander();
    stroke(255);
    noFill();
    chaser.setRadius(300);
    ellipse(chaser.location.x, chaser.location.y, chaser.getRadius(), chaser.getRadius());

    chaser.applyForce(wander);
     // Check if the mouse is near, and switch to SeekState
    if (PVector.dist(chaser.location, new PVector(mouseX, mouseY)) < 100) {
      chaser.switchState(new SeekState());
    }
  }
}


class SeekState extends State {

  void enterState(Chaser chaser) {
    chaser.fillcolor = color(0, 0, 255);
  }

  void updateState(Chaser chaser, Target target) {
    // the mouse 
    PVector seek = chaser.seek(new PVector(mouseX, mouseY));
     stroke(255);
     noFill();
      chaser.setRadius(200);
     ellipse(chaser.location.x, chaser.location.y, chaser.getRadius(), chaser.getRadius());

    chaser.applyForce(seek);
    
    if (PVector.dist(chaser.location, new PVector(mouseX, mouseY)) > 100) {
      chaser.switchState(new WanderState());
    }
    
    
  }
}



class ArriveState extends State {

  int startTime; // Variable to store the start time when entering ArriveState
  int delayDuration = 3000; // Delay duration in milliseconds (3 seconds)

  void enterState(Chaser chaser) {
    chaser.fillcolor = color(255, 0, 0); // Orange color for arrive state
    startTime = millis(); // Record the start time
  }

  void updateState(Chaser chaser, Target target) {
    PVector arriveForce = chaser.arrive(target.location, 10); // Adjust 50 based on your requirements
    chaser.applyForce(arriveForce);
    stroke(255);
    noFill();
    ellipse(chaser.location.x, chaser.location.y, 50, 50);
    
    // Check if the chaser has arrived at the target's location
    float arrivalThreshold = 10; // Adjust this threshold based on your requirements
    if (PVector.dist(chaser.location, target.location) < arrivalThreshold) {
      // Check if enough time has passed before transitioning to the next state
      if (millis() - startTime >= delayDuration) {
        chaser.switchState(new WanderState()); // Switch to WanderState after the delay
        target.location = graph.getRandomEmptyNode().getTileCenter(); // Update target's location
      }
    }
  }
}
