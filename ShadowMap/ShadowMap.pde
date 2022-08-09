

private Body[] bodies;
private Light light;

void setup(){
  size(1066,800, P2D);

  
  bodies = new Body[]{
     new Circle(new PVector(-125,90), 50),
     new Quad(new PVector(-150, 150), new PVector(50,100)),
     new Quad(new PVector(-100,-200), new PVector(80,50)),
     new Circle(new PVector(100,-30), 100),
     new Quad(new PVector(150,200), new PVector(50,50)),
     new Quad(new PVector(175,225), new PVector(50,50)),
     new Circle(new PVector(200, 100), 25)
  };
  
  light = new Light(bodies, new PVector(0,0));
  
}

void mouseDragged(){
  light.position = new PVector(mouseX - width/2.0f + 0.01, height-mouseY-height/2.0f + 0.01);
  strokeWeight(1);
  //long time = System.nanoTime();
  light.constructVerticies();
  //println(1.0f/((System.nanoTime() - time) * 1e-9));
}

void mouseMoved(){
  light.position = new PVector(mouseX - width/2.0f + 0.01, height-mouseY-height/2.0f + 0.01);
  strokeWeight(1);
  //long time = System.nanoTime();
  light.constructVerticies();
  //println(1.0f/((System.nanoTime() - time) * 1e-9));
}


boolean toggle = true;
void keyPressed(){
   toggle = !toggle;
   light.DEBUG = toggle;
   draw();
}


void draw(){
  
  translate(width/2.0f, height/2.0f);
  scale(1, -1);
  background(0);

  strokeWeight(1);
  stroke(0);
  fill(100);
  for(Body body : bodies){
     body.draw(); 
  }
  
  light.constructVerticies();
  
  
  light.draw();
  
  
  

}
