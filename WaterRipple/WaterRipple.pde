
int cols;
int rows;
float[][] curr;
float[][] prev;
int nticks = 0;
int spawn = 10;

float damping = 0.95;

void setup(){
  size(640, 640);
  this.cols = width;
  this.rows = width;
  this.curr = new float[cols][rows];
  this.prev = new float[cols][rows];
}

void mousePressed(){
  prev[mouseX][mouseY] = 255;
}

void draw(){
  nticks++;
  if(nticks > spawn){
     //this.prev[floor(random(width))][floor(random(height))] = 255;
     nticks -= random(spawn);
  }
 
  background(0);
  loadPixels();
  for(int i = 1; i < cols-1; i++){
    for(int j = 1; j < rows-1; j++){
      curr[i][j] = (
          prev[i-1][j] + 
          prev[i+1][j] +
          prev[i][j-1] + 
          prev[i][j+1]) / 2 -
          curr[i][j];
      curr[i][j]*=damping;
      int index = i + j * cols;
      pixels[index] = color(curr[i][j]*255);
    }
  }
  updatePixels();
  
  float[][] temp = prev.clone();
  prev = curr;
  curr = temp;

  
}
