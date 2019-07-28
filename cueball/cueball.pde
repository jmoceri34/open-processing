// Joe Moceri
// 12/03/2012


int click_count = 0; // Keep track of clicks
color white = color(255, 255, 255); 
color red = color(255, 0, 0);
float xdist = 0, ydist = 0; // Used for tracking the x and y distance between the two balls
float xdistance = 0, ydistance = 0; // Used for keeping how much distance the ball has traveled

// Create the two balls
Ball cueBall = new Ball();
Ball targetBall = new Ball();

// Class that creates each ball and holds their current x and y coordinates / speed.
class Ball {

  float xcoord;
  float ycoord;
  float xspeed;
  float yspeed;

  // Default constructor
  Ball() {

    xcoord = 0.0;
    ycoord = 0.0;
    xspeed = 0.0;
    yspeed = 0.0;
  }

  // Draws the ball to the screen with the specified coordinates and colors
  void drawBall(float x1, float y1, color c) {

    noStroke();
    fill(c);
    ellipse(x1, y1, 30, 30);
  }
}

void setup() {

  size(600, 400);
  background(0, 255, 0);
  smooth();
}

void draw() {

  // Redraws the background each frame  
  background(0,255,0);

  // Listens for user key press
  if (keyPressed){

    // If it was 'c'...
    if (key == 'c'){
      
      // Draw the background over everything
      // and reset the variables
      background(0, 255, 0);
      click_count = 0;
      xdistance = 0;
      ydistance = 0;  
    }
  }
  
  // Shows the user where the ball will be placed
  // before click for both cue ball and target ball
  if(click_count == 0)
    cueBall.drawBall(mouseX, mouseY, white);
  if(click_count == 1)
    targetBall.drawBall(mouseX, mouseY, red);
  
  // Draw the cueball in it's position per frame
  if (click_count >= 1) {
    cueBall.drawBall(cueBall.xcoord, cueBall.ycoord, white);
  }
  // Draw the targetball in it's position per frame
  if(click_count >= 2) {
    targetBall.drawBall(targetBall.xcoord, targetBall.ycoord, red);
  }
  
  // If user has clicked atleast 3 times...
  if(click_count >= 3){
 
    // If the absolute x or y distance is less than the distance it has to travel...
    if(abs(xdistance) < (xdist-30)-.01 || abs(ydistance) < (ydist-30)-.01){       
      
      // then decrement it's coordinate by the x and y speed set...
      cueBall.xcoord-=cueBall.xspeed;
      cueBall.ycoord-=cueBall.yspeed;
            
      // and add the speed into the x and y distance traveled
      xdistance += cueBall.xspeed;
      ydistance += cueBall.yspeed;

    }
    
    // otherwise if the cue ball has collided with the target ball...
    else{
      // decrement it's x and y coordinates by the speed
      targetBall.xcoord-=cueBall.xspeed;
      targetBall.ycoord-=cueBall.yspeed;
    }
  }
}

void mouseReleased() {
  
  // If the it's the first click...
  if (click_count == 0) {
   
    // set it's x and y coordinates to where the user clicked
    cueBall.xcoord = mouseX;
    cueBall.ycoord = mouseY;

    click_count++;
  }
  // otherwise if it's the second click...
  else if (click_count == 1) { 

    // and if it's not ontop of or too close to the cue ball...    
    if ((mouseX < cueBall.xcoord-30 || mouseX > cueBall.xcoord+30) || (mouseY < cueBall.ycoord-30 || mouseY > cueBall.ycoord+30)){

      // Set it's x and y coordinates to where the user clicked
      targetBall.xcoord = mouseX;
      targetBall.ycoord = mouseY;

      click_count++;
    }
  }
  // otherwise if it's the third click...
  else if (click_count == 2) {
    
    // Initialize the distance as the absolute value between the two x and y points of the cueball and targetball    
    xdist = abs(cueBall.xcoord - targetBall.xcoord);
    ydist = abs(cueBall.ycoord - targetBall.ycoord);
    
    // Initialize the speed by taking the x and y distance and dividing by 40
    cueBall.xspeed = (cueBall.xcoord - targetBall.xcoord) / 40;
    cueBall.yspeed = (cueBall.ycoord - targetBall.ycoord) / 40;
    
    click_count++;
  }
}
