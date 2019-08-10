public class Player 
{

  public int pX, pY, curIndex = 0;
  
  public Player()
  {
    pX = width / 2; pY = height / 2;
  }
  
  public void draw_player()
  {
    PImage selected = left || curDirection == 1 ? leftImg[curIndex] : rightImg[curIndex]; image(selected, pX, pY); cycleAnimation();
  }
  
  public void cycleAnimation()
  {
   if(idle)
   {
     curIndex = 0; return;
   }
   if(frameCount % 5 == 0)
   {
     curIndex++;
     if(curIndex == 7)
     {
       curIndex = 0;
     }
    }
    
  }
  
  public void change_speed(int xSpeed, int ySpeed)
  {
    idle = false;
    pX += xSpeed;
    
    if(pX + 40 < 0)
    {
      pX = -40; left = false; 
    }
    if(pX + 90 > width)
    {
      pX = width - 90; right = false; 
    }

  }

}
