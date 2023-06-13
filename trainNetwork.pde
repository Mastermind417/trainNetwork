// data structures
ArrayList<NetworkPiece> networkPieces = new ArrayList<NetworkPiece>();
ArrayList<PVector> networkPoints = new ArrayList<PVector>();
ArrayList<PVector> slantedNetworkPoints = new ArrayList<PVector>();
ArrayList<Train> trains;
HashMap<PVector, NetworkPiece> pointsToPieces; // this tells you that point(x,y) belongs to which network piece
ArrayList<Arrow> arrows;

// control
PVector lastMouseLoc;
PVector newMouseLoc;
boolean lineActive;
int green = #1BB44F;
int red = #A25252;
int black = 0;

// transformations
PVector xHat; 

// log
PrintWriter logger;

// slanted piece gradient;
PVector slantedGradient;

void setup(){
  fullScreen();
  background(255);
  
  networkPoints = new ArrayList<PVector>();
  slantedNetworkPoints = new ArrayList<PVector>();
  networkPieces = new ArrayList<NetworkPiece>();
  trains = new ArrayList<Train>();
  pointsToPieces = new HashMap<PVector, NetworkPiece>();
  arrows = new ArrayList<Arrow>();
  
  lastMouseLoc = new PVector();
  newMouseLoc = new PVector();
  lineActive = false;
  
  xHat = new PVector(1,0);
  
  logger = createWriter("log.txt");
  
  int offsetX = width/8; // some offset so that map does not stick to ends of canvas
  
  // creating the network layout
  // horizontal
  //networkPieces.add(new NetworkPiece(offsetX, height/3, width - offsetX, height/3));
  networkPieces.add(new NetworkPiece(offsetX, height/3, 3*width/4, height/3));
  networkPieces.add(new NetworkPiece(3*width/4, height/3, width - offsetX, height/3));
  //networkPieces.add(new NetworkPiece(offsetX, 2*height/3, width - offsetX, 2*height/3));
  networkPieces.add(new NetworkPiece(offsetX, 2*height/3, 1*width/4, 2*height/3));
  networkPieces.add(new NetworkPiece(1*width/4, 2*height/3, width - offsetX, 2*height/3));
  
  // slanted
  NetworkPiece snp = new NetworkPiece(3*width/4, height/3, 1*width/4, 2*height/3);
  snp.slanted = true;
  networkPieces.add(snp);
  
  // add points of network pieces to networks points data structure
  
  // horizontal pieces creation
  for(NetworkPiece np : networkPieces){
    np.create();
    
    // condition to move to the next piece if piece is slanted
    if(np.start.y != np.end.y) continue;

    for(int i = int(np.start.x); i <= np.end.x; i++){
      PVector nPoint = new PVector(i, np.start.y);
      networkPoints.add(nPoint); // np.start.y and np.end.y are the same since line is parallel to x-axis
      pointsToPieces.put(nPoint, np);    
    }
  }
  
  // vertical pieces creation
  for(NetworkPiece np : networkPieces){
    np.create();
    
    // condition to move to the next piece if piece is slanted
    if(np.start.x != np.end.x) continue;

    for(int i = int(np.start.y); i <= np.end.y; i++){
      PVector nPoint = new PVector(np.start.y, i);
      networkPoints.add(nPoint);
      pointsToPieces.put(nPoint, np);
    } 
  }
  
  // slanted piece
  NetworkPiece slantedNetworkPiece = networkPieces.get(4);
  float xInitial = slantedNetworkPiece.start.x;
  float yInitial = slantedNetworkPiece.start.y;
  
  int numIncrements = 500;
  float dx = (slantedNetworkPiece.end.x - slantedNetworkPiece.start.x)/numIncrements;
  float dy = (slantedNetworkPiece.end.y - slantedNetworkPiece.start.y)/numIncrements;
  slantedGradient = new PVector(dx,dy);
  slantedGradient.normalize();
  
  // discretise line along gradient
  for(int i = 0; i <= numIncrements; i++){
      float pointX = xInitial + i*dx;
      float pointY = yInitial + i*dy;
      PVector snPoint = new PVector(pointX, pointY);
      slantedNetworkPoints.add(snPoint);
      pointsToPieces.put(snPoint, slantedNetworkPiece);
  }  
}

void draw(){
  background(255); //<>//
  
  showNetwork();
  showAndUpdateTrains();
  
  checkForSnap();
  checkForTrainCollisions();
  
  removalOfTrainsFromCanvas();
  
  showLine(); // this is for the arrow line but independed from the Arrow class. It works with mouse events.  
  
  float arrowDist = dist(lastMouseLoc.x, lastMouseLoc.y, newMouseLoc.x, newMouseLoc.y); 
  if(arrows.size()<1) return;
  Arrow arrow = arrows.get(arrows.size()-1);
  arrow.drawArrow(arrowDist);
}

void mousePressed(){
  lastMouseLoc.set(mouseX, mouseY);  
  Arrow arrow = new Arrow(int(lastMouseLoc.x), int(lastMouseLoc.y));
  arrows.add(arrow);
}

void mouseDragged(){
  lineActive = true;
  newMouseLoc.set(mouseX, mouseY);
  Arrow arrow = arrows.get(arrows.size()-1);
  arrow.reDefineEdge(int(newMouseLoc.x), int(newMouseLoc.y));
}

void mouseReleased(){
  PVector addition = new PVector(lastMouseLoc.x-mouseX, lastMouseLoc.y-mouseY);
  Train nT = new Train(lastMouseLoc.x, lastMouseLoc.y, addition.x, 0, addition.x/100 , addition.y/100);
  trains.add(nT);
  lineActive = false;
  
  Arrow arrow = arrows.get(arrows.size()-1);
  arrows.remove(arrow);
}

void showLine(){
  if(!lineActive) return;  
  
  // this draws the line
  stroke(0);
  strokeWeight(5);
  line(lastMouseLoc.x, lastMouseLoc.y, newMouseLoc.x, newMouseLoc.y);
  
  // attempt to draw arrows 
  // magnitude
  //float mag = dist(lastMouseLoc.x, lastMouseLoc.y, newMouseLoc.x, newMouseLoc.y);
  //float rightArrowX = lastMouseLoc.x + mag/10*cos(PI/4);
  //float rightArrowY = lastMouseLoc.x + mag/10*sin(PI/4);
  
  // right arrow
  //stroke(0);
  //strokeWeight(5);
  //line(newMouseLoc.x, newMouseLoc.y, rightArrowX, rightArrowY); 
}

void keyPressed(){
  if(key == 'r'){
    setup();
  }
}
