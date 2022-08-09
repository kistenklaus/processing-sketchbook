final float WIND_STRENGHT = 5;
final float LIGHT_SPEED = 5;

Background bg;
Bezugsystem bs;
int aniState;

void setup(){
  size(960, 640);
  bg = new Background();
  bs = new Bezugsystem();
  aniState = 0; 
}

void draw(){
  if(aniState == 1 || aniState == 2 || aniState == 3){
    bg.moveX(-WIND_STRENGHT);
  }
  if(aniState != 5){
    bg.render();
  }else{
   background(150); 
  }
  bs.render();
}

void mouseReleased(){
  aniState++;
  if(aniState > 6)aniState = 0;
  println("animation State = " + aniState);
}

class Bezugsystem{
  final PVector WIND = new PVector(-WIND_STRENGHT,0);
  
  Mirrow mir_top, mir_bottom;
  LightBeam lb;
  ArrayList<PVector> collPoints;
  
  Bezugsystem(){
    this.mir_top = new Mirrow(width/2, height/4, width/8,25);
    this.mir_bottom = new Mirrow(width/2, height/4*3, width/8, 25);
    this.lb = new LightBeam(new PVector(width/2+width/16, height/2));
    this.collPoints = new ArrayList<PVector>();
  }
  
  void render(){
    if(aniState != 5){
      lb.update(mir_top, mir_bottom);
      lb.render();
    }
    if(aniState == 2 || aniState == 3 || aniState == 4 || aniState == 5){
      if(aniState == 2 || aniState ==3){
        for(int i = 0; i < collPoints.size(); i++){
           collPoints.get(i).add(WIND);
        }
      }
      for(int i = 0; i < collPoints.size()-1; i++){
        PVector p1 = collPoints.get(i);
        PVector p2 = collPoints.get(i+1);
        stroke(0,255,0);
        strokeWeight(3);
        line(p1.x,p1.y, p2.x,p2.y);
      }
    }
    
    if(aniState == 4 || aniState == 5){
      float x= lb.getPos().x;
      stroke(255,0,0);
      strokeWeight(3);
      line(x,height/4+25+5,x,height/4*3-5);
    }
    
    if(aniState != 5){
      mir_top.render();
      mir_bottom.render();
    }
  }
  
  class Mirrow{
    
    PVector pos, dim;
    
    Mirrow(int x, int y, int mir_width, int mir_height){
      this.pos = new PVector(x,y);
      this.dim = new PVector(mir_width, mir_height);
      
    }
    void render(){
      fill(100);
      stroke(255);
      strokeWeight(5);
      rect(pos.x,pos.y,dim.x,dim.y);
    }
    
    PVector getPos(){
      return this.pos;
    }
    
    PVector getDim(){
      return this.dim;
    }
  }
  
  class LightBeam{
    
    private final int TRAIL_SUSTAIN = 50;
    
    private PVector pos;
    private PVector vel;
    
    private ArrayList<LightPart> part;
    
    LightBeam(PVector pos){
      this.part = new ArrayList<LightPart>();
      this.pos = pos;
      this.vel = new PVector(0,LIGHT_SPEED);
    }
    
    void update(Mirrow top, Mirrow bottom){
      this.pos.add(this.vel);
      
      if(this.pos.y+10 > bottom.getPos().y || this.pos.y-10 < top.getPos().y + top.getDim().y){
         this.vel.y*=-1;
         
         if(aniState == 2 || aniState == 3){
           collPoints.add(new PVector(pos.x,pos.y));
           if(collPoints.size() > 10){
             collPoints.remove(0);
           }
           if(aniState == 3){
            aniState = 4;
            println("animation State = 4");
            while(collPoints.size() > 2){
             collPoints.remove(0); 
            }
           }
         }
      }

      
      
      PVector wind;
      if(aniState == 1 || aniState == 2 || aniState == 3){
        wind = WIND;
      }else{
        wind = new PVector();
      }
      this.part.add(new LightPart(pos,wind));
      for(int i = 0; i < part.size(); i++){
       if(!part.get(i).update()){
         part.remove(i);
         i--;
       }
      }
      
    }
    
    void render(){
      for(int i = 0; i < part.size(); i++){
        
       LightPart lp = part.get(i);
       
       fill(255,255,0, lp.getTimer()/(float)TRAIL_SUSTAIN * 255);
       ellipse(lp.getPos().x,lp.getPos().y,5,5);
      }
      
      ellipse(this.pos.x, this.pos.y+vel.y, 7,7);
    }
    
    PVector getPos(){
       return this.pos; 
     }
    
    
    class LightPart{
      
      private PVector pos;
      private PVector vel, vel2;
      private int timer;
      
      LightPart(final PVector pos, PVector vel){
        this.timer = TRAIL_SUSTAIN;
        this.pos = new PVector(pos.x,pos.y);
        this.vel = new PVector(vel.x,vel.y);
      }
      
      boolean update(){
        this.pos.add(this.vel);
        timer--;
        if(timer < 0)return false;
        return true;
      }
      
      int getTimer(){
       return this.timer; 
      }
      
      PVector getPos(){
        return this.pos;
      }
      
    }
  }
  
}
