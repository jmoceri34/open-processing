
// Gravity creation
//Gravity world_gravity = new Gravity(3);



// Player creation
Player user = new Player(1520/2, 100, 30, 70, 3);

float frame_count = 0;

float left_point = round(1520 * 0.2);
float right_point = round(1520 * 0.8);

float xoffset = 0;

boolean move_back = false;

// Used for player movement
float speed_value = 0, max_speed = 6;

// Contains all of the environment blocks to interact with
StaticWorldBlock[] blocks = new StaticWorldBlock[6];

// Block creation
StaticWorldBlock block = new StaticWorldBlock(0, 500, 1000, 200);
StaticWorldBlock block01 = new StaticWorldBlock(1300, 500, 1500, 200);
StaticWorldBlock block02 = new StaticWorldBlock(3000, 500, 200, 200);
StaticWorldBlock block03 = new StaticWorldBlock(3400, 500, 1000, 200);
StaticWorldBlock block04 = new StaticWorldBlock(450, 350, 200, 200);
StaticWorldBlock block05 = new StaticWorldBlock(450, 0, 200, 200);

void setup() {

  size(1520, 780, P3D);
  background(255);
  noStroke();
  
  surface.setTitle("physics");
  
  blocks[0] = block;
  blocks[1] = block01;
  blocks[2] = block02;
  blocks[3] = block03;
  blocks[4] = block04;
  blocks[5] = block05;
}

void draw() { //<>//

  background(255);

  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  
  right_point = ceil((1520 * 0.6)) + xoffset;
  left_point = ceil((1520 * 0.4)) + xoffset;
  
  println(xoffset);
  
  user.movement();

  frame_count++;
  
  user.gravity.on();
  
  for (var i = 0; i < blocks.length; i++) {
    blocks[i].update();
  }

  user.update(blocks); //<>//
}

void keyPressed() {

  user.userKeyPressed();
}

void keyReleased() {

  user.userKeyReleased();
}
