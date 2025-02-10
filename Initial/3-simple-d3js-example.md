To simulate a simple power plant electricity grid with D3.js, including line voltage and switch status (Open/Close), we can use D3.js to visualize the grid, where the nodes represent power plants and grid lines, and the edges between nodes represent the transmission lines. The line voltage can be represented by the thickness or color of the edges, and the switch status (Open/Close) can be shown using labels or icons.

Below is a basic example of how to set up such a visualization using D3.js:

### HTML + D3.js Example

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Power Grid Simulation</title>
  <script src="https://d3js.org/d3.v7.min.js"></script>
  <style>
    .node {
      fill: steelblue;
      stroke: #fff;
      stroke-width: 1.5px;
    }

    .link {
      stroke: #999;
      stroke-width: 2px;
    }

    .open {
      stroke: red;
      stroke-width: 3px;
    }

    .close {
      stroke: green;
      stroke-width: 3px;
    }

    .label {
      font-size: 12px;
      font-family: Arial, sans-serif;
      fill: black;
      pointer-events: none;
    }

    .voltage-label {
      font-size: 10px;
      fill: gray;
    }
  </style>
</head>
<body>

<svg width="800" height="600"></svg>

<script>
  // Define the data for the grid
  const nodes = [
    { id: 1, name: "Plant A", voltage: 220, x: 100, y: 100 },
    { id: 2, name: "Plant B", voltage: 210, x: 400, y: 150 },
    { id: 3, name: "Plant C", voltage: 230, x: 250, y: 400 }
  ];

  const links = [
    { source: 1, target: 2, status: "close" },
    { source: 2, target: 3, status: "open" },
    { source: 3, target: 1, status: "close" }
  ];

  // Set up SVG container
  const svg = d3.select("svg");

  // Create a simulation for the power grid
  const simulation = d3.forceSimulation(nodes)
    .force("link", d3.forceLink(links).id(d => d.id).distance(200))
    .force("charge", d3.forceManyBody().strength(-1000))
    .force("center", d3.forceCenter(400, 300));

  // Add links (grid lines)
  const link = svg.selectAll(".link")
    .data(links)
    .enter().append("line")
    .attr("class", d => "link " + (d.status === "open" ? "open" : "close"))
    .style("stroke-width", 2);

  // Add nodes (plants)
  const node = svg.selectAll(".node")
    .data(nodes)
    .enter().append("circle")
    .attr("class", "node")
    .attr("r", 20);

  // Add labels for the nodes
  svg.selectAll(".label")
    .data(nodes)
    .enter().append("text")
    .attr("class", "label")
    .attr("x", d => d.x)
    .attr("y", d => d.y - 25)
    .text(d => d.name);

  // Add voltage labels
  svg.selectAll(".voltage-label")
    .data(nodes)
    .enter().append("text")
    .attr("class", "voltage-label")
    .attr("x", d => d.x)
    .attr("y", d => d.y + 25)
    .text(d => `Voltage: ${d.voltage}V`);

  // Update positions based on simulation
  simulation.on("tick", () => {
    link
      .attr("x1", d => d.source.x)
      .attr("y1", d => d.source.y)
      .attr("x2", d => d.target.x)
      .attr("y2", d => d.target.y);

    node
      .attr("cx", d => d.x)
      .attr("cy", d => d.y);

    svg.selectAll(".label")
      .attr("x", d => d.x)
      .attr("y", d => d.y - 25);

    svg.selectAll(".voltage-label")
      .attr("x", d => d.x)
      .attr("y", d => d.y + 25);
  });
</script>

</body>
</html>
```

![reult image of simple grid](/resources/D3JS/images/sample-3.png)

### Breakdown:

1. **Nodes**: Represent power plants. Each node has an `id`, `name`, `voltage`, and `position` (`x`, `y`).
2. **Links**: Represent the electricity transmission lines between plants. Each link has a `source`, `target`, and `status` (either `open` or `close`).
3. **D3 Simulation**: A force-directed layout is used to simulate the grid's behavior, where nodes are attracted or repelled, and links (lines) are created between them.
4. **Line Voltage**: Voltage is displayed near each node (plant), and the color or thickness of the edges can be adjusted to represent the state of the power grid.
5. **Switch Status**: The transmission lines have different colors (`red` for open and `green` for closed) to show the switch status of the power grid.

### Customizations:
- You can change the voltage values dynamically or adjust them based on different conditions.
- Switch status (Open/Close) is reflected by changing the stroke color of the lines connecting nodes.

This visualization gives a basic overview of a power plant grid system, showing how nodes are interconnected, their voltage levels, and the status of transmission lines.