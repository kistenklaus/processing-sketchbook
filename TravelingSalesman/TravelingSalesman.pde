private City[] cities;
private Population[] pops;
private Population currPop;
private int popIndex;
private int gengen;
private Graph graph;
private float startExtent;
private Route bestRoute;
private int counter;
private float currExtent;
private boolean newPop;

void setup(){
  size(1690,640);
  this.cities = new City[20];
  for(int i = 0; i < cities.length; i++){
    cities[i] = new City();
  }
  this.pops = new Population[cities.length];
  for(int i = 0; i < pops.length; i++){
    pops[i] = new Population(cities);
  }
  this.popIndex = 0;
  this.currPop = pops[popIndex];
  this.graph = new Graph();
  this.update();
  this.startExtent = currPop.getBestExtent();
  
  this.counter = 0;
  this.gengen = 0;
}

void update(){
  currPop.mapFittness();
  currPop.drawBestRoute();
  currPop.mateNextGen();
  
}

void draw(){

  
  background(100);
  
  this.counter++;
  if(this.counter > 1){
    this.currExtent = currPop.getBestExtent();
    this.graph.addValue(currExtent/startExtent*(height*3) - height/5);
    this.counter = 0;
  }
  
  this.graph.render();
  
  if(newPop){
    this.currPop = new Population(cities);
    this.graph.reset();
    this.newPop = false; 
  }
  if(this.currPop.getGeneration() >= cities.length*5){
    
    if(bestRoute==null)bestRoute =currPop.getBestRoute();
    if(bestRoute.getExtent() > currPop.getBestRoute().getExtent()){
      this.bestRoute = currPop.getBestRoute();
    }
    popIndex++;
    if(popIndex > pops.length-1){
      gengen++;
      for(int i = 0; i < pops.length; i++){
        pops[i] = new Population(cities, bestRoute);
      }
      this.popIndex = 0;
    }
    currPop = pops[popIndex];
    //this.graph.reset();
  }
  
  this.update();
  
  for(int i = 0; i < cities.length; i++){
    cities[i].render();
  }
  fill(0,100);
  rect(0,0,300,70);
  fill(255);
  textSize(24);
  text("Score: " + 1/graph.getBestValue()*10000, 10, 30);
  text("Generation: " + (gengen+1) + ":" + (popIndex+1) + ":" + currPop.getGeneration(), 10, 60);
}

void mouseClicked() {
  this.newPop = true;
}
