public class DNA{
  
  private int[] order;
  
  public DNA(int length){
    this.order = genRandomOrder(length);
  }
  
  public DNA(int[] order){
    this.order = order;
  }
  
  private int[] genRandomOrder(int length){
   int[] order = new int[length];
   for(int i = 0; i < length; i++){
    order[i] = i; 
   }
   order = shuffel(order, length);
   return order;
  }
  
  private int[] shuffel(int[] array, int count){
    for(int i = 0; i < count; i++){
      swap(array, floor(random(array.length)),floor(random(array.length)));
    }
    return array;
  }
  
  public int[] shuffel(int count){
    for(int i = 0; i < count; i++){
      swap(order, floor(random(this.order.length)),floor(random(this.order.length)));
    }
    return order;
  }
  
  private int[] swap(int[] array, int indexA, int indexB){
    int a = array[indexA];
    int b = array[indexB];
    array[indexA] = b;
    array[indexB] = a;
    return array;
  }
  
  public int[] shift(){
    int[] shifted = new int[order.length];
    shifted[shifted.length-1] = order[0];
    for(int i = 0; i < shifted.length-1; i++){
      shifted[i] = order[i+1];
    }
    return shifted;
  }
  
  public DNA mutate(){
     return new DNA(shuffel(order.clone(),1));
  }
  
  public int[] getOrder(){
    return this.order;
  }
  
}
