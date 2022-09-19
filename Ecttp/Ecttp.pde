//Ecttp les 03
//Ivar Nuij

//GameSettings
float FPS = 144; // lower than 60 causes slowdown
float updateSpeed = 60; //60 Times a second
float physicsUpdateSpeed = 1; // Higher is slower

//Time
float frameCounterSmoothAmount = 20; //Sum of amount of frames
float frameMillis;
float previousFrameMillis;
float currentFrameRate;
float drawDeltaTime;
int frameCounter;
FloatList frameMillisList;
public float deltaTime;
public float smoothFrameRate = 100;

//Rain
RainManager RainManager;
public float rainAmount = 100;
public float rainRespawnTimeAmount = 120;
ArrayList<Rain> rainList;
float rainRespawnTime;

//CubesPhysics
CubePhysicsManager CubePhysicsManager;
public float cubePhysicsAmount = 500;
public ArrayList<CubePhysics> cubePhysicsList;

//Other
UI UI;
GameManager GameManager;
public Player1 Player1;
Enemy enemy1;

//Sprites
public PImage rainDrop;

//Input
public boolean spacebar;
public boolean w;
public boolean d;
public boolean s;
public boolean a;

//--------------------------

void setup(){
  
  frameRate(FPS);
  fullScreen(P2D);
  smooth(); // Anti-Ailiasing
  
  //Instance Classes
  RainManager = new RainManager();
  CubePhysicsManager = new CubePhysicsManager();
  GameManager = new GameManager();
  UI = new UI();
  Player1 = new Player1();
  enemy1 = new Enemy();
  
  //Instance Arrays
  rainList = new ArrayList<Rain>();
  cubePhysicsList = new ArrayList<CubePhysics>();
  frameMillisList = new FloatList();
  
  //Sprites
  rainDrop = loadImage("sprites/rainDrop.png");
  
  CubePhysicsManager.AddCubes();
}

//Update
void FixedUpdate(){
  
  background(150);
  
  GameManager.update();
  
  noStroke();
  RainManager.update();
  stroke(1);
  
  CubePhysicsManager.update();
  Player1.Update();
  enemy1.Update();
}


void draw(){
  
  CalcFrameRate();
  CalcDeltaTime();
  
  //FixedUpdate
  drawDeltaTime += deltaTime;
  if (drawDeltaTime >= physicsUpdateSpeed){
    FixedUpdate();
    drawDeltaTime = 0;
  }
  
  UI.update();
}



//-----------------------------

//Inputs - Works only in class with draw()
void keyPressed(){
  if (key == 'a'){
    a = true;
  }
    
  if (key == 'd'){
    d = true;
  }
      
  if (key == 'w'){
    w = true;
  }
      
  if (key == 's'){
    s = true;
  }
    
  if (key == ' '){
    spacebar = true; 
  }
    
    
  if (key == ESC){
    exit();
  }
}

void keyReleased(){
  if (key == 'a'){
    a = false;
  }
    
  if (key == 'd'){
    d = false;
  }
      
  if (key == 'w'){
    w = false;
  }
      
  if (key == 's'){
    s = false;
  }
    
  if (key == ' '){
    spacebar = false; 
  }
}

//Time
void CalcFrameRate(){
  //currentFrameRate
  frameMillis = millis() - previousFrameMillis;
  previousFrameMillis = millis();
  currentFrameRate = 1000 / frameMillis;
  
  //smoothFrameRate
  frameMillisList.set(frameCounter, frameMillis);
  if (frameCounter >= frameCounterSmoothAmount){    
    
    float frameTotal = frameMillisList.sum();
    smoothFrameRate = 1000 / (frameTotal / frameCounterSmoothAmount);
   
    frameMillisList.clear();
    frameCounter = 0;
  }
  frameCounter += 1;
}

void CalcDeltaTime(){
  deltaTime = updateSpeed / currentFrameRate;
}
