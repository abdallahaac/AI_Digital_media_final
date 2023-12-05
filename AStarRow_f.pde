class AStarRow_ {
  
  Edge best;
  Node to;
  
  float g;
  float h;
  float f;
  
  AStarRow_(Node t, Edge b, float gN, float hN, float fN) {
    to = t;
    best = b;
    
    g = gN;
    h = hN;
    f = fN;
  }
  
  
} 
