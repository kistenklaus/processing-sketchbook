public class Graph{
  
  private ArrayList<Float> v;
  private float bestValue;
  
  public Graph(){
    this.v = new ArrayList();
    for(int i = 0; i < 100; i++){
      this.v.add(height-height/5f);
    }
    this.bestValue = height;
  }
  
  public void addValue(float value){
    v.remove(0);
    if(value < bestValue){
      bestValue = value;
    }
    v.add(bestValue);
  }
  
  public void render(){
    strokeWeight(1);
    stroke(0);
    fill(255,100,100,100);
    
    beginShape();
    vertex(width,height-height/5f);
    vertex(0,height-height/5f);
    for(int i = 0; i < v.size(); i++){
      vertex((i/(v.size()-1f))*width, v.get(i));
    }
    endShape();
    
    strokeWeight(2);
    stroke(0,250,0);
    line(0,bestValue, width, bestValue);
    
  }
  
  public void reset(){
    this.v = new ArrayList();
    for(int i = 0; i < 500; i++){
      this.v.add(height-height/5f);
    }
    this.bestValue = height;
  }
  
  public float getBestValue(){
   return bestValue; 
  }
  
}
