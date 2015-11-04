class Graph{
  
  ArrayList<Vertex> vertices;
  ArrayList<Edge> edges;
  
  Graph(ArrayList<Vertex> _vertices, ArrayList<Edge> _edges){
    vertices = _vertices;
    edges = _edges;
  }
  
  void draw(){
    for(Edge e : edges){
      e.draw();
    }
    for(Vertex v : vertices){
      v.draw();
    }
  }
  
  Vertex findVertex(float x, float y){
    for(Vertex v : vertices){
      if(v.distanceTo(x, y) <= v.getR()){
        return v;
      }
    }
    return null;
  }
  
  boolean hasSelected(){
    for(Vertex v : vertices){
      if(v.getSelected()){
        return true;
      }
    }
    return false;
  }
  
  ArrayList<Vertex> selectedVertices(){
    ArrayList<Vertex> selectedVertices = new ArrayList<Vertex>();
    for(Vertex v : vertices){
      if(v.getSelected()){
        selectedVertices.add(v);
      }
    }
    return selectedVertices;
  }
  
  void deselectVertices(){
    for(Vertex v : selectedVertices()){
      v.select();
    }
  }
  
  void switchEdge(Edge e1){
    for(Edge e2 : edges){
      if(e1.equals(e2)){
        edges.remove(e2);
        return;
      }
    }
    edges.add(e1);
  }
  
  void complement(){
    for(int i = 0; i < vertices.size()-1; i++){
      for(int j = i+1; j < vertices.size(); j++){
        Edge e = new Edge(vertices.get(i), vertices.get(j));
        switchEdge(e);
      }
    }
  }
  
}