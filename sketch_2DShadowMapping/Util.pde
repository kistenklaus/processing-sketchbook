static class Util{
   private static boolean onSegment(PVector p, PVector q, PVector r){
    if(q.x <= max(p.x, r.x) && q.x >= min(p.x,r.x) &&
       q.y <= max(p.y, r.y) && q.y >= min(p.y,r.y)){
         return true;
       }
    return false;
       
  }
  
  private static int orientation(PVector p, PVector q, PVector r){
    float val = (q.y-p.y) * (r.x-q.x) - (q.x-p.x) * (r.y - q.y);
    
    if(val == 0) return 0;
    return (val>0) ? 1 : 2;
  }
  
  public static boolean lineIntersect(PVector p1, PVector q1, PVector p2, PVector q2){
    if((p1.x==p2.x&&p1.y==p2.y) || (p1.x==q2.x&&p1.y==q2.y)
        || (q1.x==p2.x&&q1.y==p2.y) || (q1.x==q2.x&&q1.y==q2.y)){
           return false; 
        }
    
    int o1 = orientation(p1, q1, p2);
    int o2 = orientation(p1, q1, q2);
    int o3 = orientation(p2, q2, p1);
    int o4 = orientation(p2, q2, q1);
    
    if(o1 != o2 && o3 != o4)return true;
    if(o1 == 0 && onSegment(p1, p2, q1)) return true;
    if(o2 == 0 && onSegment(p1, q2, q1)) return true;
    if(o3 == 0 && onSegment(p2, p1, q2)) return true;
    if(o4 == 0 && onSegment(p2, q1, q2)) return true;
    
    return false;
  }
  
  public static PVector lineIntersectionPoint(PVector A, PVector B, PVector C, PVector D){
    float a1 = B.y - A.y;
    float b1 = A.x - B.x;
    float c1 = a1 * A.x + b1 * A.y;
    
    float a2 = D.y - C.y;
    float b2 = C.x - D.x;
    float c2 = a2 * C.x + b2 * C.y;
    
    float det = a1*b2 - a2*b1;
    if(det == 0){
       return null;
    }else{
      float x = (b2*c1-b1*c2)/det;
      float y = (a1*c2-a2*c1)/det;
      return new PVector(x,y);
    }
    
  }
  
}
