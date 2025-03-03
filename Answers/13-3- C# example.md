To solve the problem of finding the least price (minimum delay) between nodes using Dijkstra's algorithm in C#, we need to model the graph and then apply the algorithm. Below is a C# implementation that reads the nodes and edges from the SQL tables and calculates the minimum delay path from a source node to a destination node.

### Step 1: Define the Graph and Node Classes

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

public class Node
{
    public int Id { get; set; }
    public string Name { get; set; }
    public List<Edge> Edges { get; set; } = new List<Edge>();

    public Node(int id, string name)
    {
        Id = id;
        Name = name;
    }
}

public class Edge
{
    public int FromNodeId { get; set; }
    public int ToNodeId { get; set; }
    public int Delay { get; set; }
    public int Bandwidth { get; set; }

    public Edge(int fromNodeId, int toNodeId, int delay, int bandwidth)
    {
        FromNodeId = fromNodeId;
        ToNodeId = toNodeId;
        Delay = delay;
        Bandwidth = bandwidth;
    }
}

public class Graph
{
    public Dictionary<int, Node> Nodes { get; set; } = new Dictionary<int, Node>();

    public void AddNode(Node node)
    {
        Nodes[node.Id] = node;
    }

    public void AddEdge(int fromNodeId, int toNodeId, int delay, int bandwidth)
    {
        if (Nodes.ContainsKey(fromNodeId) && Nodes.ContainsKey(toNodeId))
        {
            Nodes[fromNodeId].Edges.Add(new Edge(fromNodeId, toNodeId, delay, bandwidth));
        }
    }
}
```

### Step 2: Implement Dijkstra's Algorithm

```csharp
public class Dijkstra
{
    public static (int, List<string>) FindShortestPath(Graph graph, int startNodeId, int endNodeId)
    {
        var distances = new Dictionary<int, int>();
        var previous = new Dictionary<int, int>();
        var nodes = new List<Node>();

        foreach (var node in graph.Nodes.Values)
        {
            if (node.Id == startNodeId)
            {
                distances[node.Id] = 0;
            }
            else
            {
                distances[node.Id] = int.MaxValue;
            }
            nodes.Add(node);
        }

        while (nodes.Count != 0)
        {
            nodes.Sort((x, y) => distances[x.Id] - distances[y.Id]);
            var smallest = nodes[0];
            nodes.Remove(smallest);

            if (smallest.Id == endNodeId)
            {
                var path = new List<string>();
                while (previous.ContainsKey(smallest.Id))
                {
                    path.Add(smallest.Name);
                    smallest = graph.Nodes[previous[smallest.Id]];
                }
                path.Add(graph.Nodes[startNodeId].Name);
                path.Reverse();
                return (distances[endNodeId], path);
            }

            if (distances[smallest.Id] == int.MaxValue)
            {
                break;
            }

            foreach (var edge in smallest.Edges)
            {
                var alt = distances[smallest.Id] + edge.Delay;
                if (alt < distances[edge.ToNodeId])
                {
                    distances[edge.ToNodeId] = alt;
                    previous[edge.ToNodeId] = smallest.Id;
                }
            }
        }

        return (int.MaxValue, new List<string>());
    }
}
```

### Step 3: Main Program to Load Data and Run Dijkstra's Algorithm

```csharp
public class Program
{
    public static void Main()
    {
        var graph = new Graph();

        // Add nodes
        graph.AddNode(new Node(1, "Ero-1"));
        graph.AddNode(new Node(2, "Asia-1"));
        graph.AddNode(new Node(3, "Ero-2"));
        graph.AddNode(new Node(4, "Ws-54"));
        graph.AddNode(new Node(5, "DEST"));

        // Add edges (fromNodeId, toNodeId, delay, bandwidth)
        graph.AddEdge(1, 2, 10, 100);
        graph.AddEdge(1, 3, 15, 200);
        graph.AddEdge(2, 4, 12, 150);
        graph.AddEdge(3, 4, 10, 300);
        graph.AddEdge(4, 5, 5, 100);

        // Find the shortest path from "Ero-1" to "DEST"
        var (totalDelay, path) = Dijkstra.FindShortestPath(graph, 1, 5);

        Console.WriteLine($"Total Delay: {totalDelay}");
        Console.WriteLine($"Path: {string.Join(" -> ", path)}");
    }
}
```

### Explanation:

1. **Graph Construction**: The `Graph` class holds the nodes and edges. Nodes are added with their IDs and names, and edges are added with their source, destination, delay, and bandwidth.

2. **Dijkstra's Algorithm**: The `Dijkstra` class implements the algorithm to find the shortest path based on delay. It uses a priority queue (implemented via sorting) to always expand the least costly node first.

3. **Main Program**: The main program constructs the graph, adds nodes and edges, and then calls Dijkstra's algorithm to find the shortest path from "Ero-1" to "DEST".

### Output:

The program will output the total delay and the path taken to reach from "Ero-1" to "DEST" with the least delay.

```plaintext
Total Delay: 27
Path: Ero-1 -> Asia-1 -> Ws-54 -> DEST
```

This C# code provides a clear and efficient way to calculate the least price (minimum delay) path between nodes using Dijkstra's algorithm.