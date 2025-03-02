-- Satelite instance
Create table Satelite(
	Id int primary key ,
	Name nvarchar(50) not null
) as Node;

-- مسیر بین 
Create table Path(
	Id int primary key,
	Bandwidth int not null,
	Delay int not null,
	IsActive bit not null default 1
) as Edge;

Insert into Satelite (Id , Name) values
(1 , 'Ero-1'),
(2 , 'Asia-1'),
(3 , 'Ero-2'),
(4 , 'Ws-54'),
(5 , 'DEST');


insert into Path(Id ,$from_id , $to_id , Bandwidth , Delay) Values
-- Ero-1 -> Asia-1
(1 , (select $node_id from Satelite where Id = 1) ,
(select $node_id from Satelite where Id = 2),
100 , 10),

-- Ero-1 ->  Ero-2
(2 , (select $node_id from Satelite where Id = 1) ,
(select $node_id from Satelite where Id = 3),
200 , 5),

-- Asia-1 ->  Ws-54
(3 , (select $node_id from Satelite where Id = 2) ,
(select $node_id from Satelite where Id = 4),
150 , 8),

-- Ero-2 -> Ws-54
(4 , (select $node_id from Satelite where Id = 3) ,
(select $node_id from Satelite where Id = 4),
300 , 6),

-- Ws-54 -> DEST
(5 , (select $node_id from Satelite where Id = 4) ,
(select $node_id from Satelite where Id = 5),
250 , 7);



update Set IsActive = 0 where $from_id = (select $node_id From Nodes where Id = 1) and 
$to_id = (select $node_id from Nodes where Id = 3);


update Set IsActive = 1 where $from_id = (select $node_id From Nodes where Id = 1) and 
$to_id = (select $node_id from Nodes where Id = 3);


with BestPath as (
	select 
		s1.Id as StartSateliteId,
		s2.Id as EndSateliteId,
		Cast(s1.Name + ' -> ' + s2.Name as Nvarchar(max)) as Pathage,
		p.Delay as TotalDelay ,
		s2.Id as LastNodeId 
	from Satelite s1 , Path p , Satelite s2 
	where Match(s1-(p)->s2)
		and s1.Name = 'Ero-1'
		and p.IsActive = 1

Union All

	select 
		br.StartNodeId,
		n2.Id as EndNodeId ,
		br.Path + ' -> ' + n2.Name as Pathage ,
		br.TotalDelay + e.delay as TotalDelay ,
		n2.Id as LastNodeId 
	from BestPath br 
		join Satelite n1 On br.LastNodeId = n1.Id 
		join Path p on Match(n1-(e)->n2)
		join Satelite n2 On p.$to_id = n2.$node_id
	while p.IsActive = 1
)

select top 1 
path , 
TotalDelay ,
from BestPath 
where EndNodeId = (select Id from Path where Name = 'DEST')
order by TotalDelay as ASC;




select * from Satelite s1 , Path p , Satelite s2 
where Match(s1-(p)->s2)
and s1.Name = 'Ero-1'
and p.IsActive = 1