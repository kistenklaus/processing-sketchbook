Planet planet;
ParticelHandler partHandler;
PGraphics partCanvas;
private boolean init;

void setup(){
  size(720,720,P2D);
  PImage fog = loadImage("Fog.png");
  this.partHandler = new ParticelHandler();
  this.planet = new Planet(new PVector(width/2, height/2), 100, color(50,25,50,10),
                          partHandler, fog);
  while(partCanvas == null){
     this.partCanvas = partHandler.getGraphics();
  }
  this.init = true;
}

void update(){
  planet.update();
}

void draw(){
  if(!init)return;
  update();
  smooth();  
  background(0);
  tint(255,255);
  image(partCanvas, 0,0);
  planet.render();
}
