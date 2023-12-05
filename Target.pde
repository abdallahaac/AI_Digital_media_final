class Target extends Character {
  
  Target() {
    super(color(100,100,100,0));
    
    
    this.location = graph.getRandomEmptyNode().getTileCenter();
  }
 
  Node getNodeFromOffset(int xOffset, int yOffset) {
    int tileX = floor((location.x+xOffset)/tileSize);
    int tileY = floor((location.y+yOffset)/tileSize);
    int index = tileY * cols + tileX;
    if ((index >= 0) && (index < graph.nodes.size()))
      return graph.nodes.get(tileY * cols + tileX);
    else 
      return null;
  }
}
