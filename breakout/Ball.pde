public class Ball
{
  public int leftBound, rightBound, topBound, bottomBound;
  public int bX, bY, speed, yDirection;
  private float xOffset, multiplier;
  public int w, h;
  
  public Ball()
  {
    bX = 400; bY = 300;
    speed = 5;
    yDirection = 1;
    xOffset = 0.0;
    multiplier = 4.0;
    w = 20;
    h = 20;
  }

  public void boundaryChecks()
  {    
   
    if(xOffset < 0)
    {
      if(bX <= 10)
      {
        xOffset *= -1;
      }
    }
    else if(xOffset > 0)
    {
      if(bX >= 790)
      {
        xOffset *= -1;
      }
    }
   
    if(yDirection < 0)
    {
      if(bY <= 10)
      {
        yDirection *= -1;
      }
    }
    else if(yDirection > 0)
    {
      if(bY >= 610)
      {
        bX = 400; bY = 300;
        xOffset = 0.0;
        speed = 5;
      }
    }
  
  }
  
  public void checkForPlayerHit()
  {
  
    if(bX >= player.tl && bX <= player.tr && bY > 570)
    {
      
      speed = 5;
      if(bY == player.mid_point)
      {
        xOffset = 0.0;
      }
      else
      {
        xOffset = ((bX - player.mid_point) / multiplier);
        speed += abs(floor(multiplier) + 2) - abs(multiplier);
      }
      
      yDirection *= -1;
      
    }
  
  }
  
  public void flipY() {
    yDirection *= -1;
  }
  
  public void flipX() {
    xOffset *= -1;
  }

  public void update()
  {
    if (!intro) {
        boundaryChecks();
    
      leftBound = bX - (w/2);
      rightBound = bX + (w/2);
      topBound = bY - (h/2);
      bottomBound = bY + (h/2);
    
      if(yDirection == 1)
      {
        checkForPlayerHit();
      }
    
      bX += xOffset;
      bY += (speed * yDirection);
    }
    
    fill(255, 0, 0);
    ellipse(bX, bY, w, h);
  }

}
