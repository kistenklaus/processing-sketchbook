class Planet{
  
  private color planetColor;
  private float size;
  private PVector pos;
  private ParticelHandler partHandler;
  private PImage fire;
  
  public Planet(PVector pos, float size, color planetColor, ParticelHandler partHandler, PImage fog){
    this.pos = pos;
    this.size = size;
    this.planetColor = planetColor;
    this.partHandler = partHandler;
    
    this.fire = loadImage("Fire.png");
    
    for(int i = 0; i < 2; i++){
      partHandler.add(new ParticelSystem(this,fog,Float.MAX_VALUE));
    }
  }
  
  public void update(){
    
  }
  
  public void render(){
  }
  
  public float getSize(){
    return size;
  }
  
  public PVector getPos(){
    return new PVector(pos.x, pos.y);
  }
  
  public color getColor(){
   return planetColor; 
  }
  
}
