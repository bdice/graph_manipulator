class Graph{
  
  ArrayList<Vertex> vertices;
  ArrayList<Edge> edges;
  
  Stack<Vertex> visited;
  Vertex currentVertex;
  
  ArrayList<Integer> pi;
  ArrayList<Integer> piStar;
  
  Random randomGenerator;
  
  int cliqueNumber;
  
  Graph(ArrayList<Vertex> _vertices, ArrayList<Edge> _edges){
    vertices = _vertices;
    edges = _edges;
    visited = new Stack<Vertex>();
    pi = new ArrayList<Integer>();
    piStar = new ArrayList<Integer>();
    randomGenerator = new Random();
  }
  
  void draw(){
    for(Edge e : edges){
      e.highlight(0);
    }
    for(int i = 1; i < visited.size(); i++){
      Edge e = getEdge(visited.get(i-1), visited.get(i));
      if(e != null){
        e.highlight(1-((float) i/visited.size()));
      }
    }
    for(Edge e : edges){ 
      e.draw();
    }
    for(Vertex v : vertices){
      if(visited.contains(v)){
        v.highlight(true);
      }else{
        v.highlight(false);
      }
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
  
  Edge getEdge(Vertex u, Vertex v){
    Edge e1 = new Edge(u, v);
    for(Edge e2 : edges){
      if(e2.equals(e1)){
        return e2;
      }
    }
    return null;
  }
  
  boolean hasEdge(Edge e1){
    for(Edge e2 : edges){
      if(e2.equals(e1)){
        return true;
      }
    }
    return false;
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
  
  ArrayList<Vertex> getNeighbors(Vertex v){
    ArrayList<Vertex> neighbors = new ArrayList<Vertex>();
    for(Edge e : edges){
      if(e.getU() == v){
        neighbors.add(e.getV());
      }else if(e.getV() == v){
        neighbors.add(e.getU());
      }
    }
    return neighbors;
  }
  
  void updateGraph(){
    // Count clique size (SLOW):
    //cliqueNumber = findLargestClique(vertices);
    
    // Hamiltonian algorith (incomplete):
    //visited = new Stack<Vertex>();
    //currentVertex = vertices.get(0);
    //visited.add(currentVertex);
    
    // Get degree sequence:
    updateDegreeSequence();
  }
  
  void updateDegreeSequence(){
    pi.clear();
    for(Vertex v : vertices){
      int degree = 0;
      for(Edge e : edges){
        if(e.getU() == v || e.getV() == v){
          degree++;
        }
      }
      pi.add(degree);
    }
    Collections.sort(pi);
    Collections.reverse(pi);
    print("Pi: ");
    println(pi);
    piStar.clear();
    for(int i = 1; i <= pi.get(0); i++){
      int degree = 0;
      for(int j = 0; j < pi.size(); j++){
        if(i <= pi.get(j)){
          degree++;
        }
      }
      piStar.add(degree);
    }
    Collections.sort(piStar);
    Collections.reverse(piStar);
    print("PiStar: ");
    println(piStar);
  }
  
  int getTrace(){
    updateDegreeSequence();
    int trace = 0;
    while(pi.get(trace) > trace){
      trace++;
    }
    return trace;
  }
  
  boolean isThreshold(){
    int t = getTrace();
    if(t < 1 || pi.size() < t || piStar.size() < t){
      return false;
    }else{
      for(int i = 0; i < t; i++){
        if(piStar.get(i) != pi.get(i) + 1){
          return false;
        }
      }
      return true;
    }
  }
  
  int getCliqueNumber(){
    return cliqueNumber;
  }
  
  int getEdgeCount(){
    return edges.size();
  }
  
  String getDegreeSequence(){
    String s = "(";
    for(int i = 0; i < pi.size(); i++){
      s += pi.get(i);
      if(i + 1 < pi.size()){
        s+= ", ";
      }else{
        s+= ")";
      }
    }
    return s;
  }
  
  String getConjugateSequence(){
    String s = "(";
    for(int i = 0; i < piStar.size(); i++){
      s += piStar.get(i);
      if(i + 1 < piStar.size()){
        s+= ", ";
      }else{
        s+= ")";
      }
    }
    return s;
  }
  
  int findLargestClique(ArrayList<Vertex> vs){
    if(isClique(vs)){
      return vs.size();
    }else{
      int maxCliqueSize = 1;
      for(Vertex v : vs){
        ArrayList<Vertex> vs2 = new ArrayList<Vertex>();
        vs2.addAll(vs);
        vs2.remove(v);
        int cliqueSize = findLargestClique(vs2);
        maxCliqueSize = max(maxCliqueSize, cliqueSize);
      }
      return maxCliqueSize;
    }
  }
  
  boolean isClique(ArrayList<Vertex> vertices){
    for(int i = 0; i < vertices.size()-1; i++){
      for(int j = i+1; j < vertices.size(); j++){
        Edge e1 = new Edge(vertices.get(i), vertices.get(j));
        boolean edgeFound = false;
        for(Edge e2 : edges){
          if(e1.equals(e2)){
            edgeFound = true;
          }
        }
        if(!edgeFound){        
          return false;
        }
      }
    }
    return true;
  }
  
  void swapRandomEdge(){
    if(edges.size() > 0){
      int eIndex = randomGenerator.nextInt(edges.size());
      edges.remove(eIndex);
      
      int uIndex = randomGenerator.nextInt(vertices.size());
      int vIndex = randomGenerator.nextInt(vertices.size());
      while(uIndex == vIndex){
        vIndex = randomGenerator.nextInt(vertices.size());
      }
      Edge e = new Edge(uIndex, vIndex, vertices);
      while(hasEdge(e)){
        uIndex = randomGenerator.nextInt(vertices.size());
        vIndex = randomGenerator.nextInt(vertices.size());
        while(uIndex == vIndex){
          vIndex = randomGenerator.nextInt(vertices.size());
        }
        e = new Edge(uIndex, vIndex, vertices);
      }
      edges.add(e);
    }
  }
  
  void hamiltonianCycle(){
    if(visited.size() == 0){
      currentVertex = vertices.get(0);
      visited.add(currentVertex);
    }
    if(visited.size() == vertices.size()){
      Vertex lastVertex = visited.pop();
      while(visited.size() < vertices.size()){
        ArrayList<Vertex> nextOptions = getNeighbors(visited.peek());
        int pathIndex = nextOptions.indexOf(lastVertex);
        while(pathIndex == nextOptions.size()-1){
          lastVertex = visited.pop();
          nextOptions = getNeighbors(visited.peek());
          pathIndex = nextOptions.indexOf(lastVertex);
          nextOptions.removeAll(visited);
        }
        Vertex option = nextOptions.get(pathIndex+1);
        if(!visited.contains(option)){
          visited.add(option);
        }else{
        }
      }
    }else{
      while(visited.size() < vertices.size()){
        for(Vertex v: getNeighbors(currentVertex)){
          if(!visited.contains(v)){
            currentVertex = v;
            visited.add(currentVertex);
            break;
          }
        }
      }
    }
    for(Vertex v : visited){
      print(v.toString() + ", ");
    }
    println();
  }
  
  void generalGraph(int numVertices, int gridWidth){
    for(int i = 0; i < numVertices; i++){
      float xpos = (50 + 100*(i%gridWidth));
      float ypos = (50 + 100*(i/gridWidth));
      String letter = String.valueOf((char) ('a'+i));
      vertices.add(new Vertex( xpos, ypos, vertexSize, letter));
    }
  }
  
  void circleGraph(int numVertices, float radius){
    for(int i = 0; i < numVertices; i++){
      float xpos = width/2 + sin((TWO_PI/numVertices)*i)*radius;
      float ypos = height/2 - cos((TWO_PI/numVertices)*i)*radius;
      String letter = String.valueOf((char) ('a'+i));
      vertices.add(new Vertex( xpos, ypos, vertexSize, letter));
    }
  }
  
  void starryGraph(){
    vertices.add(new Vertex(width/2, height/2, vertexSize, "a"));
    for(int i = 0; i < 10; i++){
      float xpos = (width/2 + sin(TWO_PI/5*i)*(1+i/5)*150);
      float ypos = (height/2 - cos(TWO_PI/5*i)*(1+i/5)*150);
      String letter = String.valueOf((char) ('a'+i+1));
      vertices.add(new Vertex( xpos, ypos, vertexSize, letter));
    }
    edges.add(new Edge(0, 1, vertices));
    edges.add(new Edge(0, 2, vertices));
    edges.add(new Edge(0, 3, vertices));
    edges.add(new Edge(0, 4, vertices));
    edges.add(new Edge(0, 5, vertices));
    edges.add(new Edge(1, 7, vertices));
    edges.add(new Edge(1, 10, vertices));
    edges.add(new Edge(2, 8, vertices));
    edges.add(new Edge(2, 6, vertices));
    edges.add(new Edge(3, 9, vertices));
    edges.add(new Edge(3, 7, vertices));
    edges.add(new Edge(4, 10, vertices));
    edges.add(new Edge(4, 8, vertices));
    edges.add(new Edge(5, 6, vertices));
    edges.add(new Edge(5, 9, vertices));
    edges.add(new Edge(6, 7, vertices));
    edges.add(new Edge(7, 8, vertices));
    edges.add(new Edge(8, 9, vertices));
    edges.add(new Edge(9, 10, vertices));
    edges.add(new Edge(10, 6, vertices));
  }
  
}