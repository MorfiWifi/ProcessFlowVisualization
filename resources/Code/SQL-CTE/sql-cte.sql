create table Link(
	EdgeId int primary key ,
	Bandwidth int not null ,
	Delay int not null ,
	IsActive bit not null default 1 
) as Edge;

create Table Satelite (
	NodeId int primary key ,
	NodeName nvarchar(50) not null
) as Node;

Insert into Satelite (NodeId , NodeName) values
(1 , 'Ero-1'),
(2 , 'Asia-1'),
(3 , 'Ero-2'),
(4 , 'Ws-54'),
(5 , 'DEST');


insert into Link(EdgeId ,$from_id , $to_id , Bandwidth , Delay) Values
-- Ero-1 -> Asia-1
(1 , (select $node_id from Satelite where NodeId = 1) ,
(select $node_id from Satelite where NodeId = 2),
100 , 10),

-- Ero-1 ->  Ero-2
(2 , (select $node_id from Satelite where NodeId = 1) ,
(select $node_id from Satelite where NodeId = 3),
200 , 5),

-- Asia-1 ->  Ws-54
(3 , (select $node_id from Satelite where NodeId = 2) ,
(select $node_id from Satelite where NodeId = 4),
150 , 8),

-- Ero-2 -> Ws-54
(4 , (select $node_id from Satelite where NodeId = 3) ,
(select $node_id from Satelite where NodeId = 4),
300 , 6),

-- Ws-54 -> DEST
(5 , (select $node_id from Satelite where NodeId = 4) ,
(select $node_id from Satelite where NodeId = 5),
250 , 7),

-- Ero-1 -> DEST
(6 , (select $node_id from Satelite where NodeId = 1) ,
(select $node_id from Satelite where NodeId = 5),
20 , 180);


with RecursiveCTE as (
	Select 
		FromNode  = s1.NodeName ,
		ToNode = s2.NodeName ,
		FromNodeId  = s1.$node_id ,
		ToNodeId = s2.$node_id ,
		Delay = l.Delay,
		Bandwidth = l.Bandwidth ,
		Path = CAST(s1.NodeName + '->' + s2.NodeName as varchar(max)),
		TotalDelay = l.Delay,
		MinBandwidth = l.Bandwidth
	From
		Satelite s1
	join
		Link l on s1.$node_id = l.$from_id
	join
		Satelite s2 on l.$to_id = s2.$node_id
	where
		s1.NodeName = 'Ero-1'

	Union ALL

	select 
		r.FromNode,
		s2.NodeName as ToNode,
		FromNodeId  = r.FromNodeId ,
		ToNodeId = s2.$node_id ,
		l.Delay,
		l.Bandwidth,
		Path = Cast(r.Path + '->' + s2.NodeName as varchar(max)) ,
		TotalDelay = r.TotalDelay + l.Delay,
		Minbandwidth = Case when l.Bandwidth < r.Minbandwidth THEN l.Bandwidth else r.MinBandwidth end 
	FROM
		RecursiveCTE r
	join
		Link l on r.ToNodeId = l.$from_id
	join
		Satelite s2 on l.$to_id = s2.$node_id
	where
		r.ToNode <> 'DEST'
)

select * from RecursiveCTE where ToNode = 'DEST' order by TotalDelay asc

--Ero-1	DEST	{"type":"node","schema":"dbo","table":"Satelite","id":0}	{"type":"node","schema":"dbo","table":"Satelite","id":4}	7	250	Ero-1->Ero-2->Ws-54->DEST	18	200
--Ero-1	DEST	{"type":"node","schema":"dbo","table":"Satelite","id":0}	{"type":"node","schema":"dbo","table":"Satelite","id":4}	7	250	Ero-1->Asia-1->Ws-54->DEST	25	100
--Ero-1	DEST	{"type":"node","schema":"dbo","table":"Satelite","id":0}	{"type":"node","schema":"dbo","table":"Satelite","id":4}	180	20	Ero-1->DEST	180	20