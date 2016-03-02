class Edge{
  
  Vertex u;
  Vertex v;
  float highlighted;
  
  Edge(Vertex _u, Vertex _v){
    u = _u;
    v = _v;
  }
  
  Edge(int ui, int vi, ArrayList<Vertex> vertices){
    u = vertices.get(ui);
    v = vertices.get(vi);
  }
  
  void draw(){
    float x1 = u.getX();
    float y1 = u.getY();
    float x2 = v.getX();
    float y2 = v.getY();
    color blue = color(0, 166, 255);
    color orange = color(255, 166, 0);
    if(highlighted > 0){
      strokeWeight(edgeThickness+4);
      stroke(lerpColor(orange, blue, (0.5+highlighted)/1.5));
    }else{
      strokeWeight(edgeThickness);
      stroke(orange);
    }
    line(x1, y1, x2, y2);
  }
  
  Vertex getU(){
    return u;
  }
  
  Vertex getV(){
    return v;
  }
  
  void highlight(float setValue){
    highlighted = setValue;
  }
  
  boolean equals(Edge e){
    if( (u == e.getU() && v == e.getV()) || (u == e.getV() && v == e.getU())){
      return true;
    }else{
      return false;
    }
  }
}