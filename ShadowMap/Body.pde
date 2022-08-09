
abstract class Body{
  
  
  ArrayList<PVector> verticies = new ArrayList();
  
  public Body(){
    
  }
  
  abstract void constructVerticies();
  
  void draw(){
    beginShape();
    for(PVector vertex : verticies){
       vertex(vertex.x, vertex.y); 
    }
    if(verticies.size()>0)
      vertex(verticies.get(0).x, verticies.get(0).y);
    endShape();
  }
  
  ArrayList<PVector> getVerticies(){
    return verticies;
  }
  
  
  boolean intersectWithRay(PVector start, PVector end){
    
    if(verticies.size()<=1) return false;
    for(int i=0;i<verticies.size()-1;i++){
      PVector v1 = verticies.get(i);
      PVector v2 = verticies.get(i+1);
      boolean intersect = lineIntersect(start, end, v1, v2);
      if(intersect)return true;
    }
    if(lineIntersect(start, end, verticies.get(0), verticies.get(verticies.size()-1)))return true;
    
    return false;
  }
  
  private boolean onSegment(PVector p, PVector q, PVector r){
    if(q.x <= max(p.x, r.x) && q.x >= min(p.x,r.x) &&
       q.y <= max(p.y, r.y) && q.y >= min(p.y,r.y)){
         return true;
       }
    return false;
       
  }
  
  private int orientation(PVector p, PVector q, PVector r){
    float val = (q.y-p.y) * (r.x-q.x) - (q.x-p.x) * (r.y - q.y);
    
    if(val == 0) return 0;
    return (val>0) ? 1 : 2;
  }
  
  boolean lineIntersect(PVector p1, PVector q1, PVector p2, PVector q2){
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
}
