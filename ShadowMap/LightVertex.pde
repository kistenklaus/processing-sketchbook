
class LightVertex{
    PVector position;
    LightVertexType type;
    PVector projectedVertex;
    public int vertexID = 0;
    public boolean spin = false;
    public int toID = 0;
    public int fromID = 0;
    LightVertex(PVector position, LightVertexType type){
      this(position, type, null, null, null);
    }
    LightVertex(PVector position, LightVertexType type, PVector projectedVertex, Body from, Body to){
      this.position = position;
      this.type = type;
      this.projectedVertex = projectedVertex;
      if(from!=null)this.fromID = from.hashCode();
      if(to!=null)this.toID = to.hashCode();
    }
    
    float angle(PVector lightPosition){
      PVector to = Vec.from(lightPosition, position);
      return (float)Math.atan2(to.x, to.y);
    }
  }
  
static enum LightVertexType {
  PROJECTED, INTERSECTION, BLOCKING, NON_BLOCKING;
}
