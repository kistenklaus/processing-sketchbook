class Point{
  
  private PVector position;
  private color pointColor;
  private float size;
  private static final float POINT_SIZE = 10f;
  
  Point(PVector position, color pointColor){
    this.position = position;
    this.pointColor=pointColor;
    this.size = POINT_SIZE;
  }
  
  color getColor(){
    return this.pointColor;    
  }
  
  PVector getPosition(){
    return this.position; 
  }
  float getX(){
    return this.position.x; 
  }
  float getY(){
     return this.position.y; 
  }
  float getSize(){
      return this.size;
  }
}
