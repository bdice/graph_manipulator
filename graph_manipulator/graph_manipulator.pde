import java.util.*;

/*

Graph manipulation tool written for Processing 3.0 by Bradley Dice (@Bradley_Dice).
Right-click on a vertex to select it, then left-click on another vertex to draw an edge.
If an edge already exists, try drawing it again to erase it.
Left-click and drag a vertex to move it.
Press space to switch between the graph G and its complement G^c.
 
*/

Graph g;
float vertexSize = 40;
float labelSize = 30;
float edgeThickness = 3;

void setup()
{
  size(1024, 768);
  noStroke();
  ArrayList<Vertex> vertices = new ArrayList<Vertex>();
  ArrayList<Edge> edges = new ArrayList<Edge>();
  g = new Graph(vertices, edges);
  g.circleGraph(8, 100);
  //g.starryGraph();
}

void draw()
{
  strokeWeight(edgeThickness);
  background(255);
  text("Edges: "+g.getEdgeCount(), 50, 40);
  text("Pi:   "+g.getDegreeSequence(), 50, 80);
  text("Pi*:  "+g.getConjugateSequence(), 50, 120);
  text("Trace: "+g.getTrace(), 50, 160);
  text("Threshold: "+(g.isThreshold()?"Yes":"No"), 50, 200);
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
  }else if(key == 'u'){
    g.updateGraph();
  }else if(key == 'h'){
    g.hamiltonianCycle();
  }else if(key == 'r'){
    g.swapRandomEdge();
  }
}