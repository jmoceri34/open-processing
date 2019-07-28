// Creates the player
Player user = new Player();

// Used to set the coordinates for the treasure in the danger zone
int treasure_x = round(random(1000));
int treasure_y = round(random(488));

int score_x = round(random(1000));
int score_y = round(random(488));

int damage_x = round(random(1000));
int damage_y = round(random(488));

int extra_score = 0, extra_damage = 0;

boolean left = false, right = false, up = false, down = false;

int secs, base = -1;

// These values are used for getting in between the scenes
boolean game_over = false, battle_mode = false, intro = true, instructions = false;

// Base player values
int player_health = 100, player_damage = 10, player_treasure = 0;

// Base metaltron values
int metal_health = 50, metal_damage = 5;

// Used for timing
int count = 0, count01 = 0, num;

// initializes the value for the first pass
int max_player_damage = player_damage;

// initializes to start the damage increase chain
int previous_increase = -1;

// player turn is used for the battle sequence and game start is used at the beginning
// of the battle sequence
boolean player_turn = false, game_start = true;

String battle_message;

// ph = player health, pd = player damage etc...
String ph_message, pd_message, pt_message;
String pa_message, pbd_message, ps_message;

// mh = metal health etc...
String mh_message, md_message;

String go_message;

int player_score;
String high_score;

int frame_amount = 0;

// Player class that stores his x&y coordinates to be drawn
class Player {

  int player_x;
  int player_y;
  int[] top_left = new int[2];
  int[] top_right = new int[2];
  int[] bottom_left = new int[2];
  int[] bottom_right = new int[2];
  
  Player(){
    
    this.player_x = 512;
    this.player_y = 584;
    
    this.top_left[0] = this.player_x;
    this.top_left[1] = this.player_y;
    
    this.top_right[0] = this.player_x+20;
    this.top_right[1] = this.player_y;
    
    this.bottom_left[0] = this.player_x;
    this.bottom_left[1] = this.player_y+40;
    
    this.bottom_right[0] = this.player_x+20;
    this.bottom_right[1] = this.player_y+40;
    
  }
  
  void draw_player(){
    
    this.top_left[0] = this.player_x;
    this.top_left[1] = this.player_y;
    
    this.top_right[0] = this.player_x+20;
    this.top_right[1] = this.player_y;
    
    this.bottom_left[0] = this.player_x;
    this.bottom_left[1] = this.player_y+40;
    
    this.bottom_right[0] = this.player_x+20;
    this.bottom_right[1] = this.player_y+40;
    
    fill(127, 200, 255);
    rect(player_x, player_y, 20, 40);

  }
  
  void change_speed(int xspeed, int yspeed){
  
    player_x += xspeed;
    top_left[0] += xspeed;
    top_right[0] += xspeed;
    bottom_left[0] += xspeed;
    bottom_right[0] += xspeed;
    
    player_y += yspeed;
    top_left[1] += yspeed;
    top_right[1] += yspeed;
    bottom_left[1] += yspeed;
    bottom_right[1] += yspeed;
    
  }

}

void setup(){

  size(1024, 768);
  background(51);
  
}

