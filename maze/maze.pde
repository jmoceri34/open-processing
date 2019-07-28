// Joe Moceri
// 12/03/2012

// For switching between frames
Boolean intro = true, treasure_found = false, battle = false, game_over = false;

// For seconds timer
int frame_count = 0;

// For battle timer
int count = 3;

// Starting hammer position
int hammer_y = 0;

// For transition to battle
int color_alpha = 0;

// Placement of treasure
int decision;

// Initialize the treasure
int treasure_x = 10, treasure_y = 370;

Player user = new Player();

class Player {

  int player_x;
  int player_y;

  int[] tl = new int[2];
  int[] tr = new int[2];
  int[] bl = new int[2];
  int[] br = new int[2];
  
  Player() {
    
    player_x = mouseX;
    player_y = mouseY;

    tl[0] = this.player_x;
    tl[1] = this.player_y;

    tr[0] = this.player_x+15;
    tr[1] = this.player_y;

    bl[0] = this.player_x;
    bl[1] = this.player_y+15;

    br[0] = this.player_x+15;
    br[1] = this.player_y+15;
    
  }

  void update() {

    fill(127, 200, 255);

    player_x = mouseX;
    player_y = mouseY;

    tl[0] = this.player_x;
    tl[1] = this.player_y;

    tr[0] = this.player_x+15;
    tr[1] = this.player_y;

    bl[0] = this.player_x;
    bl[1] = this.player_y+15;

    br[0] = this.player_x+15;
    br[1] = this.player_y+15;

    if (!battle)  
      rect(mouseX, mouseY, 15, 15);
    else{
      rect(mouseX, mouseY, 50, 50);
        tl[0] = this.player_x;
        tl[1] = this.player_y;
    
        tr[0] = this.player_x+50;
        tr[1] = this.player_y;
    
        bl[0] = this.player_x;
        bl[1] = this.player_y+50;
    
        br[0] = this.player_x+50;
        br[1] = this.player_y+50;
    }
  }
}


void setup() {

  size(1024, 768);
  background(0);
  noStroke();
}

