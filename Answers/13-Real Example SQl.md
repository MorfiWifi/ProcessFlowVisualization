# SQL Code Description: Shortest Path Calculation in a Satellite Network

This SQL script demonstrates how to calculate the shortest path between nodes in a satellite network using a graph-based approach. The script creates a network of satellites (`Satelite` table) and links (`Link` table) between them, then calculates the shortest path from a starting node to a destination node based on delay and bandwidth constraints.

---

## Table Definitions

### 1. `Link` Table (Edges)
Represents the connections between satellites (nodes) in the network.

| Column      | Data Type | Description                          |
|-------------|-----------|--------------------------------------|
| `EdgeId`    | `int`     | Primary key for the edge.           |
| `Bandwidth` | `int`     | Bandwidth of the link.              |
| `Delay`     | `int`     | Delay of the link.                  |
| `IsActive`  | `bit`     | Indicates if the link is active (1) or inactive (0). Default is `1`. |

### 2. `Satelite` Table (Nodes)
Represents the satellites (nodes) in the network.

| Column      | Data Type | Description                          |
|-------------|-----------|--------------------------------------|
| `NodeId`    | `int`     | Primary key for the node.           |
| `NodeName`  | `nvarchar(50)` | Name of the satellite.          |

---

## Data Insertion

### 1. Insert Satellite Nodes
The following satellites are inserted into the `Satelite` table:

| NodeId | NodeName |
|--------|----------|
| 1      | Ero-1    |
| 2      | Asia-1   |
| 3      | Ero-2    |
| 4      | Ws-54    |
| 5      | DEST     |

### 2. Insert Links Between Satellites
The following links are inserted into the `Link` table:

| EdgeId | From Node | To Node | Bandwidth | Delay |
|--------|-----------|---------|-----------|-------|
| 1      | Ero-1     | Asia-1  | 100       | 10    |
| 2      | Ero-1     | Ero-2   | 200       | 5     |
| 3      | Asia-1    | Ws-54   | 150       | 8     |
| 4      | Ero-2     | Ws-54   | 300       | 6     |
| 5      | Ws-54     | DEST    | 250       | 7     |
| 6      | Ero-1     | DEST    | 20        | 180   |

---

## Shortest Path Calculation

The script calculates the shortest path from `Ero-1` to `DEST` using the following steps:

### 1. Deactivate a Link
The link with `EdgeId = 6` (direct connection from `Ero-1` to `DEST`) is deactivated by setting `IsActive = 0`.

### 2. Query the Shortest Path
The query calculates the shortest path from `Ero-1` to `DEST` based on:
- **Total Delay**: Sum of delays along the path.
- **Bandwidth**: Minimum bandwidth along the path.

#### Query Output (When `EdgeId = 6` is inactive):
| StartNode | Route               | LastNode | TotalDelay | Bandwidth |
|-----------|---------------------|----------|------------|-----------|
| Ero-1     | Asia-1 -> Ws-54 -> DEST | DEST     | 25         | 100       |

### 3. Reactivate the Link
The link with `EdgeId = 6` is reactivated by setting `IsActive = 1`.

### 4. Query the Shortest Path Again
After reactivating the link, the query recalculates the shortest path.

#### Query Output (When `EdgeId = 6` is active):
| StartNode | Route | LastNode | TotalDelay | Bandwidth |
|-----------|-------|----------|------------|-----------|
| Ero-1     | DEST  | DEST     | 180        | 20        |

---

## Key Features

1. **Graph-Based Shortest Path Calculation**:
   - Uses the `SHORTEST_PATH` function to find the optimal path between nodes.
   - Aggregates node names (`STRING_AGG`) and calculates total delay (`SUM`) and minimum bandwidth (`MIN`) along the path.

2. **Dynamic Link Activation**:
   - Demonstrates how activating or deactivating a link affects the shortest path.

3. **Path Visualization**:
   - The `Route` column provides a human-readable representation of the path.

---

## Example Use Case
This script can be used in network optimization scenarios, such as:
- Finding the most efficient route for data transmission in a satellite network.
- Evaluating the impact of link failures on network performance.

---

## Notes
- Ensure the database supports graph-based queries (e.g., SQL Server 2017+).
- Modify the `Satelite` and `Link` tables as needed to fit your specific network topology.

---

## Output Summary

| Link Status (`EdgeId = 6`) | Shortest Path               | Total Delay | Bandwidth |
|----------------------------|-----------------------------|-------------|-----------|
| Inactive                   | Ero-1 -> Asia-1 -> Ws-54 -> DEST | 25          | 100       |
| Active                     | Ero-1 -> DEST               | 180         | 20        |