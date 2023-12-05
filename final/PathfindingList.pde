class PathfindingList extends ArrayList<Node> {

  PathfindingList() {
    super();
  }


  
  Node getLowestFNode(ArrayList<AStar_Row> astarTable) {
    Node lowestFNode = this.get(0);
    float lowestF = 9999;
    
    for (Node n : this) {
      float currentNodeF = astarTable.get(n.id).f;
      
      if (currentNodeF < lowestF) {
        lowestF = currentNodeF;
        lowestFNode = n;
      }
    }
    return lowestFNode;
  }
  
  
}
