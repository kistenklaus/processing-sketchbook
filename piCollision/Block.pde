class Block{
  private double mass;
  private double vel;
  private double posX;
  private double posY;
  private PVector dim;
  public Block(double mass, double velocity, double posX, double posY, PVector dim) {
    this.mass = mass;
    this.vel = velocity;
    this.posX = posX;
    this.posY = posY;
    this.dim = dim;
  }
  public void move(double dT){
    this.posX += this.vel*dT;
  }
  public boolean wallCollision(double xWall){
      if (posX <= xWall) {
          vel*=-1;
          return true;
      }
      return false;
  }
  public boolean blockCollsision(Block other) {
     if ( this.posX < other.posX + other.dim.x && this.posX + this.dim.x > other.posX ) {
       collide(other);
       return true;
     }
     return false;
  }
  
  private void collide(Block other) {
    double v1 = this.vel, v2 = other.vel;
    double m1 = this.mass, m2 = other.mass;
    
    this.vel = ( (m1-m2)/(m1+m2) ) *v1 + ( (2*m2)/(m1+m2) )* v2;
    other.vel =( (2*m1)/(m1+m2) ) * v1 + ( (m2-m1)/(m1+m2) )* v2;
  }
  
  public void draw() {
    rect((float)this.posX, (float)(this.posY - this.dim.y), (float)this.dim.x, (float)this.dim.y);
  }
}
