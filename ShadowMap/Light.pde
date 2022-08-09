import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;

class Light extends Body{
  
  Body[] shadowBodies;
  Body[] bodies;
  PVector position;
  
  final float SHADOW_MAP_WIDTH = 1600*2;
  final float SHADOW_MAP_HEIGHT= SHADOW_MAP_WIDTH;
  
  ArrayList<LightVertex> lightVerticies = new ArrayList();
  
  Light(Body[] bodies, PVector position){
    this.bodies = bodies;
    this.position = position;
    constructVerticies();
  }
  
  void constructVerticies(){
    
    lightVerticies.clear();
    rayCastScene();
    
    //sort lightVerticies:
    Collections.sort(lightVerticies, new Comparator<LightVertex>(){
      public int compare(LightVertex o1, LightVertex o2){
        float a1 = o1.angle(position);
        float a2 = o2.angle(position);
        return a1>a2 ? -1 : 1;
      }
    });
    //check that fist index is not a ProjectedVertex:
    int c = lightVerticies.size();
    while(lightVerticies.get(0).type == LightVertexType.PROJECTED || lightVerticies.get(0).type == LightVertexType.INTERSECTION){
        LightVertex temp = lightVerticies.remove(0);
        lightVerticies.add(temp);
        if(c--<=0)break;
    }
    
    
    HashMap<Integer, Boolean> shadowStack = new HashMap();
    
    //Determine Spin:
    
    
    for(int i=0;i<lightVerticies.size();i++){
      LightVertex vertex = lightVerticies.get(i);
      if(vertex.type == LightVertexType.PROJECTED){
        int stackID = vertex.fromID;
        
        Boolean stackValue = shadowStack.get(stackID);
        if(stackValue==null){
          stackValue = false;
        }
        if(!stackValue){
          vertex.spin = true;
        }else{
          vertex.spin = false;
        }
        stackValue = !stackValue;
        shadowStack.put(stackID, stackValue);
        
        
        stackID = vertex.toID;
        stackValue = shadowStack.get(stackID);
        if(stackValue==null)stackValue = false;
        stackValue = !stackValue;
        shadowStack.put(stackID, stackValue);
        
      }else if(vertex.type == LightVertexType.INTERSECTION){
        Boolean fromValue = shadowStack.get(vertex.fromID);
        if(fromValue == null)fromValue = true;
        shadowStack.put(vertex.fromID, !fromValue);
        Boolean toValue = shadowStack.get(vertex.toID);
        if(toValue == null)toValue = true;
        shadowStack.put(vertex.toID, !toValue);
      }else if(vertex.type == LightVertexType.BLOCKING){
        shadowStack.put(vertex.fromID, true);
      }
    }
    
    
    
    
    HashSet<PVector> set = new HashSet();
    
    verticies.clear();
    for(int i=0;i<lightVerticies.size();i++){
      LightVertex vertex = lightVerticies.get(i);
      vertex.vertexID = i;
      if(vertex.type == LightVertexType.PROJECTED){
        if(!vertex.spin){
          verticies.add(vertex.position);
          verticies.add(vertex.projectedVertex);
        }else{
          verticies.add(vertex.projectedVertex);
          verticies.add(vertex.position);
        }
        set.add(vertex.projectedVertex);
        
      }else if(!set.contains(vertex.position)){
        verticies.add(vertex.position); 
      }
      set.add(vertex.position);
    }
    
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
          double theta = Math.acos(v1_to_v2.dot(v3_to_v2) / (v1_to_v2.mag() * v3_to_v2.mag()));
                
          PVector normal = Vec.add(v1_to_v2, v3_to_v2).normalize();
          PVector dir = Vec.from(position, v2).mult(-1).normalize();
          double beta = Math.acos(dir.dot(normal) / (normal.mag() * dir.mag()));
          
                
          if(beta >= theta/2.0f){
                  
            //new ray from v2 to v2+Vec.from(rayStart, rayEnd)
            //exclude the point v2! -> exclude edges : with v2 
            //take the closest intersection Point:
                    
            PVector rayDir = Vec.mult(dir, -(SHADOW_MAP_WIDTH+SHADOW_MAP_HEIGHT)).add(v2);//Bad Coding
                    
            float depth = Float.MAX_VALUE;
            PVector castedRay = null;
            Body rayHit = null;
                    
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
                          rayHit = rbody;
                          castedRay = intersectionPoint; 
                        }
                      }
                   }
                }
             }
             if(castedRay != null)
               this.lightVerticies.add(new LightVertex(v2, LightVertexType.PROJECTED, castedRay, body, rayHit));
             else{
               this.lightVerticies.add(new LightVertex(v2, LightVertexType.BLOCKING, null, body, null));
             }
               //this.lightVerticies.add(new LightVertex(v2, LightVertexType.PROJECTED, castedRay, body, rayHit));
           }else{
             this.lightVerticies.add(new LightVertex(v2, LightVertexType.BLOCKING, null, body, null));
           }
           if(DEBUG){
             scale(1,-1);
             text(""+Math.round(Math.toDegrees(beta)*100)/100.0f, v2.x+5, -v2.y-5);
             scale(1,-1);
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
                 this.lightVerticies.add(new LightVertex(intersection, LightVertexType.INTERSECTION, null, body, ibody)); 
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
    for(int i=0;i<this.verticies.size();i++){
      int i1 = i, i2 = i+1;
      if(i2>=this.verticies.size())i2-=this.verticies.size();
      PVector v1 = this.verticies.get(i1);
      PVector v2 = this.verticies.get(i2);
      vertex(this.position.x, this.position.y);
      vertex(v1.x, v1.y);
      vertex(v2.x, v2.y);
    }
    endShape();
    
    if(DEBUG){
      fill(255, 0, 0);
      stroke(0);
      strokeWeight(0);
      for(int i=0;i<lightVerticies.size();i++){
        strokeWeight(0);
        LightVertex v = lightVerticies.get(i);
        
        if(v.type == LightVertexType.PROJECTED){
          fill(0,255,255);
          ellipse(v.projectedVertex.x, v.projectedVertex.y, 15, 15);
          line(v.projectedVertex.x, v.projectedVertex.y, this.position.x, this.position.y);
          
          fill(0);
          textSize(10);
          scale(1, -1);
          //text(v.fromID, v.projectedVertex.x-4, -(v.projectedVertex.y-3));
          scale(1, -1);
        }
        switch(v.type){
         case INTERSECTION:
         fill(0,100,200);
         break;
         case PROJECTED:
         fill(255,255,0);
         break;
         case NON_BLOCKING:
         fill(255,255,0);
         break;
         case BLOCKING:
         fill(255,0,0);
         break;
        }
  
        ellipse(v.position.x, v.position.y, 15, 15);
        line(v.position.x, v.position.y, this.position.x, this.position.y);
        
        fill(0);
        textSize(10);
        scale(1, -1);
        text(v.vertexID, v.position.x-4, -(v.position.y-3));
        scale(1, -1);
      }
      strokeWeight(1);
    }
    
    
  }
}
