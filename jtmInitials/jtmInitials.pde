void setup(){
    
    background(0);
    size(400, 300);

}

void draw(){
  
    border();  

    first_initial();

    second_initial();

    third_initial();

}

void border(){

    stroke(255);
    fill(0, 150, 180);
    // Horizontal border lines
    rect(15, 15, 370, 10);
    rect(15, 275, 370, 10);
    
    // Vertical border lines
    rect(15, 15, 10, 270);
    rect(375, 15, 10, 270);
    fill(255);

}

void first_initial(){

    stroke(255);
    
    // 'j' dot
    rect(140, 115, 5, 5);
    
    // 'j' stem
    rect(140, 135, 5, 40);

    // 'j' branch
    rect(145, 175, -30, 5);
    rect(115, 175, 5, -5);
}

void second_initial(){
   
    stroke(255);  
  
    // 't' stem
    rect(180, 135, 5, 45);
    
    // 't' cross
    rect(161.5, 135, 45, 5);
  
}

void third_initial(){

    stroke(255);
    
    // 'm' left line
    rect(220, 135, 5, 45);
    
    // 'm' middle lines
    int i;
    for(i=0;i<20;i++){
    
        rect(220 + i, 135 + i, 5, 5);
    
    }
    
    for(i=0;i<20;i++){
    
        rect(241 + i, 154 - i, 5, 5); 
    
    }
    
    // 'm' right line
    rect(260, 135, 5, 45);
    
}
