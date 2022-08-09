public class Population{
  
  private MPara[] m;
  private ArrayList<Value> points;
  private CoordSystem cs;
  private final float MUTATIONRATE = 0.05;
  private double tbestF;
  private MPara tbest;
  private float bestLength;
  
  public Population(ArrayList<Value> points, CoordSystem cs){
    this.points = points;
    this.cs = cs;
    this.m = new MPara[100];
    for(int i = 0; i < m.length; i++){
      m[i] = new MPara(points);
    }
    this.tbestF = 0f;
    this.bestLength = Float.MAX_VALUE;
  }
  
  public void tick() {
    //FITTNESS CALC & MAPPING
    double[] fittnesses = new double[m.length];
    double sum = 0;
    for(int i = 0; i < m.length; i++){
      double fit = m[i].fittness();
      fittnesses[i] = fit;
      sum += fit;
      if(fit<bestLength){
        this.bestLength = (float)fit;
        println("new bestLenght :" + bestLength);
        this.cs.setMValue((float)m[i].getM());
      }
    }
    //MAPPING
    double bestFittness = 0;
    int bestIndex = -1;
    for(int i = 0; i < fittnesses.length; i++){
      double mfit = 1-(fittnesses[i]/sum);
      fittnesses[i] = mfit;
      if(mfit > bestFittness){
        bestFittness = mfit;
        bestIndex = i;
      }
    }
    
    
    this.cs.setCurrMValue((float)m[bestIndex].getM());
    if(bestFittness > tbestF){
      this.tbestF = bestFittness;
      this.cs.setMValue((float)m[bestIndex].getM());
      println("new BestFittness = " + bestFittness);
    }
    
    //GENERATE
    MPara[] nm = new MPara[m.length];
    
    for(int i = 0; i < nm.length; i++){
      MPara p1 = acceptReject(fittnesses);
      MPara p2 = acceptReject(fittnesses);
      
      p1 = p1.crossOver(p2);
      
      if(MUTATIONRATE > random(1)){
        p1.mutate();
      }
      nm[i] = p1;
    }
    m = nm;
    
  }
  
  private MPara acceptReject(double[] fv){
    while(true){
        int t = floor(random(m.length));
        if(random(1f) < fv[t]){
          return m[t];
        }
      }
  }
}
