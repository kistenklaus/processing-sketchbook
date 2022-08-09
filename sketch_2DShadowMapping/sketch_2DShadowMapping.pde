

private Quad[] quads;
private Light light;

void setup(){
 size(800,600);

  
  quads = new Quad[]{
     new Quad(new PVector(125,90), new PVector(50,50)),
     new Quad(new PVector(200, 200), new PVector(50,50)),
     new Quad(new PVector(-100,-200), new PVector(50,50))
  };
  
    light = new Light(quads, new PVector(0,0));
  
}

void mouseMoved(){
  quads[0].position = new PVector(mouseX - width/2.0f, height-mouseY-height/2.0f);
  quads[0].constructVerticies();
  light.constructVerticies();
}


void draw(){
   
  translate(width/2.0f, height/2.0f);
  scale(1, -1);
  background(255);
  for(Quad quad : quads){
     quad.draw(); 
  }
  
  light.draw();
}
