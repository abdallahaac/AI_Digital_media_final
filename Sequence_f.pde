class Sequence extends BTNode {

  ArrayList<BTNode> children;
  
  Sequence() {
    children = new ArrayList<BTNode>();
  }
  
  Status run() {
    
    for (BTNode child : children) {
      if (child.run() != Status.Success) {
        return Status.Failure;
      }
    }
    return Status.Success;
  }
}
