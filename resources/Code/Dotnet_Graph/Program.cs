using Graph;

var graph = new Graph.Graph();

graph.AddNode(new Node(1 , "Ero-1"));
graph.AddNode(new Node(2 , "Asia-1"));
graph.AddNode(new Node(3 , "Ero-2"));
graph.AddNode(new Node(4 , "Ws-54"));
graph.AddNode(new Node(5 , "DEST"));

graph.AddEdge(1 , 2 , 10 , 100);
graph.AddEdge(1 , 3 , 15 , 200);
graph.AddEdge(2 , 4 , 12 , 150);
graph.AddEdge(3 , 4 , 10 , 300);
graph.AddEdge(4 , 5 , 5  , 100);

var (totalDelay , path) = Dijkstra.FindShortestPath(graph , 1 ,5);

Console.WriteLine($"Total Delay: {totalDelay}");
Console.WriteLine($"Path: {string.Join(" -> " , path)}");

// Total Delay: 27
// Path: Ero-1 -> Asia-1 -> Ws-54 -> DEST
