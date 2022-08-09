

private Renderer renderer;
private Point point;
private Line line;

void setup(){
  size(640,640);
  this.renderer = new Renderer();
  this.point = new Point(new PVector(0,20), color(255,0,0));
  this.line = new Line(new PVector(0,0), new PVector(-10,-20), color(0,100,200));
  
  PVector dir = this.line.getDirection().normalize();
  PVector nor = new PVector(-dir.y/dir.x,1.0).normalize();
  
  println(dir);
  println(nor);
  
  
  Matrix transform = new Matrix(dir.x,dir.y,0,
                                nor.x,nor.y,0,
                                0,0,1);
  this.renderer.setMatrix(transform);                      
                                     
}

void mousePressed(){
  this.renderer.enableMatrix();
}
void mouseReleased(){
  this.renderer.disableMatrix(); 
}


void draw(){
  this.renderer.prepare();
  this.renderer.renderPoint(this.point);
  this.renderer.renderLine(this.line);
}
