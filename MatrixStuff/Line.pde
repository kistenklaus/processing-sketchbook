class Line{
  private PVector anker;
  private PVector direction;
  private color lineColor;
  
  private float line_stroke;
  private float anker_stroke;
  
  private static final float LINE_STROKE = 5;
  private static final float ANKER_STROKE =8;
  
  Line(PVector anker, PVector direction, color lineColor){
    this.anker = anker;
    this.direction = direction;
    this.lineColor = lineColor;
    
    this.line_stroke = LINE_STROKE;
    this.anker_stroke = ANKER_STROKE;
  }
  
  PVector getAnker(){
    return this.anker; 
  }
  PVector getDirection(){
    return this.direction;
  }
  color getColor(){
    return this.lineColor; 
  }
  float getLineSize(){
    return this.line_stroke;
  }
  float getAnkerSize(){
    return this.anker_stroke; 
  }
  
  
}