void draw(){
  
  player_score = (player_damage*3) * (player_treasure*10) + (extra_score * 500);
  
  // If we're at the beginning of the game...
  if(intro == true){
    
    // redraw the bg
    fill(51);
    rect(0, 0, 1024, 768);
    fill(255);
    textSize(24);
    textAlign(CENTER);
    
    // Display the title and information 
    text("Mark of A Zealous Existence: The Game", 0, 284, 1024, 768);
    text("i - Instructions", 0, 450, 1024, 768);
    text("Press space bar to continue...", 0, 700, 1024, 768);
    textSize(18);
    text("Defeat Metal Tron, Gain Treasure!", 312, 315, 400, 200);
    textAlign(LEFT);
  }
  
  if(instructions == true){
    
    fill(51);
    rect(0, 0, 1024, 768);
    
    fill(255);
    textSize(24);
    text("Use the arrow keys for movement.", 150, 50, 1024, 768);

    // Draw Treasure
    fill(255, 255, 0);
    rect(100, 150, 40, 40);
    textSize(30);
    textAlign(CENTER);
    fill(0);
    text("T", 100, 155, 40, 40);
    textSize(24);
    textAlign(LEFT);
    
    fill(255, 255, 0);
    text("This is treasure, collect it!", 150, 150, 1024, 768);
    
    // Draw Extra Score
    fill(255);
    rect(100, 200, 40, 40);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("S", 100, 205, 40, 40);
    textAlign(LEFT);
    textSize(24);
    
    fill(255);
    text("This is extra score, it provides a whopping +500!", 150, 200, 1024, 768);
    
    // Draw Extra Damage
    fill(0, 127, 255);
    rect(100, 250, 40, 40);
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("D", 100, 255, 40, 40);
    textAlign(LEFT);
    
    fill(0, 127, 255);
    textSize(24);
    text("This is damage. It gives you +5 more!", 150, 250, 1024, 768);
  
    // Draw Danger Zone
    fill(255, 0, 0, 127);
    rect(100, 300, 40, 40);

    fill(255, 0, 0);
    text("This is the danger zone. Every second you are in here, you lose 5 health but gain 1 damage. Be careful!", 150, 300, 824, 768);
    fill(255);
    text("Metaltron is relentless and will guard every treasure with its life!", 150, 400, 1024, 768);
    text("Every two treasures you collect, you are empowered 10 more health.", 150, 500, 1024, 768);
    textSize(30);
    textAlign(CENTER);
    text("Good Luck!", 0, 650, 1024, 768);
    textAlign(LEFT);
    
  }
  
  // To keep track of each second
  frame_amount++;

  // If the game is over, show the end screen
  if(game_over == true){
    fill(255);
    textSize(24);
    background(51);
    text(go_message, 512, 384, 400, 200);
    displayHighscore(player_damage, player_treasure);
    text("Play Again?...", 312, 700, 400, 200);
    
  }
  
  // Otherwise, start at the beginning
  if(game_over == false && battle_mode == false && intro == false){
    
    if(left){
      user.change_speed(-3, 0);
    }
    if(right){
      user.change_speed(3, 0);
    }
    if(up){
      user.change_speed(0, -3);
    }
    if(down){
      user.change_speed(0, 3);
    }
    
    // redraw bg for opacity effect  
    fill(51);
    rect(0, 0, 1024, 768);
    
    // danger zone
    fill(255, 0, 0, 127);
    rect(0, 0, 1024, 512);
    
    user.draw_player();
    
    // draws the treasure

    fill(255, 255, 0);
    rect(treasure_x, treasure_y, 40, 40);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("T", treasure_x, treasure_y+5, 40, 40);
    textAlign(LEFT);

    // If the user has hit the treasure...
    if( (user.top_left[0] > treasure_x && user.top_left[0] < treasure_x+40) && (user.top_left[1] > treasure_y && user.top_left[1] < treasure_y+40) || (user.top_right[0] > treasure_x && user.top_right[0] < treasure_x+40) && (user.top_right[1] > treasure_y && user.top_right[1] < treasure_y+40) || (user.bottom_left[0] > treasure_x && user.bottom_left[0] < treasure_x+40) && (user.bottom_left[1] > treasure_y && user.bottom_left[1] < treasure_y+40) || (user.bottom_right[0] > treasure_x && user.bottom_right[0] < treasure_x+40) && (user.bottom_right[1] > treasure_y && user.bottom_right[1] < treasure_y+40) ){
      // go to battle mode
      battle_mode = true;
      
      // reset the coordinates so this only triggers once...
      user.player_x = 512;
      user.player_y = 584;
      
      user.top_left[0] = user.player_x;
      user.top_left[1] = user.player_y;
    
      user.top_right[0] = user.player_x+20;
      user.top_right[1] = user.player_y;
    
      user.bottom_left[0] = user.player_x;
      user.bottom_left[1] = user.player_y+40;
    
      user.bottom_right[0] = user.player_x+20;
      user.bottom_right[1] = user.player_y+40;
      
      // for the other values
      previous_increase = -1;
      max_player_damage = player_damage;
    }

    // If the user has collected atleast one treasure
    if(player_treasure >= 1){
      fill(255);
      rect(score_x, score_y, 40, 40);
      fill(0);
      textSize(30);
      textAlign(CENTER);
      text("S", score_x, score_y+5, 40, 40);
      textAlign(LEFT);
      
      // If the user collects an extra score
      if( (user.top_left[0] > score_x && user.top_left[0] < score_x+40) && (user.top_left[1] > score_y && user.top_left[1] < score_y+40) || (user.top_right[0] > score_x && user.top_right[0] < score_x+40) && (user.top_right[1] > score_y && user.top_right[1] < score_y+40) || (user.bottom_left[0] > score_x && user.bottom_left[0] < score_x+40) && (user.bottom_left[1] > score_y && user.bottom_left[1] < score_y+40) || (user.bottom_right[0] > score_x && user.bottom_right[0] < score_x+40) && (user.bottom_right[1] > score_y && user.bottom_right[1] < score_y+40) ){
        extra_score++;
        score_x = 2000;
      }
    }
    
    // If the user collects atleast two treasures
    if(player_treasure >= 2){
      fill(0, 127, 255);
      rect(damage_x, damage_y, 40, 40);
      fill(255);
      textSize(30);
      textAlign(CENTER);
      text("D", damage_x, damage_y+5, 40, 40);
      textAlign(LEFT);
      
      // If the user collects extra damage
      if( (user.top_left[0] > damage_x && user.top_left[0] < damage_x+40) && (user.top_left[1] > damage_y && user.top_left[1] < damage_y+40) || (user.top_right[0] > damage_x && user.top_right[0] < damage_x+40) && (user.top_right[1] > damage_y && user.top_right[1] < damage_y+40) || (user.bottom_left[0] > damage_x && user.bottom_left[0] < damage_x+40) && (user.bottom_left[1] > damage_y && user.bottom_left[1] < damage_y+40) || (user.bottom_right[0] > damage_x && user.bottom_right[0] < damage_x+40) && (user.bottom_right[1] > damage_y && user.bottom_right[1] < damage_y+40) ){
        extra_damage++;
        player_damage += 5;
        damage_x = 2000;
      }
    }
  
    
    // draws the extra score if the user has collected a treasure
    if(player_treasure >= 1){

    }
    
    // draws the extra damage if the user has collected atleast two treasures
    if(player_treasure >= 2){

    }
    
    display_ui(player_health, player_damage, player_treasure, player_score);
    
    // If the user crosses into the danger zone
    if(user.player_y < 512){
        // If the player dies, end the game
      if(player_health <= 0){
        go_message = "The danger zone got to you.";
        game_over = true;
      }
        
      // Get the second count
      /*secs = millis() / 1000;
      
      // Get the base second
      if(base == -1)
        base = secs;
      */
      
      // For every second...
      if(frame_amount%60 == 0){
        // Take away health, add to damage
        player_health -= 5;
        player_damage += 1;
      }      
      
      // If player is over time limit, game over
      /*if(secs >= base+200){
        
        player_health -= 5;
        player_damage += 1;
        
        println("game over too late.");
        game_over = true;
        
      }*/
    }
  }
  
  // Otherwise, time for battle mode
  else if(battle_mode == true){
  
    background(51);
    fill(255);
    textSize(24);
    
    // If player dies during battle
    if(player_health <= 0){
      player_health = 0;
      game_over = true;
      battle_mode = false;
      go_message = "Metal Tron loafed you.";
    }
    
    // If player beats metal tron
    if(metal_health <= 0){
      metal_health = 0;
      battle_message = "You defeated Metal Tron!";
      
      // wait 5 seconds...
      if(frame_amount % 60 == 0){
        count01++;
      }
      
      // then move on
      if(count01 == 5){
            
        player_treasure++;
        
        treasure_x = round(random(1000));
        treasure_y = round(random(488));
        
        score_x = round(random(1000));
        score_y = round(random(488));
        
        damage_x = round(random(1000));
        damage_y = round(random(488));
        
        if(player_treasure % 2 == 0){
          player_health += 10;
        }
        
        metal_health = 50;
        count01 = 0;
        metal_damage = 5;
        game_start = true;
        count = 0;
        
        battle_mode = false;
      }
    }
    
    // If we're at the beginning of a battle
    if(player_turn == false){
      // display the opening message
      if(game_start == true){
        battle_message = "Metal Tron stands in your way!";
        game_start = false;
      }
      // wait 5 seconds...
      if(frame_amount % 60 == 0){
        count++;
      }
      
      // Then metal tron opens with an attack
      if(count == 5){
        num = round(random(1));
        player_turn = true;
        count = 0;
        // One of his attacks is to reduce the players damage, by playing a Meatloaf song
        if(num == 0){
          battle_message = "Metal Tron plays a Meatloaf song! You lose damage.";
          
          // The players damage can never go below 5. The sequence is: 2 - 2 - 1 - 0 - 0  - ...
          if(max_player_damage >= 10){
            if(player_damage > max_player_damage-4)
              player_damage -= 2;
            else if(player_damage == max_player_damage-4)
              player_damage -= 1;
            else
              player_damage -= 0;
          }
          else if(max_player_damage - 2 <= 5)
            player_damage = 5;
        }
        // His other attack is to reduce the players health by firing a lazer.
        else if(num == 1){
          battle_message = "Metal Tron fires a lazer! You lose health.";
          player_health -= metal_damage;
        }
      }
    }
    
    // At the end of a turn, display the message
    text(battle_message, 350, 600, 300, 300);
    
    // Draw metaltron and display both ui's
    MetalTron(metal_health);
    display_ui(player_health, player_damage, player_treasure, player_score);
    display_metalUI(metal_health, metal_damage);
    
  }
}

