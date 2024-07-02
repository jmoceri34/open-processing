class StaticWorldBlock {

  float[] tl = new float[2];
  float[] tr = new float[2];
  float[] bl = new float[2];
  float[] br = new float[2];
  
  float w;
  float h;
  
  StaticWorldBlock(float x, float y, float tempw, float temph) {
  
    w = tempw;
    h = temph;
    
    tl[0] = x;
    tl[1] = y;
    
    tr[0] = x + tempw;
    tr[1] = y;
    
    bl[0] = x;
    bl[1] = y + temph;
    
    br[0] = x + tempw;
    br[1] = y + temph;

  }
  
  void update(){
    
    /*tr[0] = tl[0] + w;
    tr[1] = tl[1];
    
    bl[0] = tl[0];
    bl[1] = tl[1] + h;
    
    br[0] = tl[0] + w;
    br[1] = tr[1] + h;
    */
    
    fill(127);
    rect(tl[0], tl[1], w, h);
    
  }
  
}
