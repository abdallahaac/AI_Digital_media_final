enum Status {
  Success,
  Failure,
  Running
}

abstract class BTNode {

  abstract Status run();
  
}
