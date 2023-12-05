PVector[] particles;
int num = 20000;
float noiseScaler = 0.01;
int backgroundColor = 10;

Graph graph;
int cols, rows;
int tileSize;
boolean isDKeyPressed = false;

Target target;
Chaser chaser;
ParticleSystem particleSystem;

void setup() {
  size(800, 600);
  particles = new PVector[num];

  for (int i = 0; i < num; i++) {
    particles[i] = new PVector(random(width), random(height));
    stroke(255);
  }

  tileSize = 50;
  cols = width / tileSize;
  rows = height / tileSize;

  graph = new Graph();
  graph.createGraph(cols, rows);

  target = new Target();
  chaser = new Chaser();
  
  particleSystem = new ParticleSystem(num, noiseScaler, backgroundColor,chaser, target,graph);
}

void draw() {
  for (Node n : graph.nodes) {
    n.display();
    n.reset();
  }
  background(0, particleSystem.getBackgroundColor());
  
  target.display();

  particleSystem.update();

  chaser.display();

  chaser.updateChaser(target);
}

void keyPressed() {
  if (key == 'd' || key == 'D') {
    isDKeyPressed = true;
    chaser.switchState(new FollowState());
  }
}
