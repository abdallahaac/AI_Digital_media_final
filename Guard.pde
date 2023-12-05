//class Guard extends Character {

//  BTNode root;
  
//  Guard(color c) {
//    super(c);
//    Selector selector = new Selector();
    
//    Sequence attack = new Sequence();
//    attack.children.add(new InRangeToMouse(this, 25));
//    attack.children.add(new Attack(this));
    
//    Sequence seek = new Sequence();
//    seek.children.add(new InRangeToMouse(this, 200));
//    seek.children.add(new Seek(this));
    
//    Wander wander = new Wander(this);
        
    
//    selector.children.add(attack);
//    selector.children.add(seek);
//    selector.children.add(wander);
    
//    root = selector;
//  }

//  void updateGuard() {
    
//    root.run();
    
//    super.update();
//    super.checkEdges();
//    super.display();
    
//  }

//}