void keyPressed(){
  
  if(key == CODED){
    if(keyCode == LEFT){
      left = true;
    }
    else if(keyCode == RIGHT){
      right = true;
    }
    else if(keyCode == UP){
      up = true;
    }
    else if(keyCode == DOWN){
      down = true;
    }
  }
  
}

// For the key selections that need to happen only once
void keyReleased(){
  
  if(key == CODED){
    if(keyCode == LEFT){
      left = false;
    }
    else if(keyCode == RIGHT){
      right = false;
    }
    else if(keyCode == UP){
      up = false;
    }
    else if(keyCode == DOWN){
      down = false;
    }
  }
  
  // If it's the players turn in a battle mode...
  if(player_turn == true){
    
    // and they select 'a'...
    if(key == 'a'){
      
      // the player attacks by busting out a fast riff,
      battle_message = "You bust out a fast riff! Metal Tron loses health.";
      
      // metal tron loses health as a result.
      metal_health -= player_damage;
    }
    
    // If they select 'd'...
    else if(key == 'd'){
      
      // player charges the hammer and gets an increase in damage.
      battle_message = "You charge your hammer with thunderous power! Damage Increase.";
      
      // The increase sequence is as follows. 2 - 3 - 4 - 0 - 0 - ...
      if(previous_increase == -1){
        player_damage += 2;
        previous_increase = 2;
      }
      else if(previous_increase == 2){
        player_damage += 3;
        previous_increase = 3;
      }
      else if(previous_increase == 3){
        player_damage += 4;
        previous_increase = 4;
      }
      
      // Now, if the player damage increase causes us to go over our max damage before... then set it equal
      // to that new value. What this does is now whenever metaltron reduces the players damage, it corresponds 
      // to the current max damage, which can change if you are continually increasing your damage. Metal tron can only reduce
      // by a maximum of 5 from the players max damage, and the player can gain overall +9 from this. But, if metal
      // tron is reducing damage at the same rate the player is gaining, the player can only have a +3 net gain,
      // and metal tron can still go -2 below that. But the difference here is that's -2 that he can possibly do in 
      // in comparison to the -5 he could of done if the player chose not to increase at all. This can also potentially
      // hurt the player in the end if +3 isn't enough to shorten the amount of times he has to attack, which adds an
      // interesting dynamic to it.
      if(max_player_damage < player_damage)
        max_player_damage = player_damage;
    }
    /*DEBUG
    else if(key == 'f')
      battle_message = "Skip turn. TEST";*/
    
    player_turn = false;
  }
  
  if(instructions == true){
    if(key == ' '){
      intro = false;
      instructions = false;    
    }
  }
  
  // Used for the intro when any key is pressed
  if(intro == true){
    if(key == ' '){
      intro = false;
    }
    if(key == 'i'){
      instructions = true;
    }
  }
  
  
  
  // When the game is over and player wants to play again...
  if(game_over == true && key != CODED){
    
    // reset the variables
    intro = true;
    game_over = false;
    player_health = 100;
    player_damage = 10;
    player_treasure = 0;
    extra_score = 0;
    user.player_x = 512;
    user.player_y = 584;
    
    damage_x = round(random(1000));
    damage_y = round(random(488));
    
    score_x = round(random(1000));
    score_y = round(random(488));
    
  }

}

