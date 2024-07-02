public Player player;
public Ball ball;
public Brick[] bricks;
public int sizeWidth = 800, sizeHeight = 600;
public int frameRate = 0;
public int startTime = 0;
public int ln = 65;
public boolean cantCollideWithBricks = false; 
public boolean intro = true;

void setup()
{
  
  player = new Player();
  ball = new Ball();
  int totalBricks = 132;
  bricks = new Brick[totalBricks];
  int xCounter = 0, yCounter = 0;
  for (int i = 0; i < bricks.length; i++)
  {
    int tX = 75 * xCounter;
    if (tX >= 800) {
      tX = 0;
      xCounter = 0;
      yCounter++;
    }

    int tY = 20 * yCounter;
    
    bricks[i] = new Brick(tX, tY);
    
    xCounter++;
  }
  
  
  size(800, 600);
  rectMode(CENTER);
  noStroke();
  smooth();
  
}

void draw()
{
  if ((millis() - startTime) > ln && cantCollideWithBricks) {
    cantCollideWithBricks = false;
  }
  
  background(0);  
  player.update();
  
  ball.update();
  
  // check the bricks after the next ball update position
  for (int i = 0; i < bricks.length; i++)
  {
    boolean collision = bricks[i].checkForCollision();
    
    if (collision && !cantCollideWithBricks) {
      startTime = millis();
      cantCollideWithBricks = true;
      
      bricks[i].deactivate();
      if (ball.rightBound > bricks[i].rightBound || ball.leftBound < bricks[i].leftBound) {
        ball.flipX();
      }
      else {
        ball.flipY(); 
      }
    }
  }
}

void mouseMoved()
{
  if(intro) ball.bX = mouseX;
}

void mouseDragged()
{
  if(intro) ball.bX = mouseX;
}

void mouseReleased()
{
  if(intro)
  {
    intro = false; // once the game starts .. 
  }
}
