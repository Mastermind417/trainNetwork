class NetworkPiece {
  PVector start;
  PVector end;
  boolean slanted;
  int colour;
  ArrayList<Train> trainsOnNetworkPiece;

  NetworkPiece(int startX, int startY, int endX, int endY) {
    start = new PVector(startX, startY);
    end = new PVector(endX, endY);
    slanted = false;
    colour = green;
    trainsOnNetworkPiece = new ArrayList<Train>();
  }

  void create() {
    //int black = #1A1919;
    stroke(colour); // black
    show();
  }

  void show() {
    stroke(colour);
    strokeWeight(2);
    line(start.x, start.y, end.x, end.y);
  }

  void showStatus(boolean active) {
    if (active) {
      colour = red;
    } else {
      colour = green;
    }
  }

  void addTrain(Train t) {
    trainsOnNetworkPiece.add(t);
  }
  
  void removeTrain(Train t){
    trainsOnNetworkPiece.remove(t);
  }
}
