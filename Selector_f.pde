class Selector extends BTNode {

  ArrayList<BTNode> children;
  
  Selector() {
    children = new ArrayList<BTNode>();
  }

  Status run() {
    
    for (BTNode child : children) {
      if (child.run() == Status.Success) {
        return Status.Success;
      }
    }
    return Status.Failure;
    
  }


}
