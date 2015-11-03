class Edge{
  
  Vertex u;
  Vertex v;
  
  Edge(Vertex _u, Vertex _v){
    u = _u;
    v = _v;
  }
  
  void draw(){
    float x1 = u.getX();
    float y1 = u.getY();
    float x2 = v.getX();
    float y2 = v.getY();
    stroke(0, 255, 255);
    line(x1, y1, x2, y2);
  }
  
  Vertex getU(){
    return u;
  }
  
  Vertex getV(){
    return v;
  }
  
  boolean equals(Edge e){
    if( (u == e.getU() && v == e.getV()) || (u == e.getV() && v == e.getU())){
      return true;
    }else{
      return false;
    }
  }
}