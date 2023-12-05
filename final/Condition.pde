class Condition extends BTNode {

  boolean condition;
  
  Condition() {
  }

  Status run() {
    if (condition) {
      return Status.Success;
    } else {
      return Status.Failure;
    }
  }

}
