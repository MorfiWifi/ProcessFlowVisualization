0- what is microsoft sqlserver graph table (database) how different from traditional table considering performance and complexity , generate table of where conditions when to use and not use graph table and finally where is microsoft graph table production ready ?
1- Is it possible to convert traditional  table into graph without any extra effort ? or special conidiation should  be taken into account ?
2- doses entity framework and C# support graph table (sql server graph) ? how much dose it make conversion easier ? how different queries are from traditional and graph ? 
3- compare in depth how sql server graph store/restores data , why we see json object s in management studio , how index work in this era , is there views ? give me simple example for each.
4- compare benchmarks on sql server graph and other well known graph databases in terms of performance 
5- assume we have asp.net application using traditional sql server assume we have complicate routes between company sections and goods are transferred throw them and each has it's own delay and cost now should we replace our old design with sql server graph table or considering using graph along side with traditional system ?  
6- assume we have networking grid and we have some node and each edge (line) has bandwidth limitation and minimum delay now design grid using sql server graph table and find best route from Node A to Node Z while we modify edges (disable or remove them) write SQL code + comments
7- -
8- -
9- Summarize and give me Sql server SQL Graph Architecture
10- example What is SHORTEST_PATH  function in Sql server and how to use it ? write example for finding shortest path between two statelets using following table structure 
CREATE TABLE Link (
    EdgeID INT PRIMARY KEY, -- Unique identifier for each edge
    Bandwidth INT NOT NULL, -- Bandwidth limitation of the edge
    Delay INT NOT NULL, -- Minimum delay of the edge
    IsActive BIT NOT NULL DEFAULT 1 -- Indicates if the edge is active (1) or disabled (0)
) AS EDGE; -- Marks this table as an edge table in SQL Server Graph


-- Create Satelite Table
CREATE TABLE Satelite (
    NodeID INT PRIMARY KEY, -- Unique identifier for each node
    NodeName NVARCHAR(50) NOT NULL -- Name of the node (e.g., "Node A")
) AS NODE; -- Marks this table as a node table in SQL Server Graph
