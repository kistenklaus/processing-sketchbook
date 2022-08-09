final int STAR_COUNT = 500;
final int MAX_STAR_SIZE = 3;
final float MAX_SHIFT = 0.2f;
final int MAX_STARCOLL = 10;

class Background{
  
  private PVector[] apos;
  private int[] sizes;
  private PVector[] shifts;
  
  Background(){
    apos = new PVector[STAR_COUNT];
    sizes = new int[STAR_COUNT];
    shifts = new PVector[STAR_COUNT];
    for(int i = 0; i < STAR_COUNT; i++){
      sizes[i] = 1+floor(random(MAX_STAR_SIZE));
      apos[i] = newStarPos(i);
      shifts[i] = new PVector(1-random(MAX_SHIFT), 1-random(MAX_SHIFT));
    }
  }
  
  PVector newStarPos(int currFill){
    PVector p = new PVector(random(width), random(height));
    if(currFill < 2)return p;
    for(int c = 0; c < 100; c++){
      boolean coll = true;
      for(int i = 0; i < currFill-1; i++){
        PVector opos = apos[i];
        float dis = sqrt(pow(opos.x-p.x,2) + pow(opos.y - p.y,2));
        if(dis > sizes[i]/2 + sizes[currFill]/2 + MAX_STARCOLL){
          coll = false;
          break;
        }
      }
      if(!coll){
        return p;
      }else{
        p = new PVector(random(width), random(height)); 
      }
      
      
    }
    return p;
  }
  
  void moveX(float offX){
    for(int i = 0; i < STAR_COUNT; i++){
      apos[i].x+=offX;
      if(apos[i].x > width + MAX_STAR_SIZE){
        apos[i].x=-MAX_STAR_SIZE;
        apos[i].y = random(height);
      }
      if(apos[i].x < -MAX_STAR_SIZE){
        apos[i].x = width+MAX_STAR_SIZE;
        apos[i].y = random(height);
      }
    }
    
  }
  
  void render(){
    background(0);
    noStroke();
    for(int i = 0; i < STAR_COUNT; i++){
      PVector pos = apos[i];
      PVector shift = shifts[i];
      int size = sizes[i];
      fill(255*shift.y,255 * shift.x * shift.y,255 * shift.x);
      ellipse(pos.x, pos.y, size, size); 
    }
  }
  
  
  
}
