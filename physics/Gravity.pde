class Gravity {

  float intensity = 3;
  float gravity_value = 0.1;
  boolean mid_air = true;
  
  Gravity(float iv) {
  
    intensity = iv;
    
  }
  
  Gravity() {
  
  }
  
  void on() {
    
    // this is gravity
    if (mid_air) {
      user.player_y += pow(gravity_value, 2);
    }
    
    // This comparison value determines when to instate gravity to compare against
    // the falling value of the user. The higher this is, the higher the player will
    // be able to jump and inherently the harder they will fall. Vice versa, if its 
    // a low value the player will not be able to jump very high and instead will
    // fall more gently.
    
    if(gravity_value < intensity){
      gravity_value += 0.1;
    }
  }
  
}
