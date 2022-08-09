import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;

class Light extends Body{
  
  Body[] shadowBodies;
  Body[] bodies;
  PVector position;
  
  final float SHADOW_MAP_WIDTH = 1600*2;
  final float SHADOW_MAP_HEIGHT= SHADOW_MAP_WIDTH;
  
  ArrayList<PVector> lightVerticies = new ArrayList();
  
  Light(Body[] bodies, PVector position){
    this.bodies = bodies;
    this.position = position;
    constructVerticies();
  }
  
  void constructVerticies(){
    
    lightVerticies.clear();
    rayCastScene();
    
    //sort lightVerticies:
    Collections.sort(lightVerticies, new Comparator<PVector>(){
      public int compare(PVector o1, PVector o2){
        double a1 = Math.atan2(position.x - o1.x, position.y - o1.y);
        double a2 = Math.atan2(position.x - o2.x, position.y - o2.y);
        return a1>a2 ? -1 : 1;
      }
    });
    
    //SORT VERTICIES:
}
  
  
  void rayCastScene(){
    //Adding the ShadowBorder itself to the shadowMap:
    shadowBodies = new Body[bodies.length+1];
    for(int i=0;i<bodies.length;i++)shadowBodies[i] = bodies[i];
    shadowBodies[bodies.length] = new Quad(position, new PVector(SHADOW_MAP_WIDTH, SHADOW_MAP_HEIGHT));
    
    //process all edges of the shadowBodies
    for(Body body : shadowBodies){
      ArrayList<PVector> bodyVerticies = body.getVerticies();
      int vertexCount = bodyVerticies.size();
      for(int i=0;i<vertexCount;i++){
        int i1 = i, i2 = i+1, i3 = i+2;
        if(i2>=vertexCount)i2-=vertexCount;
        if(i3>=vertexCount)i3-=vertexCount;
        PVector v1 = bodyVerticies.get(i1);
        PVector v2 = bodyVerticies.get(i2);
        PVector v3 = bodyVerticies.get(i3);
        
        //checking if a vertex is blocked by other shadowObjects
        if(!rayBlocked(position, v2, v2, null)){
          //process the edge v1-v2-v3
          //checks if a edge is blocking or the ray can pass throw it.
          PVector v1_to_v2 = Vec.from(v1, v2).normalize();
          PVector v3_to_v2 = Vec.from(v3, v2).normalize();
          double theta = Math.acos(v1_to_v2.dot(v3_to_v2) );
                
          PVector normal = Vec.add(v1_to_v2, v3_to_v2).normalize();
          normal = new PVector(v2.x, v2.y).mult(2).sub(v1).sub(v3).normalize();
          PVector dir = Vec.from(position, v2).mult(-1).normalize();
          double beta = Math.acos(dir.dot(normal));
          
                
          if(beta >= theta/2.0f){
                  
            //new ray from v2 to v2+Vec.from(rayStart, rayEnd)
            //exclude the point v2! -> exclude edges : with v2 
            //take the closest intersection Point:
                    
            PVector rayDir = Vec.mult(dir, -(SHADOW_MAP_WIDTH+SHADOW_MAP_HEIGHT)).add(v2);
                    
            float depth = Float.MAX_VALUE;
            PVector castedRay = null;
                    
            for(Body rbody : shadowBodies){
              ArrayList<PVector> rverticies = rbody.getVerticies();
              for(int k=0;k<rverticies.size();k++){
                int k1 = k, k2 = k+1;
                if(k2>=rverticies.size())k2-=rverticies.size();
                PVector x1 = rverticies.get(k1);
                PVector x2 = rverticies.get(k2);
                  if(!(x1.equals(v2) || x2.equals(v2))){
                    PVector intersectionPoint = Util.lineIntersectionPoint(v2, rayDir, x1, x2);
                    if(intersectionPoint != null){
                      float pointDepth = Vec.from(intersectionPoint, v2).magSq();
                        if(pointDepth < depth){
                          depth = pointDepth;
                          castedRay = intersectionPoint; 
                        }
                      }
                   }
                }
             }
             if(castedRay != null){
               this.lightVerticies.add(v2);
               this.lightVerticies.add(castedRay.add(normal.mult(0.01f)));
             }else{
               println("WHAT");
               this.lightVerticies.add(v2);
             }
           }else{
             this.lightVerticies.add(v2);
           }
        }
      }
    }
    //process all intersection points of the shadowBodies
    for(Body body : shadowBodies){
      ArrayList<PVector> bodyVerticies = body.getVerticies();
      for(int i=0;i<bodyVerticies.size();i++){
        int i1 = i;
        int i2 = i+1;
        if(i2>=bodyVerticies.size())i2-=bodyVerticies.size();
        PVector v1 = bodyVerticies.get(i1);
        PVector v2 = bodyVerticies.get(i2);
        for(Body ibody : shadowBodies){
         if(!body.equals(ibody)){
           ArrayList<PVector> iverticies = ibody.getVerticies();
           for(int j=0;j<iverticies.size();j++){
             int j1=j, j2 = j+1;
             if(j2>=iverticies.size())j2-=iverticies.size();
             PVector w1 = iverticies.get(j1);
             PVector w2 = iverticies.get(j2);
             
             PVector intersection = Util.lineIntersectionPoint(v1, v2, w1, w2);
             if(intersection != null){
               boolean blocked = false;
               for(Body bbody : shadowBodies){
                 ArrayList<PVector> bverticies = bbody.getVerticies();
                 for(int k=0;k<bverticies.size();k++){
                   int k1 = k, k2 = k+1;
                   if(k2>=bverticies.size())k2-=bverticies.size();
                   PVector x1 = bverticies.get(k1);
                   PVector x2 = bverticies.get(k2);
                   if(! (v1.equals(x1)&&v2.equals(x2) || w1.equals(x1)&&w2.equals(x2)  ) ){
                     if(Util.lineIntersect(position, intersection, x1, x2)){
                       blocked = true;
                     }
                   }
                 }
               }
               if(!blocked) {
                 this.lightVerticies.add(intersection); 
               }
             }
           }
         }
        }
      }
    }
  }
  
