create database 0405993209_blank;

set GLOBAL WorldSize = 100
;#if acces is denied I'll make a function to fetch this value

create table worldReference
(
    WR_name varchar(10) primary key,
	WR_BaseFloorId int#world is (WR_id-1)*worldSize+1<-base floor, up to WR_id*worldSize  examples 1-100, 101-200, 201-300, 301-400....701-801...8658701-8658800
);

create table FloorType
(
	FT_id int primary key auto_increment,
    FT_naturalDiffence int not null,
    FT_terrain varchar(30) not null
);

create table Resorces
(
	Re_id int primary key auto_increment,
    #label varchar(20),
    Re_folderFile varchar(20) not null #class containing functions and objects and other ingame values.
);
    
insert into FloorType(FT_naturalDiffence,FT_terrain)
values
(9999,'The town of Thi');

create table Flour#not global. worlds are based of increments of x(size of the world) so i%x = 1 is the base floor
(
	Fl_id int primary key auto_increment,
    Fl_habitat int not null,
    Fl_hidden tinyint default 0,
    Fl_reference int REFERENCES Flour(Fl_id)
);

create table Item#global
(
	It_id int primary key auto_increment,
	It_name varchar(40) not null,
    It_discription varchar(255) not null,
    It_consumable tinyint not null, #one use? (like a potion)
    It_effect int REFERENCES Resorces(Re_id)
);
create table Species#global
(
	Sp_name varchar(40) primary key,#name of race
    Sp_traps tinyint not null,#do they lay traps? (boolean)
    Sp_multipy int not null,#how much is this race population multiplyed
    Sp_CR int not null,#chalenge rating
    Sp_avgStats json not null,
    Sp_resorce int not null references Resorces(Re_id),
    Sp_spread int not null#how "likely" are they to go on the move, for example elementals spread: 0 they travel a lot
);
create table Habit
(
	species varchar(40) not null references Species(Sp_name),
	terrain varchar(30) not null references FloorType(FT_terrain)
);

/*create table Drops#global
(
	Dr_item int,
    Dr_species varchar(40),
    FOREIGN KEY (Dr_item) REFERENCES Item(It_id),
    FOREIGN KEY (Dr_species) REFERENCES Species(Sp_name)
);*/

/*
-a unit has Stats
-a unit belongs to species
*/
create table Unit#not global
(
	Un_species varchar(40) not null,
    Un_sub int default null references Resorces(Re_id),
    Un_stats json not null,
    Un_location int not null,
    FOREIGN KEY (Un_species) REFERENCES Species(Sp_name),
    FOREIGN KEY (Un_location) REFERENCES Flour(Fl_id)
);




/*
rules to floor reference:
-there might be some criteria for the reference to/from some floors 
	-no floor can reference lavapit
-floors can be hidden but there must be some criteria to that
	-hidden paths can't be too deep(3-5)

plot parts
-at specific depths there are predetermined plot points
-plot rooms can not be blocked
    
other generation rules:
-for every lock there must be a key that is access
-the chanses of a key being in a hidden room is very low
-can't branch wider then 5

*/

drop procedure if exists GenerateWorld;#where the magic happens
DELIMITER ☺
CREATE PROCEDURE GenerateWorld( in WorldName varchar(10))
BEGIN
	insert into Flour(Fl_naturalDiffence) values(500);#base world
    WHILE (select Fl_id from Flour)%WorldSize!=0 DO#100 floors is the size of the world
    SET v1 = v1 - 1;
  END WHILE;
END ☺
DELIMITER ;
call GenerateWorld('world 1');

drop procedure if exists YearsGoBy;#where the magic happens
DELIMITER ☺
CREATE PROCEDURE YearsGoBy( in years varchar(10), in World varchar(10))
BEGIN
	set @i = 0;
    
	WHILE @i<years DO#100 floors is the size of the world
    #function?
		set @i=@i+1;
	END WHILE;
END ☺
DELIMITER ;
call GenerateWorld('world 1');
/*
-items can be droped by monster specie(s)
-items effect 1 or more pc stat

-likely that I'll but this into the code localy so that items can be objects with functions
*/