void draw() {
  
  frame_count++;
  
  // If we're at the intro...
  if (intro == true) {

    // draw the background and play button
    background(0);
    fill(255);
    rect(412, 359, 200, 50);
    
    treasure_found = false;
    
    fill(0);
    textSize(24);
    textAlign(CENTER);
    text("Play", 412, 369, 200, 50);
    textAlign(LEFT);
    
    // If user clicks play button
    if(mousePressed){
      if( (get(user.tl[0], user.tl[1]) == color(255)) || (get(user.tr[0], user.tr[1]) == color(255)) || (get(user.bl[0], user.bl[1]) == color(255)) || (get(user.br[0], user.br[1]) == color(255) )){

        // Make a decision
        decision = round(random(10));

        // Place treasure
        if (decision == 0) {
          treasure_x = 110;
          treasure_y = 210;
        }
        else if (decision == 1) {
          treasure_x = 10;
          treasure_y = 370;
        }
        else if (decision == 2) {
          treasure_x = 110;
          treasure_y = 510;
        }
        else if (decision == 3) {
          treasure_x = 780;
          treasure_y = 230;
        }
        else if (decision == 4) {
          treasure_x = 780;
          treasure_y = 370;
        }
        else if (decision == 5) {
          treasure_x = 910;
          treasure_y = 290;
        }
        else if (decision == 6) {
          treasure_x = 450;
          treasure_y = 480;
        }
        else if (decision == 7) {
          treasure_x = 410;
          treasure_y = 700;
        }
        else if (decision == 8) {
          treasure_x = 440;
          treasure_y = 230;
        }
        else if (decision == 9) {
          treasure_x = 610;
          treasure_y = 190;
        }
        
        // Go to the maze
        intro = false;
      }
    }
  }
  // If we're not at battle or the ending...
  else if (!battle && !game_over) {
    
    background(0);
    
    // Draw the maze
    fill(255);
    /* Left Side */
    
    // 1st
    rect(100, 320, 360, 30);
    rect(100, 320, 30, -120);
    
    // 2nd
    rect(0, 360, 360, 30);
    
    // 3rd
    rect(170, 400, 300, 30);
    rect(170, 400, 30, 100);
    rect(200, 500, -100, 30);
    
    /* Right Side */

    // 4th
    rect(650, 320, 50, 30);
    rect(700, 350, 30, -100);
    rect(700, 250, 100, -30);

    // 5th
    rect(650, 360, 150, 30);

    // 6th
    rect(650, 400, 250, 30);
    rect(900, 430, 30, -150);

    /* Bottom Side */

    // 7th
    rect(400, 450, 30, 200);
    rect(400, 650, 70, 30);
    rect(440, 650, 30, -180);

    // 8th
    rect(480, 450, 30, 270);
    rect(510, 690, -110, 30);

    /* Top Side */

    // 9th
    rect(600, 300, 30, -80);
    rect(600, 220, -170, 30);

    // 10th
    rect(390, 300, 30, -120);
    rect(390, 180, 240, 30);

    // Home base
    fill(53, 127, 255);
    rect(352, 289, 300, 170);

    // draw treasure
    stroke(1);
    fill(255, 255, 0);
    rect(treasure_x, treasure_y, 15, 15);
    noStroke();
    
    fill(0);
    
    // If the user hits the wall, restart the game
    if ( (get(user.tl[0], user.tl[1]) == color(0)) || (get(user.tr[0], user.tr[1]) == color(0)) || (get(user.bl[0], user.bl[1]) == color(0)) || (get(user.br[0], user.br[1]) == color(0) )) {
      treasure_found = false;
      intro = true;
    }

    // If the user hits the treasure, they must return home
    if ( (get(user.tl[0], user.tl[1]) == color(255, 255, 0)) || (get(user.tr[0], user.tr[1]) == color(255, 255, 0)) || (get(user.bl[0], user.bl[1]) == color(255, 255, 0)) || (get(user.br[0], user.br[1]) == color(255, 255, 0) )) {
      treasure_found = true;
    }
    
    // Tell them by displaying the message 
    if (treasure_found) {
      treasure_x = 5000;
      treasure_y = 5000;

      fill(255);
      text("Treasure Found", 800, 600, 300, 100);
      text("Return Home!", 800, 650, 300, 100);
    }

    // When they return home, go to battle
    if (treasure_found && ((get(user.tl[0], user.tl[1]) == color(53, 127, 255)) || (get(user.tr[0], user.tr[1]) == color(53, 127, 255)) || (get(user.bl[0], user.bl[1]) == color(53, 127, 255)) || (get(user.br[0], user.br[1]) == color(53, 127, 255) )) ) {
      battle = true;
    }
  }
  // If we're in battle...
  else if(battle){

    // Fade to battle
    if (frame_count%1 == 0 && color_alpha != 255)
      color_alpha+= 1;
    
    // Using a rectangle
    fill(0, color_alpha);
    rect(0, 0, 1024, 768);
    
    // Draw the red button
    fill(255, 0, 0);
    rect(800, 600, 60, 60);
    
    // and the monster
    draw_monster();
    
    // If the user completely steps on the red button
    if( (get(user.tl[0], user.tl[1]) == color(255, 0, 0)) && (get(user.tr[0], user.tr[1]) == color(255, 0, 0)) && (get(user.bl[0], user.bl[1]) == color(255, 0, 0)) && (get(user.br[0], user.br[1]) == color(255, 0, 0) )){
      
      // put the mouse there
      mouseX = 805;
      mouseY = 605;
      
      // bring down the hammer
      if(hammer_y < 500)
        hammer_y+=2;
    }
    else{
      
      // Countdown until 0
      if(frame_count%60 == 0)
        count--;
      
      // If the user doesn't hit the button in time, end the game
      if(count == 0){
        game_over = true;
        battle = false;
      }
      
      // Display the timer
      fill(255);
      textSize(64);
      text(" " + count, 100, 600, 100, 100);
    }
    
    // Display the hammer
    fill(255, 215, 0);
    rect(0, hammer_y-768, 1024, 768);
    
    user.update();
    
    // If the hammer crushed the monster, game over you win
    if(hammer_y == 500){
      fill(255);
      textSize(24);
      text("You defeated the monster! Play again?", 412, 600, 400, 100);
    }
  }
  // If the game ended with the user being eaten, game over
  else if(game_over){
    
    fill(0);
    rect(0, 0, 1024, 768);
    
    textSize(24);
    fill(255);
    text("The monster ate you. Play again?", 412, 600, 400, 100);
  
  }
  user.update();
}

void draw_monster() {

  smooth();
  rectMode(CENTER);
  fill(255);
  
  // Head
  ellipse(512, 184, 200, 100);
  rect(512, 235, 200, 100);

  rectMode(CORNER);

  // Tentacle #1
  rect(412, 235, -100, 50);
  rect(312, 235, 50, 200);

  // Tentacle #2
  rect(412, 235, 50, 200);
  
  // Tentacle #3
  rect(487, 235, 50, 100);
  
  // Tentacle #4
  rect(562, 235, 50, 200);

  // Tentacle #5
  rect(612, 235, 100, 50);
  rect(662, 235, 50, 200);

  fill(0);
}

void mouseReleased(){
  
  // When user clicks on either game over screen, restart the game
  if(hammer_y == 500 || game_over){
    
    intro = true;
    battle = false;
    treasure_found = false;
    game_over = false;
    frame_count = 0;
    
    count = 3;
    color_alpha = 0;
    hammer_y = 0;
    
  }
}