  boolean rayBlocked(PVector rayStart, PVector rayEnd, PVector ignore1, PVector ignore2){
    boolean blocked = false;
    for(Body ibody : shadowBodies){
      boolean hit = false;
      ArrayList<PVector> iverticies = ibody.getVerticies();
      for(int j=0;j<iverticies.size()&&!hit;j++){
        int j1 = j, j2 = j+1;
        if(j2>=iverticies.size())j2-=iverticies.size();
        PVector w1 = iverticies.get(j1);
        PVector w2 = iverticies.get(j2);
        //if(!(w1.equals(rayEnd) || w2.equals(rayEnd) ) ){ }
        if((ignore2 == null && !(ignore1.equals(w1) || ignore1.equals(w2)))  || 
            (ignore2 != null && !(     (ignore1.equals(w1)&&ignore2.equals(w2)) || (ignore2.equals(w1)&&ignore1.equals(w2))) ) ){
          if(Util.lineIntersect(rayStart, rayEnd, w1, w2)){
            blocked = true;
            hit = true;
            break;  
          }
        }
      }
    }
    return blocked;
  }
  
  public boolean DEBUG = true;
  
  void draw(){
    
    fill(100,10,0);
    beginShape();
    for(int i=0;i<this.lightVerticies.size();i++){
      int i1 = i, i2 = i+1;
      if(i2>=this.lightVerticies.size())i2-=this.lightVerticies.size();
      PVector v1 = this.lightVerticies.get(i1);
      PVector v2 = this.lightVerticies.get(i2);
      vertex(this.position.x, this.position.y);
      vertex(v1.x, v1.y);
      vertex(v2.x, v2.y);
    }
    endShape();
    
    fill(255);
    for(PVector vertex : lightVerticies) {
      ellipse(vertex.x, vertex.y, 10,10);
    }
    
  }
}
