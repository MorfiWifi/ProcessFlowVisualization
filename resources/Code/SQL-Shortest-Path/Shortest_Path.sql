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


-- using shortest Path Function 

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



update Link set IsActive = 0  where EdgeId = 6;

select StartNode ,Route , LastNode , TotalDelay , Bandwidth  from  (
	select 
		s1.NodeName as StartNode , 
		STRING_AGG(s2.NodeName , '->') within group (GRAPH PATH) as Route,
		LAST_VALUE(s2.NodeName) within group (GRAPH PATH) as LastNode,
		Sum(l.Delay) within group (GRAPH PATH) as TotalDelay, -- total delay
		Min(l.Bandwidth) within group (GRAPH PATH) as Bandwidth -- emmerged bandwidth 
	FROM
		Satelite as s1,
		(select * from Link where IsActive = 1 ) FOR PATH as l  ,
		Satelite FOR PATH as s2
	WHERE MATCH(SHORTEST_PATH(s1(-(l)->s2)+))
	AND s1.NodeName = 'Ero-1'
)AS Q
where Q.LastNode = 'DEST'

-- Ero-1	Asia-1->Ws-54->DEST	DEST	25	100


update Link set IsActive = 1  where EdgeId = 6;

select StartNode ,Route , LastNode , TotalDelay , Bandwidth  from  (
	select 
		s1.NodeName as StartNode , 
		STRING_AGG(s2.NodeName , '->') within group (GRAPH PATH) as Route,
		LAST_VALUE(s2.NodeName) within group (GRAPH PATH) as LastNode,
		Sum(l.Delay) within group (GRAPH PATH) as TotalDelay, -- total delay
		Min(l.Bandwidth) within group (GRAPH PATH) as Bandwidth -- emmerged bandwidth 
	FROM
		Satelite as s1,
		(select * from Link where IsActive = 1 ) FOR PATH as l  ,
		Satelite FOR PATH as s2
	WHERE MATCH(SHORTEST_PATH(s1(-(l)->s2)+))
	AND s1.NodeName = 'Ero-1'
)AS Q
where Q.LastNode = 'DEST'

-- Ero-1	DEST	DEST	180	20