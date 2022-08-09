
PGraphics buffer1;
PGraphics buffer2;
PImage cooling;
float ystart = 0.0;
int w, h;
void setup(){
  size(640, 960);
  w = width; h = height;
  buffer1 = createGraphics(w,h);
  buffer2 = createGraphics(w,h);
  cooling = createImage(w,h,RGB);
  fire(1);
}

void cool(){
  cooling.loadPixels();
  float xoff = 0.0;
  float increment = 0.1;
  for(int x = 0; x <w; x++){
   xoff += increment;
   float yoff = ystart;
   for(int y = 0;  y <h; y++){
    yoff+=increment;
    float bright = noise(xoff,yoff) * 5;
    cooling.pixels[x+y*w] = color(bright);
   }
  }
  cooling.updatePixels();
  ystart+=increment;
}

void fire(int size){
  buffer1.beginDraw();
  buffer1.noStroke();
  buffer1.ellipse(w/2,h/3*2, w/4, w/4);
  
  buffer1.endDraw();
}

void tick(){
  fire(100);
  cool();
  buffer2.beginDraw();
  buffer1.loadPixels();
  buffer2.loadPixels();
  for(int x = 1; x < w-1; x++){
   for(int y = 1; y < h-1; y++){
     float b = (
             brightness(buffer1.pixels[x+1+y*w])+
             brightness(buffer1.pixels[x-1+y*w])+
             brightness(buffer1.pixels[x+(y+1)*w])+
             brightness(buffer1.pixels[x+(y-1)*w]))/4 -
             brightness(cooling.pixels[x+y*w]);
     b = 255-b;
     buffer2.pixels[x+(y-1)*w] = color(255-b, 255-b*2,255-b*3);
   }
  }
  buffer2.updatePixels();
  buffer2.endDraw();
  PGraphics temp = buffer1;
  buffer1 = buffer2;
  buffer2 = temp;
}

void draw(){
  tick();
  scale(width/w);
  background(0);
  image(buffer2,0,0);
}
