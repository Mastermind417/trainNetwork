void checkForTrainCollisions(){
  int numberOfTrains = trains.size();
  
  //textSize(56);
  //text("Number of trains: " + numberOfTrains, width-1000, height-200);
  
  //if(numberOfTrains <= 2) return;
  
  for(int i = 0; i<numberOfTrains-1; i++){
    // queued system
    Train firstTrain = trains.get(i);
    for(int j = i+1; j<numberOfTrains; j++){
      Train secondTrain = trains.get(j);
      PVector relativePosition = PVector.sub(secondTrain.position, firstTrain.position); // order doesn't matter as magnitude is concerned in the if condition below
      
      // condition for collision
      if(relativePosition.mag() <= abs(secondTrain.diameter/2+secondTrain.diameter/2)){
        secondTrain.lastVelocity = secondTrain.velocity.copy(); 
        secondTrain.velocity.set(0,0);
        secondTrain.canMoveOnNetworkPiece = false;
        // trains collide head on on horizontal axis
        if(firstTrain.velocity.x * secondTrain.lastVelocity.x < 0){
          firstTrain.lastVelocity = firstTrain.velocity.copy(); 
          firstTrain.velocity.set(0,0);
          firstTrain.canMoveOnNetworkPiece = false;
        }
      }
    }
  }
}
