class Matrix{
  private float m00,m01,m02,m10,m11,m12,m20,m21,m22;
  Matrix(float m00, float m01, float m02,
         float m10, float m11, float m12,
         float m20, float m21, float m22){
    this.m00=m00;
    this.m01=m01;
    this.m02=m02;
    this.m10=m10;
    this.m11=m11;
    this.m12=m12;
    this.m20=m20;
    this.m21=m21;
    this.m22=m22;
  }
  
  
  PVector transform(PVector vector){
    return new PVector(
      m00*vector.x + m01*vector.y + m02*vector.z,
      m10*vector.x + m11*vector.y + m12*vector.z,
      m20*vector.x + m21*vector.y + m22*vector.z
    );
  }
}
