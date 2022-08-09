class Particle{
  
  private PVector pos, vel, acc;
  private PImage img;
  private boolean alive;
  private int psize;
  private float blend;
  private int ticksAlive;
  private int tickSpan;
  private double a;
  
  public Particle(PVector pos, PImage img){
    this.pos = new PVector(pos.x, pos.y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.img = img;
    this.alive = true;
    this.psize = 32;
    this.ticksAlive = 0;
    this.tickSpan = 75+floor(random(50));
    this.a = random(TWO_PI);
  }
  
  public void applyForce(PVector f){
    acc.add(f);
  }
  
  public void update(){
    applyForce(new PVector(0,-0.1));
    float perDone = (1-ticksAlive/(float)tickSpan);
    
    double cur = a + perDone*TWO_PI;
    applyForce(new PVector(0.05f*sin((float)cur),0));
    
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    
    ticksAlive++;
    
    this.blend = perDone * 255;
    
    if(ticksAlive > tickSpan){
      this.alive = false;
    }
    
    if(pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0){
      this.alive = false;
      return;
    }
    
  }
  
  public void render(){
    tint(255, this.blend);
    image(img, pos.x-psize/2f,pos.y-psize/2f, psize, psize);
    
  }
  
  public boolean isAlive(){
    return alive;
  }
  
}
