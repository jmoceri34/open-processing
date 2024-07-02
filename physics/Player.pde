// Helper variables
//float a, b, c, d, e, f, g, k, m, n, o, p;

String last_key = "L";

// Player class that contains the four corner coordinates for the player block
class Player {

  float player_x;
  float player_y;

  float[] tl = new float[2];
  float[] tr = new float[2];
  float[] bl = new float[2];
  float[] br = new float[2];

  float w;
  float h;
  
  Gravity gravity;
  
  // For movement
  private boolean left = false, right = false;

  // Jump values
  private boolean jump = false, canJump = false;

  private float falling_value;

  Player(float x, float y, float tempw, float temph, float gv) {
    
    player_x = x;
    player_y = y;

    w = tempw;
    h = temph;

    tl[0] = player_x;
    tl[1] = player_y;

    tr[0] = player_x + tempw;
    tr[1] = player_y;

    bl[0] = player_x;
    bl[1] = player_y + temph;

    br[0] = player_x + tempw;
    br[1] = player_y + temph;
    
    gravity = new Gravity(gv);
    falling_value = gravity.intensity;
    
  }

  void movement() {

    if (jump && gravity.mid_air) {
      
      // This is what brings it back down after hitting the peak
      // The comparison value is the trigger point for when the player will begin to fall
      if (gravity.gravity_value >= gravity.intensity) {
          falling_value -= 0.1;
      }
      
      if (falling_value <= 0) {
        falling_value = 0;
      }
      
      player_y -= pow(falling_value, 2);
    }

    if (left) {
      // This must be placed above otherwise colliding with the wall will result in a movement forward
      change_speed(speed_value * -1, 0);

      if (frame_count % 5 == 0 && speed_value != 6) {
        speed_value += 0.5;
      }

      if (tl[0] < left_point) {
        xoffset -= speed_value;
        width -= speed_value + speed_value;
      }
    }
    else if (!left && last_key == "L") {
      if (frame_count % 5 == 0 && speed_value != 0) {
        speed_value -= 0.5;
      }

      if (tl[0] < left_point) {
        xoffset -= speed_value;
        width -= speed_value + speed_value;
      }

      change_speed(speed_value * -1, 0);
    }

    if (right) {
      // This must be placed above otherwise colliding with the wall will result in a movement forward
      change_speed(speed_value, 0);

      if (frame_count % 5 == 0 && speed_value != 6) {
        speed_value += 0.5;
      }

      if (tr[0] > right_point) {
        xoffset += speed_value;
        width += speed_value + speed_value;
      }
    }
    else if (!right && last_key == "R") {

      if (frame_count % 5 == 0 && speed_value != 0) {
        speed_value -= 0.5;
      }

      change_speed(speed_value, 0);

      if (tr[0] > right_point) {
        xoffset += speed_value;
        width += speed_value + speed_value;
      }
    }
  }

  void userKeyPressed() {

    // To allow only one jump per time
    if (key == ' ' && !jump && canJump) { // && !gravity.mid_air) {

      gravity.gravity_value = 0.1;

      jump = true;
      gravity.mid_air = true;
    }

    if (key == CODED) {

      if (keyCode == LEFT) {

        if (last_key == "R")
          speed_value = 0;

        last_key = "L";
        left = true;
      }
      else if (keyCode == RIGHT) {

        if (last_key == "L")
          speed_value = 0;

        last_key = "R";
        right = true;
      }
    }
  }

  void userKeyReleased() {

    // Reset purposes
    if (key == 'r') {
      
      player_y = 100;
      gravity.gravity_value = 0.1;
    }

    // This makes it go back down
    if (key == ' ') {

      jump = false;
      canJump = false;
      falling_value = gravity.intensity;
    }

    if (key == CODED) {
      if (keyCode == LEFT) {
        //right_point = ceil((1520 * 0.8)) + xoffset;
        left = false;
      }
      else if (keyCode == RIGHT) {
        //left_point = ceil((1520 * 0.2)) + xoffset;
        right = false;
      }
    }
  }

  void change_speed(float xspeed, float yspeed) {

    player_x += xspeed;
    player_y += yspeed;

    /*
    tl[0] = player_x;
     tl[1] = player_y;
     
     tr[0] = player_x + w;
     tr[1] = player_y;
     
     bl[0] = player_x;
     bl[1] = player_y + h;
     
     br[0] = player_x + w;
     br[1] = player_y + h;
     */
  }

