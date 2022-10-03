class CubePhysicsManager{
  
  float collisionSlowdown = 0.9; // Lower is faster slowdown
  float cubeRepultion = 0;
  
  CubePhysicsManager(){
  }
  
  void Update(){
   //Gravity   
   for(int i=0; i <= cubePhysicsList.size() - 1; i += 1){
      CubePhysics currentCube = cubePhysicsList.get(i);
    
      currentCube.CalcGravity();
    }
    
    //CubeCollision
    for (int i=0; i <= cubePhysicsList.size() - 1; i += 1){
      CubePhysics cube1 = cubePhysicsList.get(i);
 
      for (int j=0; j <= cubePhysicsList.size() - 1; j += 1){
        CubePhysics cube2 = cubePhysicsList.get(j);
        
        if (dist(cube1.xPos, cube1.yPos, cube2.xPos, cube2.yPos) < (cube1.cubeHeight + cube1.cubeWidth) / 2 * 1.5 && cube1 != cube2){ //Check if cubes are close to each other
        
          //-----Need to rewrite, divide cube 2 in 4 cubes to determine cube1's new pos-----
        
          //Pos 3 - collision left bottom with top cube2
          if (cube1.xPos3 >= cube2.xPos && cube1.yPos3 >= cube2.yPos && cube1.xPos3 <= cube2.xPos4 && cube1.yPos3 <= cube2.yPos4 - (cube2.cubeHeight * 0.25)){ 
            cube1.ySpeed = cube2.ySpeed * collisionSlowdown;
            cube1.yPos = cube2.yPos - cube1.cubeHeight - cubeRepultion;
          }
        
          //Pos 4 - collision right bottom with top cube2
          if (cube1.xPos4 >= cube2.xPos && cube1.yPos4 >= cube2.yPos && cube1.xPos4 <= cube2.xPos4 && cube1.yPos4 <= cube2.yPos4 - (cube2.cubeHeight * 0.25)){
            cube1.ySpeed = cube2.ySpeed * collisionSlowdown;
            cube1.yPos = cube2.yPos - cube1.cubeHeight - cubeRepultion;
          }

          //Pos 1 - collision left side
          if (cube1.xPos >= cube2.xPos && cube1.yPos >= cube2.yPos && cube1.xPos <= cube2.xPos4 && cube1.yPos <= cube2.yPos4){ 
            cube1.xSpeed = cube2.xSpeed * collisionSlowdown;
            //cube1.xPos = cube2.xPos + cube1.cubeWidth + cubeRepultion;
          }
      
          //Pos 2 - collision right side
          if (cube1.xPos2 >= cube2.xPos && cube1.yPos2 >= cube2.yPos && cube1.xPos2 <= cube2.xPos4 && cube1.yPos2 <= cube2.yPos4){
            cube1.xSpeed = cube2.xSpeed * collisionSlowdown;
            //cube1.xPos = cube2.xPos - cube1.cubeWidth - cubeRepultion;
          }
        }
      }
    }
    
    //Update
    for(int i=0; i <= cubePhysicsList.size() - 1; i += 1){
      CubePhysics currentCube = cubePhysicsList.get(i);
    
      currentCube.update();
    }
    
    //AddForce
    if (spacebar == true){
      for(int i=0; i <= cubePhysicsList.size() - 1; i += 1){
        CubePhysics currentCube = cubePhysicsList.get(i);
      
        currentCube.AddForce();
      }
    }
  }
  
  void AddCubes(float _xPos, float _yPos, float _amount, float _cubeWeight){
    for (int i=1; i <= _amount; i += 1){
      cubePhysicsList.add(new CubePhysics(_xPos, _yPos, _cubeWeight));
    }
  }
  
  void AddCubesRandom(float _minXPos, float _maxXPos, float _minYPos, float _maxYPos, float _amount, float _cubeWeight){
    for (int i=1; i <= _amount; i += 1){
      cubePhysicsList.add(new CubePhysics(random(_minXPos, _maxXPos), random(_minYPos, _maxYPos), _cubeWeight));
    }
  }
}
