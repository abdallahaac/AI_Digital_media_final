class IdleState extends State {

  void enterState(Chaser chaser) {
    chaser.fillcolor = color(0,0,255);
  }
  
  void updateState(Chaser chaser, Target target) {
    if (PVector.dist(chaser.location, target.location) < 1000) {
      chaser.switchState(new FollowState());
    } else {
     
    }
  }
  
}