  void update(StaticWorldBlock[] block_collide) {
    
    //println("as;ldkhgAS:LDKghas;kldja;skldh" + world_gravity.gravity_value);
    
    tl[0] = player_x;
    tl[1] = player_y;

    tr[0] = player_x + w;
    tr[1] = player_y;

    bl[0] = player_x;
    bl[1] = player_y + h;

    br[0] = player_x + w;
    br[1] = player_y + h;

    max_speed = 6;
    var collided = false;

    // Check each environment block in the world for a collision with the player
    int i;
    for (i=0;i<block_collide.length;i++) {

      /*
      a = tl[0];
       b = block_collide[i].bl[0];
       c = block_collide[i].br[0];
       
       
       
       d = round(tl[1] - pow(2, 2)) + (pow(gravity_value, 2)) ;
       e = block_collide[i].bl[1];
       f = block_collide[i].tl[1];
       
       if( i == 1){
       println("Iteration: " + i);
       println(a + " > " + b);
       println(a + " < " + c);
       println(d + " >= " + e);
       println(d + " <= " + f);
       }
       */

      /*
      If top left is within bottom range
       ** The 1st & 2nd expressions are checking if the tl x coord is within range of the current e. blocks x range **
       1st Exp: If tl x coord is greater than or equal to e. block x coord (bl[0])
       2nd Exp: If tl x coord is less than the e.block x coord + width (br[0])
       
       ** The 3rd & 4th expressions are checking if the future gravity comparison value is within the e. blocks y range ** 
       3rd Exp: If future gravity value y coord is greater than or equal to the e. block y coord (tl[1])
       4th Exp: If future gravity value y coord is less than or equal to the e. block y coord + height (bl[1])
       */
      if ( (tl[0] > block_collide[i].bl[0] && tl[0] < block_collide[i].br[0] && (round(tl[1] - pow(2, 2)) + (pow(gravity.gravity_value, 2)) >= block_collide[i].tl[1]) && (round(tl[1] - pow(2, 2)) + (pow(gravity.gravity_value, 2)) <= block_collide[i].bl[1])) ) {

        collided = true;
        
        // Place the player at the roof
        player_y = block_collide[i].bl[1];

        // and let gravity bring them down
        gravity.gravity_value = 2;
        
        jump = false;
        canJump = false;
        falling_value = gravity.intensity;
      }
      /*
      If top left is within right range
       ** The 1st & 2nd expressions are checking if the tl y coord is within range of the current e. blocks y range **
       1st Exp: If tl y coord is greater than or equal to e. block y coord (tr[1])
       2nd Exp: If tl y coord is less than or equal to e. block y coord + height (br[1])
       
       ** The 3rd & 4th expressions are checking if the future right movement is either at the e. block wall or would pass the wall **
       3rd Exp: If tl x coord minus buffer is greater than or equal to the e. block wall minus buffer (br[0] - 2)
       4th Exp: If tl x coord minus buffer is less than or equal to the e. block wall  (br[0])
       */
       /*println();
       print("begin | ");
       print(tl[1] >= block_collide[i].tr[1]);
       print("-");
       print(tl[1] <= block_collide[i].br[1]);
       print("-");
       print((tl[0] - (max_speed-1)) >= (block_collide[i].br[0] - (max_speed-1)));
       print("-");
       print(tl[0] - (max_speed-1) <= block_collide[i].br[0]);
       print(" | end");*/
      if (left) {
        if (tl[1] >= block_collide[i].tr[1] && tl[1] <= block_collide[i].br[1] && (tl[0] - (max_speed-1)) >= (block_collide[i].br[0] - (max_speed-1)) && (tl[0] - (max_speed-1)) <= block_collide[i].br[0] ) {

          collided = true;
          
          // If the player isn't right up against the wall, make it so
          if ( player_x != block_collide[i].tr[0])
            player_x = block_collide[i].tr[0];

          // To allow the player to move away from the wall
          if (!right)
            speed_value = 0;
        }
      }

      /*
      If top right is within bottom range
       ** The 1st & 2nd expressions are checking if the tr x coord is within the current e. blocks x range **
       1st Exp: If tr x coord is greater than or equal to e. block x coord (bl[0])
       2nd Exp: If tr x coord is less than the e.block x coord + width (br[0])
       
       ** The 3rd && 4th expressions are checking if the future gravity comparison value is within the current e. blocks y range ** 
       3rd Exp: If future gravity value is greater than or equal to the e. block y coord (tl[1])
       4th Exp: If future gravity value is less than or equal to the e. block y coord + height (bl[1])
       */
      if ( (tr[0] > block_collide[i].bl[0] && tr[0] < block_collide[i].br[0] && (round(tr[1] - pow(2, 2)) + (pow(gravity.gravity_value, 2)) >= block_collide[i].tl[1]) && (round(tr[1] - pow(2, 2)) + (pow(gravity.gravity_value, 2)) <= block_collide[i].bl[1])) ) {

        collided = true;
        
        // Place the player at the roof
        player_y = block_collide[i].bl[1];

        // and let gravity bring them down
        gravity.gravity_value = 2;
        
        jump = false;
        canJump = false;
        falling_value = gravity.intensity;
      }

      /*
      If top right is within left range
       ** The 1st & 2nd expressions are checking if the tr y coord is within range of the current e. blocks y range **
       1st Exp: If tr y coord is greater than or equal to e. block y coord (tl[1])
       2nd Exp: If tr y coord is less than or equal to e. block y coord + height (bl[1])
       
       ** The 3rd & 4th expressions are checking if the future right movement is either at the e. block wall or would pass the wall **
       3rd Exp: If tl x coord plus buffer is greater than or equal to the e. block wall plus buffer (bl[0] - 2)
       4th Exp: If tl x coord plus buffer is less than or equal to the e. block wall  (bl[0])
       */
      if (right) {
        if (tr[1] >= block_collide[i].tl[1] && tr[1] <= block_collide[i].bl[1] && (tr[0] + speed_value) <= (block_collide[i].bl[0] + (max_speed)) && (tr[0] + speed_value) >= block_collide[i].bl[0] ) {

          //println("tr lr trig");
          
          collided = true;

          // If the player isn't right up against the wall, make it so
          if (player_x + w != block_collide[i].bl[0])
            player_x = block_collide[i].bl[0] - w;

          // To allow the player to move away from the wall
          if (!left)
            speed_value = 0;
        }
      }


      /*
      a = bl[0];
       b = block_collide[i].tl[0];
       c = block_collide[i].tr[0];
       g = block_collide[i].bl[0];
       k = block_collide[i].br[0];
       d = bl[1];
       e = block_collide[i].tl[1];
       f = block_collide[i].tr[1];
       m = block_collide[i].bl[1];
       n = block_collide[i].br[1];
       */


      //println(a + " >= " + b);
      //println(a + " <= " + c);

      /*println("Iteration: " + i);
       println(a);
       println(d + " >= " + f);
       println(d + " <= " + n);
       println(a + " >= " + b);
       println(a + " <= " + g);
       
       //println(d);
       //println(d + pow(gravity_value, 2));
       //println(d + " >= " + e);
       //println(d + " <= " + f);
       */
      //println("Iteration: " + i);
      /*
      //println(d + " >= " + f);
       println("Iteration: " + i);
       println(d + " <= " + n);
       println( (a - 2) + " >= " + (k - 2) );
       println( (a - 2) + " <= " + k);
       */
      //println("Iteration: " + i);

      /*
      If bottom left is within top range
       ** The 1st & 2nd expressions are checking if the bl x coord is within range of the current e. blocks x range **
       1st Exp: If bl x coord is greater than or equal to e. block x coord (tl[0])
       2nd Exp: If bl x coord is less than the e.block x coord + width (tr[0])
       
       ** The 3rd & 4th expressions are checking if the future gravity value is within the e. blocks y range ** 
       3rd Exp: If future gravity value y coord is greater than or equal to the e. block y coord (tl[1])
       4th Exp: If future gravity value y coord is less than or equal to the e. block y coord + height (bl[1])
       */
      if ( (bl[0] > block_collide[i].tl[0] && bl[0] < block_collide[i].tr[0] && (round(bl[1]) + ceil((pow(gravity.gravity_value, 2))) >= block_collide[i].tl[1]) && (round(bl[1]) + ceil((pow(gravity.gravity_value, 2))) <= block_collide[i].bl[1])) ) {
        
        collided = true;
        canJump = true;
        
        //println("BL Trig");
        // Place the player on top of the e. block
        player_y = round(block_collide[i].tl[1] - h);

        // player lands on object, keep them on the object
        gravity.mid_air = false;

        // for a smooth fall 
        gravity.gravity_value = (gravity.intensity);
      }
      /*
      If bottom left is within right range
       ** The 1st & 2nd expressions are checking if the bl y coord is within range of the current e. blocks y range **
       1st Exp: If bl y coord is greater than or equal to e. block y coord (tr[1])
       2nd Exp: If bl y coord is less than or equal to e. block y coord + height (br[1])
       
       ** The 3rd & 4th expressions are checking if the future left movement is either at the wall or would pass the wall **
       3rd Exp: If bl x coord minus buffer is greater than or equal to the e. block wall minus buffer (br[0] - 2)
       4th Exp: If bl x coord minus buffer is less than or equal to the e. block wall  (br[0])
       
       */
      if (left) {
        if (bl[1] >= block_collide[i].tr[1] && bl[1] <= block_collide[i].br[1] && (bl[0] - (max_speed-1)) >= (block_collide[i].br[0] - (max_speed-1)) && (bl[0] - (max_speed-1)) <= block_collide[i].br[0] ) {

          collided = true;
          
          // If the player isn't right up against the wall, make it so
          if ( player_x != block_collide[i].tr[0])
            player_x = block_collide[i].tr[0];

          // To allow the player to move away from the wall
          if (!right)
            speed_value = 0;
        }
      }

      /*
      If bottom right is within top range
       ** The 1st & 2nd expressions are checking if the br x coord is within the current e. blocks x range **
       1st Exp: If br x coord is greater than or equal to e. block x coord (tl[0])
       2nd Exp: If br x coord is less than the e.block x coord + width (tr[0])
       
       ** The 3rd && 4th expressions are checking if the future gravity value is within the current e. blocks y range ** 
       3rd Exp: If future gravity value is greater than or equal to the e. block y coord (tl[1])
       4th Exp: If future gravity value is less than or equal to the e. block y coord + height (bl[1])
       */
      
      if ( (br[0] > block_collide[i].tl[0] && br[0] < block_collide[i].tr[0] && (round(bl[1]) + ceil((pow(gravity.gravity_value, 2))) >= block_collide[i].tl[1]) && (round(bl[1]) + ceil((pow(gravity.gravity_value, 2))) <= block_collide[i].bl[1])) ) {
        
        //println("BR trig");
        collided = true;
        canJump = true;
        
        // Place the player on top of the e. block
        player_y = round(block_collide[i].tl[1] - h);

        // player lands on object, keep them on the object
        gravity.mid_air = false;
        
        // for a smooth fall
        gravity.gravity_value = (gravity.intensity);
      }
      
      /*
      a = br[1];
       b = block_collide[i].tl[1];
       c = block_collide[i].bl[1];
       
       d = br[0] + 2;
       e = block_collide[i].bl[0] + 2;
       f = block_collide[i].bl[0];
       
       println("Iteration: " + i);
       println(a + " >= " + b);
       println(a + " <= " + c);
       
       println(d + " >= " + e);
       println(d + " <= " + f);      
       */

      /*
      If bottom right is within left range
       ** The 1st & 2nd expressions are checking if the br y coord is within range of the current e. blocks y range **
       1st Exp: If br y coord is greater than or equal to e. block y coord (tl[1])
       2nd Exp: If br y coord is less than or equal to e. block y coord + height (bl[1])
       
       ** The 3rd & 4th expressions are checking if the future left movement is either at the wall or would pass the wall **
       3rd Exp: If bl x coord minus buffer is greater than or equal to the e. block wall minus buffer (br[0] - 2)
       4th Exp: If bl x coord minus buffer is less than or equal to the e. block wall  (br[0])
       */
      if (right) {
        if ( br[1] >= block_collide[i].tl[1] && br[1] <= block_collide[i].bl[1] && (br[0] + speed_value) <= (block_collide[i].bl[0] + (max_speed)) && (br[0] + speed_value) >= block_collide[i].bl[0] ) {

          collided = true;
          
          // If the player isn't right up against the wall, make it so
          if (player_x + w != block_collide[i].bl[0])
            player_x = block_collide[i].bl[0] - w;

          // To allow the player to move away from the wall
          if (!left)
            speed_value = 0;
        }
      }
      
      if (!collided) {
        if (!gravity.mid_air) {
          // for a smooth fall
          gravity.gravity_value = gravity.intensity / 2;
        }
        
        gravity.mid_air = true;
      }
     
    }

    // Draw the player
    fill(0);
    rect(tl[0], tl[1], w, h);
  }
}
