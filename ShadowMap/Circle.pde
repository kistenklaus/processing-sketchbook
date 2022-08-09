
class Circle extends Body{
  
  private final int SEGS = 10;
  
  PVector position;
  float radius;
  
  public Circle(PVector pos, float r){
    position = pos;
    radius = r;
    constructVerticies();
  }
  
  
  public void constructVerticies(){
    verticies.clear();
    float delta = (float)((Math.PI*2.0d)/SEGS);
    for(int i=0;i<SEGS;i++){
      PVector vertex = new PVector((float)Math.cos(delta*i)*radius, (float)Math.sin(delta*i)*radius);
      this.verticies.add(vertex.add(position));
    }
  }
  
}
