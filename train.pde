 class Train{
  PVector position;
  float size; // size of the train on network, eg. number of wagons
  float speed; // speed of the train along the network
  PVector velocity;
  int direction; // whether the train is going left or right (either +1 or -1)
  int diameter;
  boolean canMoveOnNetworkPiece;
  PVector lastVelocity;
  
  Train(float posX, float posY, float size_, float speed_, float velX, float velY){
    position = new PVector(posX, posY);
    size = size_;
    speed = speed_;
    velocity = new PVector(velX, velY);
    diameter = 20;
    canMoveOnNetworkPiece = true;
    lastVelocity = new PVector(0,0);
  }
  
  void update(){
    position.add(velocity);
  }

  void updateOnMap(boolean mapSlantedAtPoint){
    int verticalDirOn = int(mapSlantedAtPoint); 
    position.add(speed, verticalDirOn * speed);
  }
  
  void show(){
    fill(0);
    strokeWeight(1);
    stroke(255);
  
    // dots/circles represent the train
    circle(position.x, position.y, diameter);
  } 
}
  
