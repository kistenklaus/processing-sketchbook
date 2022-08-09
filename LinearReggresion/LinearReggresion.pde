private CoordSystem cs;
private Population pop;

void setup(){
  
  size(640,640);
  this.cs = new CoordSystem(10,10);
  this.cs.add(new Value(1,1 + random(2)-1));
  this.cs.add(new Value(2,2 + random(2)-1));
  this.cs.add(new Value(3,3 + random(2)-1));
  this.cs.add(new Value(4,4 + random(2)-1));
  this.cs.add(new Value(5,5 + random(2)-1));
  this.cs.add(new Value(6,6 + random(2)-1));
  this.cs.add(new Value(7,7 + random(2)-1));
  this.cs.add(new Value(8,8 + random(2)-1));
  
  this.pop = new Population(this.cs.getValues(), cs);
}

void tick() {
  this.pop.tick();
}

void draw(){
  this.tick();
  background(255);
  cs.render();
  
  
}
