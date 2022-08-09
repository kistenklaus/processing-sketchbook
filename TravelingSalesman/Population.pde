public class Population{
  
  private City[] cities;
  private Route[] routes;
  private int generation;
  
  private float[] fittnesses;
  private Route bestRoute;
  private Route totalBestRoute;
  
  public Population(City[] cities){
    this.cities = cities;
    this.routes = new Route[500];
    for(int i = 0; i < routes.length; i++){
      routes[i] = new Route(cities);
    }
    this.generation = 1;
  }
  
  public Population(City[] cities, Route totalBestRoute){
    this.cities = cities;
    this.routes = new Route[500];
    for(int i = 0; i < routes.length; i++){
      routes[i] = new Route(cities);
    }
    this.generation = 1;
    this.totalBestRoute = totalBestRoute;
  }
  
  private void mapFittness(){
    this.fittnesses = new float[routes.length];
    float maxExtent = (width+height) * cities.length;
    int compPool = 0;
    for(int i = 0; i < fittnesses.length; i++){
      this.fittnesses[i] = pow((maxExtent-routes[i].getExtent())/1000f, 10);
      compPool += this.fittnesses[i];
    }
    int bestIndex = -1;
    float bestFittness = 0;
    for(int i = 0; i < fittnesses.length; i++){
      this.fittnesses[i] = this.fittnesses[i]/compPool;
      if(fittnesses[i] > bestFittness){
        bestFittness = fittnesses[i];
        bestIndex = i;
      }
    }
    this.bestRoute = routes[bestIndex];
    if(totalBestRoute == null){
      this.totalBestRoute = this.bestRoute;
    }
    
    if(this.bestRoute.getExtent() < this.totalBestRoute.getExtent()){
      this.totalBestRoute = this.bestRoute;
    }
    
  }
  
  public void drawBestRoute(){
    for(int i = 0; i < cities.length -1; i++){
      PVector a = cities[bestRoute.getDNA().getOrder()[i]].getPos();
      PVector b = cities[bestRoute.getDNA().getOrder()[i+1]].getPos();
      stroke(255,100);
      strokeWeight(3);
      line(a.x, a.y, b.x, b.y);
    }
    
    for(int i = 0; i < cities.length -1; i++){
      PVector a = cities[totalBestRoute.getDNA().getOrder()[i]].getPos();
      PVector b = cities[totalBestRoute.getDNA().getOrder()[i+1]].getPos();
      if(i == 0){
        stroke(255,0,0);
        fill(255,0,0);
        ellipse(a.x,a.y, 26,26);
      }else if(i == cities.length-2){
        stroke(255,0,0);
        fill(255,0,0);
        ellipse(b.x,b.y, 25,25); 
      }
      stroke(255,255);
      strokeWeight(3);
      line(a.x, a.y, b.x, b.y);
    }
    
    
  }
  
  private void mateNextGen(){
    for(int i = 0; i < routes.length; i++){
      routes[i] = mating();
    }
    generation++;
  }
  
  
  private Route mating(){
    Route parent = null;
    if(random(1) < 0.05){
      parent = totalBestRoute;
    }else{
      parent = acceptReject();
    }
    
    DNA newDNA = parent.getDNA();
    for(int i = 0; i < cities.length; i++){
      if(random(1) < 0.25){
        DNA mutDNA = newDNA.mutate();
        if(new Route(cities, mutDNA).getExtent() < parent.getExtent()){
          newDNA = mutDNA;
        }
        if(random(1) < 0.25)newDNA = mutDNA;
      }
    }
    
    if(random(1) < 0.1){
      for(int i = 0; i < random(cities.length); i++){
        newDNA = new DNA(newDNA.shift());
      }
    }
    
    return new Route(cities,newDNA);
  }
  
  private Route acceptReject(){
    while(true){
      int pickIndex = floor(random(routes.length));
      if(random(1) < fittnesses[pickIndex]){
        return routes[pickIndex];
      }
    }
  }
  
  public Route getBestRoute(){
    return this.totalBestRoute;
  }
  
  public float getBestExtent(){
   return bestRoute.getExtent();
  }
  public int getGeneration(){
   return generation; 
  }
  
}
