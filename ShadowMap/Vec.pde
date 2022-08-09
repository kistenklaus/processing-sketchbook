
static class Vec{
  
  public static PVector sub(PVector v1, PVector v2){
    return new PVector(v1.x, v1.y).sub(v2);
  }
  
  public static PVector from(PVector v1, PVector v2){
    return sub(v2, v1);
  }
  
  public static PVector add(PVector v1, PVector v2){
     return new PVector(v1.x, v1.y).add(v2);
  }
  
  public static PVector mult(PVector v1, float a){
    return new PVector(v1.x, v1.y).mult(a); 
  }
  
}
