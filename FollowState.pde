class FollowState extends State {

  void enterState(Chaser chaser) {
    chaser.fillcolor = color(0, 255, 0);
  }
  
  void updateState(Chaser chaser, Target target) {
    float distanceToTarget = PVector.dist(chaser.location, target.location);
     stroke(255);
     noFill();
     ellipse(chaser.location.x, chaser.location.y, 300, 300);
    if (distanceToTarget > 1000) {
      // If the target is far, switch to the WanderState
      chaser.switchState(new WanderState());
    } else if (distanceToTarget < 100) {
      // If the chaser is close to the target, switch to the ArriveState
      chaser.switchState(new ArriveState());
    } else {
      // Otherwise, follow the path to the target
      chaser.followPathTo(target);
    }
  }
}
