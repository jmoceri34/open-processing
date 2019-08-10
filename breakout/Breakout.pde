public Player player;
public Ball ball;
public Brick[] bricks;
public int sizeWidth = 800, sizeHeight = 600;

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
  println(ball.bY);
  
  background(0);  
  player.update();
  ball.update();
  
  for (int i = 0; i < bricks.length; i++)
  {
    boolean collision = bricks[i].checkForCollision();
    
    if (collision) {
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
