
class Light extends Body{
  
  Quad[] quads;
  PVector position;
  
  ArrayList<PVector> verticies = new ArrayList();
  
  Light(Quad[] quads, PVector position){
    this.quads = quads;
    this.position = position;
    constructVerticies();
  }
  
  void constructVerticies(){
    verticies.clear();
    verticies.add(position);
    for(Quad quad : quads){
      for(PVector vertex : quad.getVerticies()){
        boolean blockedVertex = false;
        for(Quad iquad : quads){
            boolean rayIntersectsWithIQuad = false;
            ArrayList<PVector> verticies = iquad.getVerticies();
            for(int i=0;i<verticies.size()-1;i++){
              PVector v1 = verticies.get(i);
              PVector v2 = verticies.get(i+1);
              if(Util.lineIntersect(position, vertex, v1, v2)){
                 rayIntersectsWithIQuad = true;
                 break;
              }
            }
            if(verticies.size()>1 && Util.lineIntersect(position, vertex, verticies.get(0), verticies.get(verticies.size()-1))){
               rayIntersectsWithIQuad = true;
            }
            if(rayIntersectsWithIQuad){
              blockedVertex = true;
              break;
            }
        }
        if(!blockedVertex) {
          Quad blockingQuad = quad;
          while(!isBlockingVertex(vertex, blockingQuad)){
            Quad nextBlockingQuad = null;
            PVector blockingVertex = null;
            float relativeDistanceSq = Float.MAX_VALUE;
            for(Quad i2quad : quads){
              if(!i2quad.equals(quad)){
                PVector blockingVertex_relative = castRayToQuad(vertex, new PVector(vertex.x, vertex.y).sub(position), i2quad);
                if(blockingVertex_relative != null){
                  float magSq = blockingVertex_relative.magSq();
                  if(blockingVertex == null || magSq < relativeDistanceSq){
                    nextBlockingQuad = i2quad;
                    blockingVertex = blockingVertex_relative.add(vertex);
                    relativeDistanceSq = magSq;
                  }
                }
                
              }
            }
            if(blockingVertex == null){
              //borders:
              break;
            }else{
              vertex = blockingVertex; 
              blockingQuad = nextBlockingQuad;
              break;
            }
            //verticies.add(new PVector(vertex.x, vertex.y).add(new PVector(0,5)));
          }
          verticies.add(vertex); 
        }
      }
    }
    //Sort verticies:
    
  }
  
  private boolean isBlockingVertex(PVector vertex, Quad quadOfVertex){
      PVector rayDir = new PVector(vertex.x, vertex.y).sub(position);
      rayDir.mult(100); //bad coding !
      PVector rayDest = new PVector(vertex.x, vertex.y).add(rayDir);
      
      return quadOfVertex.intersectWithRay(vertex, rayDest);
  }
  
  private PVector castRayToQuad(PVector rayStart, PVector rayDir, Quad quad){
    PVector rayEnd = new PVector(rayStart.x, rayStart.y).add(rayDir.mult(100));//Bad Coding
    
    PVector relativeIntersection = null;
    
    float realtiveDistanceSq = Float.MAX_VALUE;
    
    ArrayList<PVector> verticies = quad.getVerticies();
    for(int i=0;i<verticies.size()-1;i++){
      PVector v1 = verticies.get(i);
      PVector v2 = verticies.get(i+1);
      if(Util.lineIntersect(rayStart, rayEnd, v1, v2)){
        PVector intersection = Util.lineIntersectionPoint(rayStart, rayEnd, v1, v2).sub(rayStart);
        if(intersection.magSq() < realtiveDistanceSq){
          relativeIntersection = intersection;
          realtiveDistanceSq = intersection.magSq();
        }
        
      }
    }
    if(verticies.size()>1){
       PVector v1 = verticies.get(0);
       PVector v2 = verticies.get(verticies.size()-1);
       if(Util.lineIntersect(rayStart, rayEnd, v1, v2)){
         PVector intersection = Util.lineIntersectionPoint(rayStart, rayEnd, v1, v2).sub(rayStart);
         if(intersection.magSq() < realtiveDistanceSq){
           relativeIntersection = intersection;
           realtiveDistanceSq = intersection.magSq();
         }
       }
    }
    if(relativeIntersection == null)return null;
    
    return relativeIntersection;
  }
  
  void draw(){
    fill(255, 0, 0);
    for(PVector vertex : verticies){
      line(position.x, position.y, vertex.x, vertex.y);
    }
  }
}
