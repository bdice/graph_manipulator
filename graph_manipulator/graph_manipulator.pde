import java.util.ArrayList;

/*

Graph manipulation tool written for Processing 3.0 by Bradley Dice (@Bradley_Dice).
Right-click on a vertex to select it, then left-click on another vertex to draw an edge.
If an edge already exists, try drawing it again to erase it.
Left-click and drag a vertex to move it.
Press space to switch between the graph G and its complement G^c.
 
*/

Graph g;

void setup()
{
  size(640, 360);
  fill(255, 204);
  noStroke();
  ArrayList<Vertex> vertices = new ArrayList<Vertex>();
  ArrayList<Edge> edges = new ArrayList<Edge>();
  vertices.add(new Vertex( 50,  50, 10, "a"));
  vertices.add(new Vertex(150,  50, 10, "b"));
  vertices.add(new Vertex(250,  50, 10, "c"));
  vertices.add(new Vertex( 50, 150, 10, "d"));
  vertices.add(new Vertex(150, 150, 10, "e"));
  vertices.add(new Vertex(250, 150, 10, "f"));
  g = new Graph(vertices, edges);
}

void draw()
{
  background(0);
  fill(255);
  g.draw();
}

void mousePressed() {
  if(mouseButton == LEFT){
    if(g.hasSelected()){
      ArrayList<Vertex> selectedVertices = g.selectedVertices();
      Vertex v = g.findVertex(mouseX, mouseY);
      if(v != null){
        for(Vertex u : selectedVertices){
          g.switchEdge(new Edge(u, v));
        }
      }
      g.deselectVertices();
    }
  }else if(mouseButton == RIGHT){
    Vertex v = g.findVertex(mouseX, mouseY);
    if(v != null){
      v.select();
    }
  }
}

void mouseDragged(){
  if(mouseButton == LEFT){
    Vertex v = g.findVertex(mouseX, mouseY);
    if(v != null){
      v.move(mouseX, mouseY);
    }
  }
}

void keyPressed(){
  if(key == ' '){
    g.complement();
  }
}