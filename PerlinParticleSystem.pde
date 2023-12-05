
class ParticleSystem {

  Graph graph;
  Chaser chaser;
  Target target;
  PVector[] particles;
  int num;
  float noiseScaler;
  int maxTrailLength;
  int backgroundColor;

  ParticleSystem(int num, float noiseScaler, int backgroundColor, Chaser chaser, Target target, Graph graph) {
    this.num = num;
    this.noiseScaler = noiseScaler;
    this.backgroundColor = backgroundColor;
    this.chaser = chaser;
    this.target = target;
    this.graph = graph;

    particles = new PVector[num];

    for (int i = 0; i < num; i++) {
      particles[i] = new PVector(random(width), random(height));
    }
  }

  void update() {
  for (int i = 0; i < num; i++) {
    PVector p = particles[i];
    float angle;
    float radius;

    float alpha = map(i, 0, num, 0, 255);
    stroke(255, alpha);
    point(p.x, p.y);

    float n = noise(p.x * noiseScaler, p.y * noiseScaler);
    float a = TAU * n;
    p.x += cos(a);
    p.y += sin(a);

    PVector onScreenResult = onScreen(p);
    if (onScreenResult == null || alpha < 10) {
      if (chaser.currentState instanceof FollowState) {
        // Majority of particles spawn at the target's location
        if (random(1) > 0.8) {
          radius = random(50); // Set the desired radius range
          angle = random(TWO_PI);
          p.x = target.location.x + cos(angle) * radius;
          p.y = target.location.y + sin(angle) * radius;
        } else {
          // Other half spawn randomly
          p.x = random(width);
          p.y = random(height);
        }
      } else if (chaser.currentState instanceof WanderState) {
        // Same logic as above for the WanderState
        if (random(1) > 0.5) {
          radius = random(50); // Set the desired radius range
          angle = random(TWO_PI);
          p.x = target.location.x + cos(angle) * radius;
          p.y = target.location.y + sin(angle) * radius;
        } else {
          p.x = random(width);
          p.y = random(height);
        }
      } else if (chaser.currentState instanceof SeekState) {
          angle = random(TWO_PI);

              println("Seek");
            float   x = chaser.location.x + cos(angle) * random(chaser.getRadius());
       float    y = chaser.location.y + sin(angle) * random(chaser.getRadius());
          p.x = x;
          p.y = y;
        }
    }
  }

  if (backgroundColor > 0) {
    backgroundColor -= 1;
  }
}


  int getBackgroundColor() {
    return backgroundColor;
  }

  PVector onScreen(PVector v) {
    if (v.x >= 0 && v.x <= width && v.y >= 0 && v.y <= height) {
      return v;
    } else {
      return null;
    }
  }
}
