//視点移動
class Mousecontrol{
  float rotX,rotY;
  
  Mousecontrol(float rotx,float roty){
    rotX = rotx;
    rotY = roty;
  }
  
  void move(){
    rotate(rotX);
    rotate(rotY);
  }
  
  void mousemove(){
    if (mousePressed){
    rotX -= (mouseY - pmouseY) * 0.01;
    rotY -= (mouseX - pmouseX) * 0.01;
    }
  }
  
}
    
