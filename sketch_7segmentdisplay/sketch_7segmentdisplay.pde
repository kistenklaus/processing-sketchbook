private int num;
void setup(){
  size(400,400);
   
  num = 0;
  draw();
  frameRate(1);
}

void draw(){
  boolean[] bits = new boolean[8];
  for (int i = 6; i >= 0; i--) {
     bits[i] = (num & (1 << i)) != 0;  
  }
  num++;
  
  
   
  boolean A = bits[3];
  boolean B = bits[2];
  boolean C = bits[1];
  boolean D = bits[0];
  
  boolean a = (B&&D) || (!B&&!D) || A || C;
  boolean b = (C&&D) || !B || (!C&&!D) || A;
  boolean c = B || (!C&&!D) || D;
  boolean d = A || (!B&&!D) || (C&&!D) || (!B&&C) || (B&&!C&&D);
  boolean e = (C&&!D) || (!B&&!D);
  boolean f = (!C&&!D) || (B&&!C) || (B&&!D) || A;
  boolean g = (C&&!D) || (B&&!C) || (!B&&C) || A;
  
  background(0);
  fill(255);
  if(a)rect(20,10,100,10);
  if(b)rect(120,20,10,100);
  if(c)rect(120,130,10,100);
  if(d)rect(20,230,100,10);
  if(e)rect(10,130,10,100);
  if(f)rect(10,20,10,100);
  if(g)rect(20,120,100,10);
}
