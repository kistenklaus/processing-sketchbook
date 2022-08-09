  public class DNA {
    
    PVector[] genes;
    
    public DNA(){
      this.genes = new PVector[200];
      for(int i = 0; i < 200; i++){
        float adir = random(2*PI);
        float s = random(10);
        PVector dir = new PVector(
        s * cos(adir),
        s * sin(adir)
        );
        genes[i] = dir;
      }
    }
    
    private DNA(int i){
       this.genes = new PVector[200];
    }
    
    public PVector getGene(int pos){
      return genes[pos];
    }
    public void setGene(int pos, PVector gen){
      this.genes[pos] = gen;
    }
    
    public DNA crossingOver(DNA eltern2){
      DNA child = new DNA(0);
      for(int i = 0; i < genes.length; i++){
        boolean e1 = random(1) > 0.5;
        if(e1){
          child.setGene(i, this.getGene(i));
        }else{
          child.setGene(i, eltern2.getGene(i));
        }
        
      }
      return child;
    }
    
  }
