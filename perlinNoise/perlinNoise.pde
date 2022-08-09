PVector[][] Gradient;
void setup(){
   size(300,300);
   Gradient  = createGradient();
   PImage noise = createImage(100,100, RGB);
   int[] pixels = noise.pixels;
   for(int i = 0; i < pixels.length; i++){
      int x = i%noise.width;
      int y = floor(i/noise.height);
      pixels[i] = color((_noise(x*0.1,y*0.1)+1)*0.5*255);
   }
   background(0);
   image(noise, 50, 50,200,200);
}



PVector[][] createGradient(){
  final int dim = 101;
  PVector[][] gradient = new PVector[dim][dim];
  for(int i=0;i<dim;i++){
    for(int j=0;j<dim;j++){
       gradient[i][j] = PVector.random2D();
    }
  }
  return gradient;
}

float _lerp(float a0, float a1, float w){
   return (1.0f-w)*a0 + w*a1; 
}

float _dotGridGradient(int ix, int iy, float x, float y){
    float dx = x-(float)ix;
    float dy = y-(float)iy;
    
    return (dx*Gradient[ix][iy].x + dy*Gradient[ix][iy].y); 
}

float _noise(float x, float y){
  // Determine grid cell coordinates
    int x0 = (int)x;
    int x1 = x0 + 1;
    int y0 = (int)y;
    int y1 = y0 + 1;

    // Determine interpolation weights
    // Could also use higher order polynomial/s-curve here
    float sx = x - (float)x0;
    float sy = y - (float)y0;

    // Interpolate between grid point gradients
    float n0, n1, ix0, ix1, value;

    n0 = _dotGridGradient(x0, y0, x, y);
    n1 = _dotGridGradient(x1, y0, x, y);
    ix0 = _lerp(n0, n1, sx);

    n0 = _dotGridGradient(x0, y1, x, y);
    n1 = _dotGridGradient(x1, y1, x, y);
    ix1 = _lerp(n0, n1, sx);

    value = _lerp(ix0, ix1, sy);
    return value;
}
