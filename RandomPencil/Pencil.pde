class Pencil {
 
  private int x, y;
  private boolean[][] pixels;
  private color penColor;
  private int count = 0;
  
  public Pencil(color penColor){
    x = floor(random(width));
    y = floor(random(height));
    this.pixels = new boolean[width][height];
    this.penColor = penColor;
  }
  
  public void step(){
     if((count++) > 100){
      this.x = floor(random(width));
      this.y = floor(random(height));
       this.pixels = new boolean[width][height];
     }
     int r = floor(random(4));
     switch(r){
      case 0:
        if(isAvaiable(x+1,y)){
          x++;
          closePixel();
        }else{
          step();
        }
        break;
      case 1:
        if(isAvaiable(x-1,y)){
          x--;
          closePixel();
        }else{
          step();
        }
        break;
      case 2:
        if(isAvaiable(x,y+1)){
          y++;
          closePixel();
        }else{
          step();
        }
        break;
      case 3:
        if(isAvaiable(x,y-1)){
          y--;
          closePixel();
        }else{
          step();
        }
        break;
     }
  }
  
  private boolean isAvaiable(int x_, int y_){
    if(x_ >= pixels.length || x_<0 || y_ >= pixels[0].length || y_ < 0){
      return false;
    }
    return !pixels[x_][y_];
  }
  private void closePixel(){
    this.pixels[this.x][this.y] = true;
    this.count = 0;
  }
  
  public void render(){
   stroke(penColor);
   point(x,y);
  }
  
}
