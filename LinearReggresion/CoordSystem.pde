class CoordSystem{
  
  private ArrayList<Value> points;
  private float xScale, yScale;
  private float mValue;
  private float currMValue;
  private int xlen , ylen;
  
  public CoordSystem(int xunits, int yunits){
    this.xlen = xunits;
    this.ylen = yunits;
    this.xScale = (width-25)/xunits;
    this.yScale = (height-25)/yunits;
    this.points = new ArrayList<Value>();
    this.mValue = 0;
  }
  
  public void render(){
    stroke(0);
    strokeWeight(3);
    line(25,height-25,width,height-25);
    line(25,height-25, 25, 0);
    strokeWeight(6);
    for(Value p: points){
      point(25 + p.getX()*xScale, (height-25) - p.getY()*yScale);
    }
    
    
    strokeWeight(3);
    
    stroke(9,255,0,100); 
    //line(25, height-25,
    //        25 + ylen*xScale, (height-25) - ylen*currMValue*yScale);
    stroke(0,0,255);
    line(25, height-25,
            25 + ylen*xScale, (height-25) - ylen*mValue*yScale);
    
    textSize(48);
    fill(0);
    text(mValue, 25, 50);
    
  }
  
  public void add(Value v){
    this.points.add(v);
  }
  
  public ArrayList<Value> getValues(){
    return points;
  }
  
  public void setMValue(float m){
    this.mValue = m;
  }
  
  public void setCurrMValue(float m){
    this.currMValue = m;
  }
  
}
