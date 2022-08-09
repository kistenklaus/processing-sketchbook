//USELESS FIELDS
final int A_SIZE = 35;
final int B_SIZE = 20;
final int BULLET_SIZE = 7 ;

//USEFULLFIELDS
final float A_movSpeed = 10f;
final float B_vel = 2f;
final float Bullet_vel = 2.5f;
final ArrayList<Entity> bullets = new ArrayList<Entity>();
Entity A, B;
void setup(){
  size(960,640,P2D);
  //size(640,640,P2D);
  this.A = new Entity(new PVector(width/2, height/2), A_SIZE);
  this.B = new Entity(new PVector(width/2, height/2), B_SIZE);
  this.B.applyForce(PVector.random2D().mult(B_vel));
}
void draw(){
  //updating
      //Bullet-updates
  for(int i = 0; i < bullets.size(); i++){
    Entity bullet = this.bullets.get(i);
    bullet.update();
    if(bullet.getX() > width || bullet.getX() < 0){
      bullet.getVel().x *= -1;
    }if(bullet.getY() > height || bullet.getY() < 0){
      bullet.getVel().y *= -1;
    }
    float d = bullet.coppyPos().sub(B.coppyPos()).mag();
    if(d<B_SIZE/2){
      this.bullets.remove(i);
      i--;
    }
  }
      //B-updates
  this.B.update();
  if(B.getX() > width || B.getX() < 0){
    B.getVel().x *= -1;
  }if(B.getY() > height || B.getY() < 0){
    B.getVel().y *= -1;
  }
      //A-updates
  A.applyForce(PVector.random2D());
  //A.applyForce(A.coppyPos().sub(B.coppyPos()).setMag(0.05));
  A.getVel().limit(A_movSpeed);
  A.update();
  if(A.getX() > width/8*7 || A.getX() < width/8){
   A.getVel().x *= -1; 
  }if(A.getY() > height/8*7 || A.getY() < height/8){
   A.getVel().y *= -1; 
  }
  if(random(1f) > 0.8f)shot();
  //rendering                      RENDERING:
  smooth();
  background(150);
  fill(255,255,0);
  for(int i = 0; i < bullets.size(); i++){
    Entity bullet = this.bullets.get(i);
    stroke(200);
    strokeWeight(3);
    line(bullet.getX(), bullet.getY(), A.getX(), A.getY());
    stroke(255,255,0);
    line(bullet.getX(), bullet.getY(), bullet.getX() + bullet.getVel().x * 10, bullet.getY() + bullet.getVel().y * 10);
    stroke(255);
    line(bullet.getX(), bullet.getY(), B.getX(), B.getY());
    strokeWeight(2);
    bullet.draw();
  }
  stroke(0,255,0);
  line(A.getX(), A.getY(), B.getX(), B.getY());
  stroke(0,0,255);
  line(A.getX(), A.getY(), A.getX() + A.coppyVel().x *100, A.getY() + A.coppyVel().y*100);
  stroke(255);
  fill(0,0,255);
  this.A.draw();
  stroke(255,0,0);
  line(B.getX(), B.getY(), B.getX() + B.coppyVel().x *100, B.getY() + B.coppyVel().y*100);
  stroke(255);
  fill(255,0,0);
  this.B.draw();
}
void shot(){
  Entity bullet = new Entity(A.coppyPos(), BULLET_SIZE);
  bullet.applyForce(calcBulletVector());
  bullets.add(bullet);
}
PVector calcBulletVector(){
  //Umgebungsvariablen:
  final PVector A = this.A.coppyPos();
  final PVector B = this.B.coppyPos();
  final float A_vel = this.Bullet_vel;
  final PVector Vec_B_vel = this.B.coppyVel();
  final float B_vel = Vec_B_vel.mag();
  //Subsitutionsvariablen:
  PVector BA = A.sub(B);
  final float c = BA.mag();
  //final float beta_inv = BA.dot(Vec_B_vel)/ (c*B_vel);    //OPTIMISATION NEEDED FOR INVERS FUNKTION : acos(cos(fx)) = fx
  //Calculate (t)
  float s1 = BA.dot(Vec_B_vel);
  float root = sqrt(pow(BA.dot(Vec_B_vel)/c,2) -B_vel*B_vel + A_vel*A_vel);
  float numerator = s1 - c*root;
  float denominator = B_vel*B_vel - A_vel*A_vel;
  float t = numerator/denominator;
  PVector vec_b = BA.mult(-1).add(Vec_B_vel.mult(t));
  vec_b.setMag(Bullet_vel);
  return vec_b;
}
void keyPressed(){
  B.getVel().mult(0);
  B.applyForce(PVector.random2D().mult(B_vel));
  if(key == ' '){
    bullets.clear();
  }
}
class Entity{
  private PVector pos, vel;
  private float size;
  Entity(PVector pos, float size){
    this.pos = pos;
    this.vel = new PVector();
    this.size = size;
  }
  void applyForce(PVector force){
    this.vel.add(force);
  }
  void applyMovement(PVector movement){
    this.pos.add(movement);
  }
  void update(){
    this.pos.add(vel);
  }
  void draw(){
    ellipse(pos.x,pos.y,size,size);
  }
  float getX(){return pos.x;}
  float getY(){return pos.y;}
  PVector getVel(){return vel;}
  PVector coppyVel(){return new PVector(vel.x, vel.y);}
  void setVel(PVector vel){this.vel = vel;}
  PVector coppyPos(){return new PVector(pos.x, pos.y);}
}
