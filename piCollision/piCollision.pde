private final double dT = 0.1;
private final int timeSteps = 1000;
private final int digits = 4;

private int collCount = 0;
private Block b1, b2;
void setup() {
  size(640,480, P2D);
  background(0);
  this.b1 = new Block(pow(100, digits-1),-10, width/2, height/3*2, new PVector(100,100));
  this.b2 = new Block(1, 0, width/3, height/3*2, new PVector(50,50));
}

void draw() {
  for(int i = 0; i < timeSteps; i++){
      if (b1.wallCollision(0) ||  b2.wallCollision(0)) {
        collCount++;
      }
      if (b1.blockCollsision(b2)) {
        collCount++;
      }
      b1.move(dT/timeSteps);
      b2.move(dT/timeSteps);
      
      background(0);
      b1.draw();
      b2.draw();
  }
  text("Amount of Collisions: " + collCount, 20, 40);
}
