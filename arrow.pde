class Arrow{
  int[] start = new int[2];
  int[] end = new int[2];
  PVector arrow;
  //PVector xHat; // xHat is formally defined in main script - trainNetwork
  
  Arrow(int posX, int posY){
    start[0] = posX;
    start[1] = posY;
    end[0] = start[0];
    end[1] = start[1];
    arrow = new PVector(0,0);
    //xHat = new PVector(1,0); // xHat is formally defined in main script - trainNetwork
  }
  
  void reDefineEdge(int newPosX, int newPosY){
    start[0] = newPosX;
    start[1] = newPosY;
    arrow.set(-end[0]+start[0], -end[1]+start[1]);
  }
  
  void drawArrow(float amnt){
    stroke(0);
    strokeWeight(5); // same as line drawn
    //line(start[0], start[1], end[0], end[1]); // line is already drawn in main script - trainNetwork
    addWings(amnt);
  }
  
  void addWings(float amnt){
    if(start[0] == end[0] ||start[1] == end[1]) return;
    
    pushMatrix();
    translate(end[0], end[1]);
    float angleBetween = PVector.angleBetween(arrow, xHat);
    if(arrow.y < 0) angleBetween *= -1;
    float rotAngle = angleBetween - PI/4;
    rotate(rotAngle);
    int arrMag = int(map(amnt, 0, width/2, 0, height/4));
    //int arrMag = int(amnt)/2;
    line(0, 0, arrMag, 0);
    line(0, 0, 0, arrMag);
    popMatrix();
    //fill(0);
    //textSize(32);
    //text("Angle between xHat and arrow: " + angleBetween, width/2, height/2);
  }
    
}
