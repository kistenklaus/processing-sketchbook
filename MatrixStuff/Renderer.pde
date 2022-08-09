class Renderer{
  private Matrix transform;
  private boolean useMatrix;
  Renderer(){
    this.useMatrix=false;
  }
  
  void prepare(){
    background(255);
    translate(width/2, height/2);
    scale(1,-1);
  }
  
  void setMatrix(Matrix transform){
    this.transform = transform;
  }
  
  void enableMatrix(){
     this.useMatrix=true;
  }
  
  void disableMatrix(){
     this.useMatrix=false;
  }
  
  void renderPoint(Point point){
      PVector position = point.getPosition();
      if(this.transform != null && this.useMatrix){
          position = this.transform.transform(new PVector(position.x,position.y,1.0));
      }
      stroke(point.getColor());
      strokeWeight(point.getSize());
      point(position.x, position.y);
  }
  
  void renderLine(Line line){
     stroke(line.getColor());
     strokeWeight(line.getAnkerSize());
     PVector anker = line.getAnker();
     if(this.transform !=null&& this.useMatrix){
        anker = this.transform.transform(new PVector(anker.x, anker.y, 1.0)); 
     }
     point(anker.x, anker.y);
     
     
     
     PVector border_pos = new PVector(anker.x,anker.y);
     while(border_pos.x<width/2&&border_pos.x>-width/2
           && border_pos.y<height/2&&border_pos.y>-height/2){
       border_pos.add(line.getDirection()); 
     }
     PVector border_neg = new PVector(anker.x,anker.y);
     while(border_neg.x<width/2&&border_neg.x>-width/2
           && border_neg.y<height/2&&border_neg.y>-height/2){
       border_neg.sub(line.getDirection()); 
     }
     if(this.transform!=null && this.useMatrix){
        border_pos = this.transform.transform(new PVector(border_pos.x, border_pos.y, 1.0));
        border_neg = this.transform.transform(new PVector(border_neg.x, border_neg.y, 1.0));
     }
     strokeWeight(line.getLineSize());
     line(border_pos.x, border_pos.y, border_neg.x, border_neg.y);
  }
  
}
