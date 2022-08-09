private ArrayList<Population> pops;
private int count;
private PVector destiny;
private int generation;

void setup(){
  //size(1920,1080);
  fullScreen();
  this.generation = 0;
  this.destiny = new PVector(width/2, height/2);
  pops = new ArrayList<Population>();
  for(int i = 0; i < 10 ; i++){
    pops.add(new Population(color(random(255),random(255),random(255),100)));
  }
  this.count = 0;
}

void draw(){
  background(0);
  if(count>=200){
    this.count = 0;
    float badest = 1;
    int b_i = 0;
    for(int i = 0; i < pops.size(); i++){
      Population p = pops.get(i);
      if(p.evaluate() < badest){
       badest = p.evaluate();
       b_i = i;
      }
    }
    this.generation++;
    println("Geration:" + generation);
    if(pops.size() > 1){
    println("removed pop:" + red(pops.get(b_i).getColor()) + "|" + green(pops.get(b_i).getColor()) + "|" + blue(pops.get(b_i).getColor()) + " " + pops.size() + "-: left");
      pops.remove(b_i);
    }
    for(Population p :pops){
      p.nextGeneration();
    }
  }
  
  for(Population p :pops){
    p.run(this.count);
    
  }
  this.count++;
}

class Population {
  
  private color c;
  private float best;
  
  Rocket[] rockets;
  
  Population(color c){
    this.c =c;
    this.rockets = populate(100);
  }
  
  Rocket[] populate(int size){
   Rocket[] out = new Rocket[size];
   for(int i = 0; i < size; i++){
     out[i] = new Rocket(new DNA(), c);
   }
   return out;
  }
  
  void nextGeneration(){
    //find best:
      float best = 0;
      int best_index = 0;
      for(int i = 0; i < rockets.length ; i++){
        float v;
        if(best < (v=rockets[i].validate(destiny))){
          best = v;
          best_index = i;
        }
      }//find sec best
      this.best = best;
      best = 0;
      int sec_index = 0;
      for(int i = 0; i < rockets.length ; i++){
        if(i == best_index)continue;
        float v;
        if(best < (v=rockets[i].validate(destiny))){
          best = v;
          sec_index = i;
        }
      }
      DNA eltern1 = rockets[best_index].getDNA();
      DNA eltern2 = rockets[sec_index].getDNA();
      for(int i = 0; i < rockets.length; i++){
        rockets[i] = new Rocket(eltern1.crossingOver(eltern2), c);
     }
  }
  
  float evaluate(){
    return this.best;
  }
  
  void run(int count){
    for(Rocket r : rockets){
     r.update(count);
     r.render();
    }
    fill(255,0,0,255);
    ellipse(destiny.x,destiny.y, 20,20);
  }
  
  color getColor(){
    return c;
  }
  
}
