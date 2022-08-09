public class Route{
  
  private DNA dna;
  private City[] cities;
  private float extent;
  
  public Route(City[] cities){
    this.cities = cities;
    this.dna = new DNA(cities.length);
    
    this.extent = calcExtent();
  }
  
  public Route(City[] cities, DNA dna){
   this.cities = cities;
   this.dna = dna;
   this.extent = calcExtent();
  }
  
  
  private float calcExtent(){
    float extent = 0;
    int[] order = dna.getOrder();
    for(int i = 0; i < order.length-1; i++){
      extent += cities[order[i]].getPos().sub(cities[order[i+1]].getPos()).magSq()/100000f;
    }
    //extent += cities[0].getPos().sub(cities[cities.length-1].getPos()).mag();
    return extent;
  }
  
  public float getExtent(){
    return extent;
  }
  public DNA getDNA(){
    return dna;
  }
  
}
