public class Parallax 
{

   private int objX, objY, objW, objH, layer;

   public Parallax(int tempX, int tempY, int tempW, int tempH, int tempLayer)
   {
     objX = tempX; objY = tempY; objW = tempW; objH = tempH; layer = tempLayer;
   }
   
   public void updateParallax(boolean left, boolean right)
   {
     if(left) objX = layer == 1 ? objX+2 : objX+1;
     if(right) objX = layer == 1 ? objX-2 : objX-1;
     
     rect(objX, objY, objW, objH);
   }
}
