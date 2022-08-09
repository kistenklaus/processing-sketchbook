
PVector pos, vel;
float acc;

PVector pos_p1, vel_p1, acc_p1;
float width_p1, height_p1;
boolean p1up, p1down;

void setup(){
  size(960, 540);
  this.pos = new PVector(0,0);
  this.vel = new PVector(5,random(1,10));
  this.pos_p1 = new PVector(-width/2 + 10, 0);
  this.vel_p1 = new PVector();
  this.acc = 0.0005;
  this.width_p1 = 20;
  this.height_p1 = 100;
}

void keyPressed(){
  if((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
    if(key == 'w' || key == 'W'){
      p1up = true;
    }
    if(key == 's' || key == 'S'){
     p1down = true; 
    }
  }
}

void keyReleased(){
   if((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
    if(key == 'w' || key == 'W'){
      p1up = false;
    }
    if(key == 's' || key == 'S'){
     p1down = false; 
    }
   }
}


void update(){
  if(p1up){
    acc_p1 = new PVector(0,-0.5);
  }
  else if(p1down){
    acc_p1 = new PVector(0,0.5);
  }else{
    acc_p1 = new PVector();
    vel_p1.mult(0.8);
  }
  
  vel_p1.add(acc_p1);
  
  if((pos_p1.y > height/2-height_p1-12 && p1down) || (pos_p1.y < -height/2+12 && p1up)){
    vel_p1 = new PVector();
    acc_p1 = new PVector();
  }
  
  pos_p1.add(vel_p1);
  
  
  if(pos.y>height/2-12 || pos.y<-height/2+12){
    vel.y *= -1;
  }
  
  if(pos.x>width/2-12){
     vel.x *= -1;
  }
  
  if((pos.x<-width/2+50) && (pos.y>pos_p1.y && pos.y<pos_p1.y+height_p1) ){
    vel.x *= -1;
    vel.add(vel_p1.mult(0.1));
  }
  if(pos.x<-width/2+12){
    pos = new PVector(0,0);
    this.vel = new PVector(5,random(1,10));
    this.acc = 0.0005;
  }
  
  vel.mult(1+acc);
  vel.limit(35);
  pos.add(vel);
  
}

void draw(){
  update();
  
  background(0);
  translate(width/2, height/2);
  
  //smooth();
  fill(255);
  ellipse(pos.x,pos.y,25,25);
  fill(255);
  rect(pos_p1.x, pos_p1.y, width_p1, height_p1);
  
}