void MetalTron(int metal_health){

  fill(255);
  // head
  rect(350, 200, 300, 375);

  // left antennae
  rect(375, 100, 50, 100);
  
  // with bulb
  ellipse(400, 100, 50, 50);
  
  // right antennae
  rect(575, 100, 50, 100);
  
  // with bulb
  ellipse(600, 100, 50, 50);
  
  fill(0);
  // left eye
  ellipse(425, 300, 100, 75);
  
  // right eye
  ellipse(575, 300, 100, 75);
  
  // When the metal tron is defeated, 
  if(metal_health <= 0){
  // left 'x' eye
  stroke(255, 0, 0);
  strokeWeight(5);
  line(390, 275, 460, 325);
  line(390, 325, 460, 275);
  
  // right 'x' eye
  line(540, 275, 610, 325);
  line(540, 325, 610, 275);
  }
  
  strokeWeight(1);
  stroke(0);
  
  // mouth
  fill(0);
  rect(395, 400, 210, 100);
  
  fill(255);
  // top teeth
  triangle(395, 400, 430, 450, 465, 400);
  triangle(465, 400, 500, 450, 535, 400);
  triangle(535, 400, 570, 450, 605, 400);
  
  // bottom teeth 
  triangle(430, 500, 465, 450, 500, 500);
  triangle(500, 500, 535, 450, 570, 500);

}

