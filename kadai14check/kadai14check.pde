Mousecontrol mouse;  //視点移動

PShape arm1,arm2,arm3,arm4,head;
float rx, ry;
float angle0 = 0, angle1 = 0, angle2 = 0, angle3 = 0, angle4 = 0, angle5 = 0,angle6 = 0;  //関節角
float headx = 0, heady = 0; //頭の角度
float dif = 0.5;  //関節角の加速度
float ac = 0.01;  //自動制御の加速度
float l1 = 10, l2 = 7.5, l3a = 2.6, l3 = 6.6;  //腕の長さ
float angle0a, angle1a, angle2a, px, py, pz, A;  //自動制御で使用する
boolean flag;

void setup(){
  size(1200, 800, OPENGL);
 
  camera(450, 450, 150, -600, -600, 200, 0, 0, -1);
 
  //視点移動
  mouse = new Mousecontrol(rx, ry);
  
  //要素の呼び出し
  arm1 = loadShape("r1.obj");
  arm2 = loadShape("r2.obj");
  arm3 = loadShape("r3.obj");
  arm4 = loadShape("r4.obj");
  head = loadShape("head.obj");
  
  arm1.disableStyle(); 
  arm2.disableStyle(); 
  arm3.disableStyle(); 
  arm4.disableStyle(); 
  head.disableStyle(); 
  
  angle0 = 90;
  angle1 = 70;
  angle2 = 100;
  
  //制御モード
  flag = false;
}


void draw(){
  background(32);
  smooth(); 
  lights();
  
  mouse.move();
  mouse.mousemove();
  
 
  
  //手動キーボード操作
  if(keyPressed){
    
    //アーム
    if(key == '1'){
      angle0 = angle0 + dif;
    }
    if(key == '!'){
      angle0 = angle0 - dif;
    }
    if(key == '2' ){
      angle1 = angle1 + dif;
    }
    if(key == '"'){
      angle1 = angle1 - dif;
    }
    if(key == '3'){
      angle2 = angle2 + dif;
    }
    if(key == '#'){
      angle2 = angle2 - dif;
    }
    if(key == '4'){
      angle3 = angle3 + dif;
    }
    if(key == '$'){
      angle3 = angle3 - dif;
    }
    if(key == '5'){
      angle4 = angle4 + dif;
    }
    if(key == '%'){
      angle4 = angle4 - dif;
    }
    if(key == '6' ){
      angle5 = angle5 + dif;
    }
    if(key == '&'){
      angle5 = angle5 - dif;
    }
    if(key == '5'){
      angle4 = angle4 + dif;
    }
    if(key == '%'){
      angle4 = angle4 - dif;
    }
    if(key == '6' ){
      angle5 = angle5 + dif;
    }
    if(key == '&'){
      angle5 = angle5 - dif;
    }
    
    //頭
    if(key == 'a'){
      heady = heady - dif;
    }
    if(key == 'd'){
      heady = heady + dif;
    }
    if(key == 'w' ){
      headx = headx + dif;
    }
    if(key == 's'){
      headx = headx - dif;
    }
  }
  
  //nomal position
  if(key == 'r'){
      angle0 = 90;
      angle1 = 70;
      angle2 = 100;
      angle3 = 0;
      angle4 = 0;
      angle5 = 0;
      
  }
  
  //angle limit
  if (angle1 == 141){
    angle1 = 140;
  }
  if (angle1 == -141){
    angle1 = -140;
  }
  if (heady == 41){
    heady = 40;
  }
  if (heady == -41){
    heady = -40;
  }
  if (headx == 1){
    headx = 0;
  }
  if (headx == -11){
    headx = -10;
  }
    
  scale(20);
  
  //head
  pushMatrix();
  translate(0, 8, 0);
  rotateX(radians(2*headx));
  rotateY(radians(2*heady));
  shape(head);
  popMatrix();
  
  
  //1st link
  translate(0, 0, 0);
  rotateZ(radians(angle0));
  fill(150);
  shape(arm1);
  
  //2nd link
  translate(0, 0, 10);
  rotateY(radians(angle1));
  fill(125);
  shape(arm2);
  
  //3rd link
  translate(0, -2, 7.5);
  rotateY(radians(angle2));
  fill(175);
  shape(arm3);
  
  //4th link
  translate(0, -0.6, 6.6);
  rotateX(radians(angle3));
  rotateY(radians(angle4));
  rotateZ(radians(angle5));
  fill(200);
  shape(arm4);
  
  //auto angle calc   
  px = -6*sin(radians(2*heady));
  py = 6*sin(radians(-2*headx))+7.5;
  pz = 6*cos(radians(2*heady));
  angle2a= acos((sq(px)+sq(py)+sq((pz-l1))-sq(l3)-sq(l3a)-sq(l2))/(2*l2*l3));
  angle1a= asin((l1-pz)/sqrt(sq(px)+sq(py)+sq((pz-l1))-sq(l3a)))+atan((l2+cos(angle2a)*l3)/(sin(angle2a)*l3));
  A = sin(angle1a)*l2+sin(angle1a)*cos(angle2a)*l3+cos(angle1a)*sin(angle2a)*l3;
  angle0a = PI-((asin(-px/sqrt(sq(A)+sq(l3a)))+atan(A/l3a)));
  
  //mode
  if(keyPressed){
   if(key == 'n' ){
     flag = true;  //auto
     }
   }
   if(key == 'm' ){
     flag = false;   //manual
   }

   //Automatic control
   if(flag == true){
      while(radians(angle0) < angle0a){
        angle0 += ac;
      }
      while(radians(angle0) > angle0a){
        angle0 -= ac;
      }
      while(radians(angle1) < angle1a){
        angle1 += ac;
      }
      while(radians(angle1) > angle1a){
        angle1 -= ac;
      }
      while(radians(angle2) < angle2a){
        angle2 += ac;
      }
      while(radians(angle2) > angle2a){
        angle2 -= ac;
      }
   }
 
  //各種制御値
  println("顔移動キー　wasd"); 
  println("自動制御(nキー)、手動制御(mキー) 現在は自動モード:"+flag); 
  println("頭の角度 "+headx,heady);
  println("目標位置 "+px,py,pz);
  println("目標の角度 "+angle0a,angle1a,angle2a);
  println("実際の角度 "+radians(angle0),radians(angle1),radians(angle2));
}
