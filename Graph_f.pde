import java.util.Iterator;


class Graph {
  
  ArrayList<Node> nodes;
  
  Graph() {
    nodes = new ArrayList<Node>();
  }
  
  void addNode(Node n) {
    int id = nodes.size();
    n.id = id;
    nodes.add(n);
  }
  
  
  void printGraph() {
    for (Node n : nodes) {
      println(n.name + ":");
      for (Edge e : n.edges) {
        println("----" + e.endNode.name + ", " + e.cost);
      }
      println();
    }
  
  }
  
  void reset() {
    for (Node n : nodes) {
      n.reset();
    }
  }
  
  void handleBlockedNodes() {
    
    for (Node n : this.nodes) {
      if (n.block) {
        
        
        n.edges.clear();
      } else {  
        Iterator it = n.edges.iterator();
    
        // Loop through ArrayList contents
        while(it.hasNext()) {
          Edge e = (Edge) it.next();
          // If item is even remove the element
          if (e.endNode.block) {
            it.remove();
          }
        }
      }
      
    }
  }
  
  ArrayList<Edge> astar(Node start, Node end) {
    
    // unvisited nodes
    PathfindingList unvisited = new PathfindingList();
    // visited nodes
    PathfindingList visited = new PathfindingList();
    
    // create our table
    ArrayList<AStarRow_> astarTable = new ArrayList<AStarRow_>();
    
    // setup our Dijkstra table
    for (Node node : nodes) {
      float h = PVector.dist(node.position, end.position);
      AStarRow_ row = new AStarRow_(node, null, 9999, h, 9999);
      astarTable.add(row);
    }
    
    // set the lowest cost of our starting node to 0
    // this is because we are already there
    astarTable.get(start.id).g = 0;
    astarTable.get(start.id).f = astarTable.get(start.id).h;
    
    // add our starting node to the unvisited array
    unvisited.add(start);
    
    while (!unvisited.isEmpty()) {
      
      // we get the lowest F cost 
      // as our current node or "most promising"
      Node current = unvisited.getLowestFNode(astarTable);
      
      if (current == end) {
        break;
      }
    
      for (Edge e : current.edges) {
      
        float gcost = e.cost + astarTable.get(current.id).g;
        
        // get the edge row
        AStarRow_ edgeRow = astarTable.get(e.endNode.id);
        
        if (edgeRow.g > gcost) {
          edgeRow.best = e;
          edgeRow.g = gcost;
          edgeRow.f = edgeRow.h + edgeRow.g;
          astarTable.set(e.endNode.id, edgeRow);
        }
        
        if (!visited.contains(e.endNode) && !unvisited.contains(e.endNode)) {
          unvisited.add(e.endNode);
        }
        
      }
      unvisited.remove(current);
      visited.add(current);
    
    }
    
    // work backwards to get the whole path
    ArrayList<Edge> path = new ArrayList<Edge>();
    Node node = end;
    while (node != start) {
      if (astarTable.get(node.id).best == null) {
        println("There is no solution");
        break;
      }
      path.add(0, astarTable.get(node.id).best);
      node = astarTable.get(node.id).best.startNode;
    }
    
    return path;
  }
  
  /**
  
  This method sets up the this
  
  **/
  void createGraph(int cols, int rows) {
  
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        Node n = new Node("", new ArrayList<Edge>(), i*tileSize, j*tileSize, tileSize);
        this.addNode(n);
    
      }
    }
    
    
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        int index = j * cols + i;
  
        if (i > 0) {
          Edge left = new Edge(this.nodes.get(index), this.nodes.get(index - 1), tileSize);
          this.nodes.get(index).edges.add(left);
          
        }
        if (i < cols - 1) {
          Edge right = new Edge(this.nodes.get(index), this.nodes.get(index + 1), tileSize);
          this.nodes.get(index).edges.add(right);
          
        }
        if (j > 0) {
          Edge top = new Edge(this.nodes.get(index), this.nodes.get(index - cols), tileSize);
          this.nodes.get(index).edges.add(top);
        }
        if (j < rows - 1) {
          Edge bottom = new Edge(this.nodes.get(index), this.nodes.get(index + cols), tileSize);
          this.nodes.get(index).edges.add(bottom);
        } 
      }
    }
    
    int obstacles = 0;
    for (int i = 0; i < obstacles; i++) {
      int m = (int) random(1, this.nodes.size()-2);
      this.nodes.get(m).block();
    }
    
    this.handleBlockedNodes();
    
  }
  
  
  Node getRandomEmptyNode() {
    Node random = nodes.get(floor(random(nodes.size())));
    while (random.block) {
      random = nodes.get(floor(random(nodes.size())));
    }
    return random;
  }
  
 
  
  
}
