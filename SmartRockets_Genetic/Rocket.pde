class Rocket{
  
  private PVector pos, vel, acc;
  private float angle;
  private DNA dna;
  private color c;
  
  Rocket(DNA dna, color c){
    this.c = c;
    this.pos = new PVector(width/2,height/2);
    this.vel = new PVector();
    this.acc = new PVector();
    this.angle = 0;
    this.dna = dna;
    
  }
  
  void applyForce(PVector f){
    acc.add(f);
  }
  
  void update(int count){
    applyForce(dna.getGene(count));
    applyForce(new PVector(0,10));
    applyForce(new PVector(0,0));
    count++;
    this.vel.add(acc);
    this.pos.add(vel);
    this.acc.mult(0);
    if(pos.y > height)vel.y*=-1;
    if(pos.y < 0)vel.y*=-1;
    /*
    if(pos.x > width)vel.x*=-1;
    if(pos.x < 0)vel.x*=-1;
    */
    
    this.angle = (atan((vel.y+0.001)/(vel.x+0.001)));
  }
  
  void render(){
    translate(pos.x,pos.y);
    rotate(angle);
    smooth();
    rectMode(CENTER);
    stroke(0,0);
    fill(c);
    rect(0,0,50,10);
    ellipse(0,0,20,20);
    rotate(-angle);
    translate(-pos.x,-pos.y);
  }
  
  float validate(PVector destiny){
    return 1f/pos.dist(destiny);
  }
  
  public DNA getDNA(){
    return dna;
  }
  
}
