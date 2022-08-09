class ParticelHandler implements Runnable{
  
  ArrayList<ParticelSystem> partSys;
  private PGraphics canvas;
  
  public ParticelHandler(){
    this.canvas = createGraphics(width, height);
    this.partSys = new ArrayList<ParticelSystem>();
    new Thread(this).start();
  }
  
  public void run(){
    while(canvas == null){}
    while(true){
      canvas.beginDraw();
      canvas.blendMode(ADD);
      canvas.background(0);
      for(int i = 0; i < partSys.size(); i++){
        if(!partSys.get(i).update()){
          partSys.remove(i);
          i--;
        }
        else{
          partSys.get(i).render(canvas);
        }
      }
      canvas.endDraw();
    }
  }
  
  public PGraphics getGraphics(){
    return canvas;
  }
  
  public void add(ParticelSystem partSy){
    partSys.add(partSy);
  }
  
}
