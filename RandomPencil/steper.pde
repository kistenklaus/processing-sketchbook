class steper extends Thread{
  
  private ArrayList<Pencil> pens;
  private boolean waiting;
  
  public steper(ArrayList<Pencil> pens){
    this.pens = pens;
    new Thread(this).start();
  }
  
  public void run(){
    while(true){
      while(waiting){
        print();
      }
      
      for(Pencil pen : pens){
        pen.step();
      }
      waiting = true;
    }
  }
  
  public void step(){
    this.waiting = false;
  }
  
}
