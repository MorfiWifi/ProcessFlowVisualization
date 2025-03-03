namespace Graph;

public class Node(int id, string name)
{
    public int Id { get; set; } = id;
    public string Name { get; set; } = name;
    
    public List<Edge> Edges { get; set; } = [];
}

public class Edge(int fromNodeId, int toNodeId, int delay, int bandwidth)
{
    public int FromNodeId { get; set; } = fromNodeId;
    public int ToNodeId { get; set; } = toNodeId;
    public int Delay { get; set; } = delay;
    public int Bandwidth { get; set; } = bandwidth;
}

public class Graph
{
    public Dictionary<int, Node> Nodes = [];

    public void AddNode(Node node)
    {
        Nodes[node.Id] = node;
    }

    public void AddEdge(int fromNodeId, int toNodeId, int delay, int bandwidth)
    {
        if (Nodes.TryGetValue(fromNodeId, out var value) && Nodes.ContainsKey(toNodeId))
        {
            value.Edges.Add(new Edge(fromNodeId , toNodeId , delay , bandwidth));
        }
    }
    
    
}