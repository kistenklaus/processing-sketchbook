
ArrayList<Point> points;

private double m,b;

void setup(){
  size(640,640);
  points = new ArrayList<Point>();
  repaint();
}

void repaint(){
  background(255);
  for(Point p : points){
    p.render();
  }
  println(Reg(10));
  line(0,Reg(0), width, Reg(width));
}

void draw(){
  
}

void mousePressed(){
  points.add(new Point(mouseX,mouseY));
  calcRegression();
  repaint();
 
}

float Reg(float x){
  return (float)m*x + (float)b;
}

void calcRegression() {
  double X = 0;
  double Y = 0;
  for(Point p : points){
    X += p.x;
    Y += p.y;
  }
  X/=points.size();
  Y/=points.size();
  
  double num = 0;
  double den = 0;
  for(Point p : points){
    num += (p.x - X) * (p.y - Y);
    den += (p.x - X) * (p.x - X);
  }
  m = num/den;
  b = Y - m * X;
}


class Point{
 
  float x,y;
  
  Point(float x, float y){
    this.x = x;
    this.y = y;
    
  }
  
  void render(){
    stroke(0);
    strokeWeight(6);
    point(x,y);
  }
  
}
