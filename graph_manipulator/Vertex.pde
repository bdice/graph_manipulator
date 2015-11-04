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
      stroke(255, 166, 0);
      line(xpos,ypos,mouseX,mouseY);
      fill(255, 238, 0);
    }else{
      stroke(255, 166, 0);
      fill(255, 140, 0);
    }
    ellipse(xpos,ypos,r,r);
    fill(0);
    textSize(labelSize);
    text(name, xpos-labelSize/4, ypos+labelSize/3);
  }
}