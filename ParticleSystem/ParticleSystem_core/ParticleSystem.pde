class ParticleSystem{
  
  private ArrayList<Particle> p;
  private PImage[] imgs;

  
  public ParticleSystem(PImage[] imgs) {
    this.imgs = imgs;
    p = new ArrayList<Particle>();

  }
  
  
  public void add(PVector pos, int sampler){
    this.p.add(new Particle(pos, imgs[sampler]));
  }
  
  public void applyForce(PVector f){
    for(Particle part : p){
       part.applyForce(f); 
    }
  }
  
  public void update(){
    for(int i = 0; i < p.size(); i++){
      Particle part = p.get(i);
      if(part.isAlive()){
        part.update();
      }else{
        p.remove(i);
        i--;
      }
    }
  }
  
  public void render(){
    for(Particle part : p){
      part.render();
    }
  }
}
