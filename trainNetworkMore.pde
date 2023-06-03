void showNetwork(){
  for(NetworkPiece np : networkPieces){
    np.show();
  }  
}

void showAndUpdateTrains(){
  //background(255);
  for(Train t : trains){
    t.update();
    t.show();
  }
}

void removalOfTrainsFromCanvas(){
    int numberOfTrains = trains.size(); 
    
    // for some reason this is not shown before at least a train is added but that's fine
    textSize(56);
    text("Number of trains: " + numberOfTrains, width-1000, height-200);
    
    for(int k = numberOfTrains-1; k >=0; k--){
      Train t = trains.get(k);
      if(t.position.x + t.diameter/2 < 0 || t.position.x - t.diameter/2 > width || t.position.y + t.diameter/2 < 0 || t.position.y - t.diameter/2 > height){
        trains.remove(t);
      }
    }
}
