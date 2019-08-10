public class Player
{

  public int pX, pY, w, h, tl, tr, mid_point;
  
  public Player()
  {  
    w = 100; h = 20;
    pX = 400; pY = 590;
    tl = 0; tr = 0;
    mid_point = 0;
  }

  public void update()
  {  
    pX = mouseX;
    tl = pX - (w/2);
    tr = pX + (w/2);
    mid_point = pX;
    
    fill(255);
    rect(pX, pY, w, h);
  }

}
