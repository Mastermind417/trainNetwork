void checkForSnap(){
  for(Train t : trains){
    float trainXCoord = t.position.x;
    float trainYCoord = t.position.y;
    
    // straight network pieces snapping (only horizontal)
    for(PVector np : networkPoints){
      float networkPointXCoor = np.x;
      float networkPointYCoor = np.y;
      if(abs(trainXCoord - networkPointXCoor) <= 2 && abs(trainYCoord - networkPointYCoor) <= 2){
        t.velocity.y = 0;
        NetworkPiece associatedNetworkPiece = pointsToPieces.get(np);
        associatedNetworkPiece.addTrain(t);
        associatedNetworkPiece.showStatus(true);
        
        // initial exit condition but dropped for see below
        //if(abs(trainXCoord - associatedNetworkPiece.start.x) <= 2 && abs(trainYCoord - associatedNetworkPiece.start.y) <= 2 || abs(trainXCoord - associatedNetworkPiece.end.x) <= 2 && abs(trainYCoord - associatedNetworkPiece.end.y) <= 2){
        //  associatedNetworkPiece.removeTrain(t);
        //  associatedNetworkPiece.showStatus(false);
        //}

        // like described in pg. 18 of draft book but currently doesn't work
        float trainDistanceFromStart = dist(trainXCoord, trainYCoord, associatedNetworkPiece.start.x, associatedNetworkPiece.start.y);
        float trainDistanceFromEnd = dist(trainXCoord, trainYCoord, associatedNetworkPiece.end.x, associatedNetworkPiece.end.y);
        if(trainDistanceFromStart < t.diameter/2 || trainDistanceFromEnd < t.diameter/2){
          associatedNetworkPiece.removeTrain(t);
          associatedNetworkPiece.showStatus(false);
        }
      }
    }
    
    // 'slanted' network pieces snapping
    for(PVector snp : slantedNetworkPoints){
      float networkPointXCoor = snp.x;
      float networkPointYCoor = snp.y;
      if(abs(trainXCoord - networkPointXCoor) <= 2 && abs(trainYCoord - networkPointYCoor) <= 2){
        // construct the vector (v*m_hat)m_hat where v is the train velocity and m_hat is a vector along the slope of the slanted piece
        PVector alongGradientVelocity = slantedGradient.copy();
        float magn = PVector.dot(slantedGradient, t.velocity);
        alongGradientVelocity.mult(magn);
        t.velocity.x = alongGradientVelocity.x;
        t.velocity.y = alongGradientVelocity.y;        

        NetworkPiece associatedNetworkPiece = pointsToPieces.get(snp);
        associatedNetworkPiece.addTrain(t);
        associatedNetworkPiece.showStatus(true);
        
        // initial exit condition but dropped for see below
        //if(abs(trainXCoord - associatedNetworkPiece.start.x) <= 2 && abs(trainYCoord - associatedNetworkPiece.start.y) <= 2 || abs(trainXCoord - associatedNetworkPiece.end.x) <= 2 && abs(trainYCoord - associatedNetworkPiece.end.y) <= 2){
        //  associatedNetworkPiece.removeTrain(t);
        //  associatedNetworkPiece.showStatus(false);
        //}
        
        // the distance is checked against the train's radius
        float trainDistanceFromStart = dist(trainXCoord, trainYCoord, associatedNetworkPiece.start.x, associatedNetworkPiece.start.y);
        float trainDistanceFromEnd = dist(trainXCoord, trainYCoord, associatedNetworkPiece.end.x, associatedNetworkPiece.end.y);
        if(trainDistanceFromStart < t.diameter/2 || trainDistanceFromEnd < t.diameter/2){
          associatedNetworkPiece.removeTrain(t);
          associatedNetworkPiece.showStatus(false);
        }
      }
    }
  }
}
