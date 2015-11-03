class Vertex{
  float r;
  float xpos;
  float ypos;
  String name;
  boolean selected;
 
  Vertex(float _xpos, float _ypos, float _r, String _name){
    r = _r;
    xpos = _xpos;
    ypos = _ypos;
    name = _name;
  }
 
  void move (float _xpos, float _ypos) {
    xpos = _xpos;
    ypos = _ypos;
  }
  
  float getX(){
    return xpos;
  }
  
  float getY(){
    return ypos;
  }
  
  float getR(){
    return r;
  }
  
  boolean getSelected(){
    return selected;
  }
  
  void select(){
    selected = !selected;
  }
  
  float distanceTo(float x, float y){
    return sqrt(pow(x-xpos,2) + pow(y-ypos,2));
  }
 
  void draw(){
    if(selected){
      stroke(255, 255, 0);
      line(xpos,ypos,mouseX,mouseY);
      fill(200);
    }else{
      stroke(255, 255, 255);
      fill(255);
    }
    ellipse(xpos,ypos,r,r);
    text(name, xpos+r, ypos+r);
  }
}