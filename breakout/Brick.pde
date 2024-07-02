public class Brick
{
  
  int leftBound, rightBound, topBound, bottomBound;
  int w, h;
  int x, y;
  float r, g, b;
  boolean active = true;
  
  public Brick(int tX, int tY)
  {
        w = 50;
        h = 20;
        
        x = tX + (w/2);
        y = tY + (h/2);
        r = random(255);
        g = random(255);
        b = random(255);
  }
  
  public boolean checkForCollision()
  {
    if (!active) {
      return false;
    }
    
    leftBound = x - (w/2);
    rightBound = x + (w/2);
    topBound = y - (h/2);
    bottomBound = y + (h/2);
    
    fill(r, g, b);
    rect(x, y, w, h);
    
    boolean xBounds = (ball.bX + 10) >= leftBound && (ball.bX - 10) <= rightBound;
    boolean yBounds = (ball.bY + 10) >= topBound && (ball.bY - 10) <= bottomBound;
    
    if (xBounds && yBounds)
    {
      return true;
    }
    
    return false;
  }
  
  public void deactivate(){
    active = false;
  }
}
