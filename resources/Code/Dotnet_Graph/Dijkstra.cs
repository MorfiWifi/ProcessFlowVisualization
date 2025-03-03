namespace Graph;

public static class Dijkstra
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
                if (alt >= distances[edge.ToNodeId]) continue;
                distances[edge.ToNodeId] = alt;
                previous[edge.ToNodeId] = smallest.Id;
            }
        }

        return (int.MaxValue, []);
    }
}