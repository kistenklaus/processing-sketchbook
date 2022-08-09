

class Quad extends Body{
  
  private PVector position;
  private PVector dimension;
  
  public Quad(PVector position, PVector dimension){
    this.position = position;
    this.dimension = dimension;
    constructVerticies();
  }
 
 
  void constructVerticies(){
    verticies.clear();
    float hw = dimension.x/2.0f;
    float hh = dimension.y/2.0f;
    float x = position.x, y = position.y;
    verticies.add(new PVector(x-hw, y-hh));
    verticies.add(new PVector(x-hw, y+hh));
    verticies.add(new PVector(x+hw, y+hh));
    verticies.add(new PVector(x+hw, y-hh));
    
  }
  
}
