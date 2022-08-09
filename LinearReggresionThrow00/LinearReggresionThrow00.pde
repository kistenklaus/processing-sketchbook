ArrayList<Point> points;
double m;
void setup(){
  size(640,640);
  points = new ArrayList<Point>();
  m = 0;
  repaint();
}
void draw(){}
void repaint(){
  background(255);
  translate(0,height);
  for(Point p : points){
    p.render();
  }
  line(0,0, width, -function(width));
  textSize(32);
  fill(0);
  text("Streigung: " + String.format("%.3f", m), 25, -height+50);
  text("Winkel: " + String.format("%.2f",(float)degrees(atan((float)m/1))), 25, -height+100);
}
float function(double x){
  return (float)(m*x);
}
void mousePressed(){
  points.add(new Point(mouseX, height-mouseY));
  calcM();
  repaint();
}
void calcM(){
  double xmean=0, ymean=0;
  for(Point p: points){
    xmean+=p.x;
    ymean+=p.y;
  }
  xmean/=points.size();
  ymean/=points.size();
  m = ymean/xmean;
}
class Point{
  double x,y;
  Point(double x, double y){
    this.x = x;
    this.y = y;
  }
  void render(){
   strokeWeight(6);
   point((float)x,(float)-y); 
  }
}
