

PImage part1;
ParticleSystem ps;

void setup(){
  fullScreen(P2D,1);
  this.part1 = loadImage("part1.png");
  
  this.ps = new ParticleSystem(new PImage[]{part1});
  blendMode(ADD);

}

void draw(){
  background(0);
  for(int i = 0; i < 100; i++){
    ps.add(new PVector(random(width), height), 0);
  }
  
  if(mousePressed){
    ps.applyForce(new PVector(-0.05f,0));
  }
  
  ps.update();
  
  ps.render();
}