void display_ui(int health, int damage, int treasure, int score){

  // User interface messages
  ph_message = "Health: " + str(health);
  pd_message = "Damage: " + str(damage);
  pt_message = "Treasure: " + str(treasure);
  ps_message = "Score: " + str(score);
  
  // For UI text
  fill(255);
  textSize(18);
  text(ph_message, 20, 650, 400, 200);
  text(pd_message, 20, 675, 400, 200);
  text(pt_message, 20, 700, 400, 200);
  text(ps_message, 20, 725, 400, 200);
  
  // When in battle mode, show the player battle choices
  if(battle_mode == true){
    pa_message = "A - Attack";
    pbd_message = "D - Hammer Charge: Increase Damage";
    text(pa_message, 20, 600, 400, 200);
    text(pbd_message, 20, 540, 250, 200);
  }
}

void display_metalUI(int health, int damage){

  mh_message = "MetalTron Health: " + str(health);
  md_message = "MetalTron Damage: " + str(damage);
  
  fill(255);
  textSize(18);
  text(mh_message, 800, 675, 400, 200);
  text(md_message, 800, 700, 400, 200);
  
}

void displayHighscore(int damage, int treasure){
  
  player_score = (player_damage*3) * (player_treasure*10) + extra_score*500;
  
  high_score = "Score: " + player_score;
  
  text(high_score, 512, 504, 400, 200);
  
}
