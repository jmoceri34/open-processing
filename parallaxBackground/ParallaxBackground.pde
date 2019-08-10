// Joe Moceri
// Parallax Background

boolean left, right, idle = true;
int curDirection = 1;
Player player = new Player();
Parallax piece01 = new Parallax(100, 100, 100, 2000, 1), piece02 = new Parallax(450, 100, 100, 2000, 1);
Parallax piece03 = new Parallax(50, 50, 200, 2000, 2), piece04 = new Parallax(500, 50, 200, 2000, 2);
float jump_count = 0;
PImage[] leftImg = new PImage[7], rightImg = new PImage[7];

void setup()
{
  for(int i = 0; i < 7; i++) leftImg[i] = loadImage("Left" + "0" + (i+1) + ".png");
  for(int i = 0; i < 7; i++) rightImg[i] = loadImage("Right" + "0" + (i+1) + ".png");
  size(800, 600);
  background(0);
  frameRate(60);
  player.pX = width / 2;
  player.pY = height / 2;
}

void draw()
{
  background(0);
  
  if(left)
  {
    player.change_speed(-3, 0); 
  }
  else if(right)
  {
    player.change_speed(3, 0); 
  }
  else 
  {
    idle = true;
  }
  
  displayLayerTwo(); displayLayerOne(); displayEnvironment();
  player.draw_player();
}

private void displayLayerOne()
{
  fill(180); piece01.updateParallax(left, right); piece02.updateParallax(left, right);
}

private void displayLayerTwo()
{
  fill(80); piece03.updateParallax(left, right); piece04.updateParallax(left, right);
}

private void displayEnvironment()
{
  fill(128); rect(-50, height - 200, 1500, 1000);
}

void keyPressed()
{
  
  if(key == CODED)
  {
    if(keyCode == LEFT)
    {
      left = true; curDirection = 1;
    }
    else if(keyCode == RIGHT)
    {
      right = true; curDirection = 2;
    }
  }
  
}

void keyReleased()
{
  if(key == CODED)
  {
    if(keyCode == LEFT)
    {
      left = false;
    }
    else if(keyCode == RIGHT)
    {
      right = false;
    }
  }
}
