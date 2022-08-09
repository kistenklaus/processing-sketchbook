public class MPara{
  
  private double m;
  private ArrayList<Value> points;
  
  public MPara(ArrayList<Value> points){
    this.points = points;
    this.m =( points.get(points.size()-1).getX()/points.get(points.size()-1).getY() )* random(0.9f,1.1f);
  }
  public MPara(ArrayList<Value> points, double m){
    this.points = points;
    this.m = m;
  }
  
  public float fittness(){
    float dev = 0;
    for(Value p : points){
      dev += Math.pow(p.getY() - m * p.getX()
              ,2);
    }
    return dev;
  }
  
  public double getM(){
    return m;
  }
  
  public MPara crossOver(MPara p2){
    this.m = (this.m + p2.getM())/2d;
    return this;
  }
  
  public void mutate(){
    this.m += random(-0.01, 0.01);
  }
}
