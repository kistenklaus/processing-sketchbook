static final float SCALE = 20;
ArrayList<Pencil> pens;

steper steper;

void setup(){
  size(640,640,P2D);
  this.pens = new ArrayList<Pencil>();
  for(int i = 0; i < 1000; i++){
    this.pens.add(new Pencil(color(random(255),random(255),random(255))));
  }
  this.steper = new steper(pens);
  background(0);
  
}


void draw() {
  translate(width/2, height/2);
  scale(SCALE);
  translate(-width/2, -height/2);
  for(Pencil pen: pens){   
   pen.render();
  }
  steper.step();
}
