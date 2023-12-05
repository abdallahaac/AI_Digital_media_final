class Chaser extends Character {
  BTNode root;

  State currentState;
  
 
  Chaser() {
    super(color(0,0,255));
    this.location = graph.getRandomEmptyNode().getTileCenter();
    currentState = new IdleState();
  }
  
  void switchState(State state) {
    currentState = state;
    state.enterState(this);
  }
  
  void updateChaser(Target t) {
    currentState.updateState(this, t);
        
    super.checkEdges();
    super.display();
    super.update();

  }
  
  void followPathTo(Target t) {
    
    
    Node chaseNode;
    Node targetNode;
    
    int chaseNodeX = floor(location.x/tileSize);
    int chaseNodeY = floor(location.y/tileSize);
    
    chaseNode = graph.nodes.get(chaseNodeY * cols + chaseNodeX);
    
    int targetNodeX = floor(t.location.x/tileSize);
    int targetNodeY = floor(t.location.y/tileSize);
    
    targetNode = graph.nodes.get(targetNodeY * cols + targetNodeX);
        
    PVector steer;
    if (chaseNode == targetNode) {
      steer = this.arrive(targetNode.getTileCenter(), tileSize);
      
    } else {
      ArrayList<Edge> path = graph.astar(chaseNode, targetNode);
      for (Edge e : path) {
        e.endNode.path();
      }
      
      steer = this.seek(path.get(0).endNode.getTileCenter());
    }
    
    this.applyForce(steer);
    
  }
 

}
