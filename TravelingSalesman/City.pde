public class City{
  
  private PVector pos;
  private color cityColor;
  
  public City(){
    this.pos = new PVector(random(width), random(height/2)+height/4);
    this.cityColor = color(random(255), random(255), random(255), 255);
  }
  
  public City(PVector pos){
    this.pos = pos;
    this.cityColor = color(random(255), random(255), random(255), 255);
  }
  
  public void render(){
    stroke(255);
    strokeWeight(3);
    fill(cityColor);
    ellipse(pos.x,pos.y, 20,20);
  }
  
  public PVector getPos(){
   return new PVector(pos.x,pos.y); 
  }
  
  public color getColor(){
    return cityColor;
  }
  
  
}
