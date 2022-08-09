class Particel{
  private PVector pos, vel, acc;
  private float time, timer;
  private float red, green, blue;
  private PImage fog;
  
  public Particel(PVector pos, float timer, float red, float green, float blue, PImage fog){
    this.pos = new PVector(pos.x, pos.y);
    this.timer = timer;
    this.time = timer;
    this.red =red;
    this.green = green;
    this.blue = blue;
    this.vel = new PVector();
    this.acc = new PVector();
    this.fog = fog;
  }
  /**
  @return isAlive
  **/
  public boolean update(){
    this.acc.add(PVector.random2D().mult(0.5));
    this.vel.add(acc);
    this.pos.add(vel);
    this.acc.mult(0);
    time -= 0.016;
    if(time < 0){
      return false;
    }
    return true;
  }
  
  public void render(PGraphics canvas){
    canvas.tint(red, green, blue, (time/timer) * 100);
    canvas.imageMode(CENTER);
    canvas.image(fog, pos.x, pos.y, 32, 32);
  }
  
  
}
