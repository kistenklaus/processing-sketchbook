

class ParticelSystem{
  
  private PVector pos;
  private float rotangle;
  private float mindis, maxdis;
  private float dis;
  private float offset;
  private float periode;
  private Planet planet;
  private float red, green, blue;
  private float timer;
  
  private ArrayList<Particel> particels;
  
  private PImage fog;
  
  public ParticelSystem(Planet planet, PImage fog, float timer){
    this.planet = planet;
    this.mindis = planet.getSize()/2;
    this.maxdis = planet.getSize();
    this.rotangle = random(TWO_PI);
    this.offset = random(TWO_PI);
    this.periode = random(2);
    
    this.timer = timer;
    
    this.dis = calcDis();
    this.pos = calcPos();
    
    this.fog = fog;
    
    this.red = random(20);
    this.green = random(20);
    this.blue = random(20);
    
    this.particels = new ArrayList<Particel>();
  }
  
  boolean update(){
    this.timer -= 0.0166;
    if(timer < 0){
      return false;
    }
    this.rotangle += 0.1;
    this.dis = calcDis();
    this.pos = calcPos();
    for(int i = 0; i < 50; i++){
      particels.add(new Particel(pos, random(1), red, green, blue, fog));
    }
    for(int i = 0; i < particels.size(); i++){
     if(!particels.get(i).update()){
       particels.remove(i);
       i--;
     }
    }
    return true;
  }
  
  PVector calcPos(){
    PVector ppos = planet.getPos();
    PVector dpos = new PVector();
    dpos.x = dis * cos(rotangle);
    dpos.y = dis * sin(rotangle);
    ppos.add(dpos);
    return ppos;
  }
  
  float calcDis(){
    return (maxdis+mindis)/2 + sin(rotangle*periode+offset) * (maxdis-mindis)/2;
  }
  
  void render(PGraphics canvas){
    for(Particel part: particels){
      part.render(canvas);
    }
  }
  
  void move(PVector newPos){
    this.pos = newPos;
  }
  
  
}
