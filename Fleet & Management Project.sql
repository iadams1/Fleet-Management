/*
	Fleet and Maintenance Management Database System Project
    Database Design & Implementation COMS-3233-H01
    
    Start Date: 4/6/2025
	  Deadline: 4/29/2025
    
    Written by:
    Isaiah Adams
*/

/* ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
																						                     ARCHIVE DATABASE TABLE CREATIONS                                                                                                            
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
create database Fleet_Archives;
use Fleet_Archives;

# Branch Management Table
create table Branch (
	BranchID 					int primary key not null,
    BranchName 					varchar(250) not null,
    Location 					varchar(250) not null,
    BranchCellNumber			varchar(50) not null,
    BranchEmail					varchar(50) not null,
    DateArchived				datetime
);

# Manager Records Table
create table Manager (
	ManagerID 					int primary key not null,
    FName 						varchar(25) not null,
    LName 						varchar(25) not null,
    ManagerCellNumber			varchar(50) not null,
    ManagerEmail				varchar(50) not null,
    DateArchived				datetime
);

# Branch & Manager Employement Records
create table Employment (
	EmploymentID 				int primary key not null,
    BranchID 					int not null,
    ManagerID 					int not null,
    HireDate					date not null,
    QuitDate					date,
    DateArchived				datetime
);
 
# Vehicle Management Table
create table Vehicles (
	VehicleID 					int primary key not null,
    VehicleType 				varchar(50) not null,
    Model 						varchar(50) not null,
    Make 						varchar(50) not null,
    YearOfManufacture 			year not null,
    PurchaseDate 				date not null,
    PurchasePrice 				double not null, 
    MonthlyLeaseMortgage 		double,
    DateArchived				datetime
);

# Branch's Vehicles Management Records Table
create table BranchVehicles (
	BVMRecordsID 				int primary key not null,
    BranchID 					int not null,
    VehicleID 					int not null,
    DateAssigned				date not null,
    DateWithdrawal				date,
    DateArchived				datetime
);

# Drivers Management Table
create table Drivers (
	DriverID 					int primary key not null,
    FName 						varchar(25) not null,
    LName 						varchar(25) not null, 
    DriverCellNumber			varchar(50) not null,
    DriverEmail					varchar(50) not null,
    LicenseType 				varchar(25) not null,
    DateArchived				datetime
);

# Maintenance Tracking Table
create table Maintenance (
	MaintenanceID 				int primary key not null,
    VehicleID					int not null,
    MaintenanceType 			varchar(25) not null,
    ServiceDate 				date not null,
    ServiceProvider 			varchar(50) not null, 
    Cost 						double not null,
    DateArchived				datetime
);

# Expense Tracking Table
create table Expenses (
	ExpenseID 					int primary key not null,
    BranchID					int,
	VehicleID					int, 
    DriverID					int,
    Category 					varchar(50) not null,
    ExpenseDate 				date not null,
    Amount 						double not null,
    DateArchived				datetime
);


# Usage Tracking Table 
create table UsageTracking (
	UsageID 					int primary key not null,
    DriverID					int not null,
    VehicleID					int not null,
    StartDate 					date not null,
    EndDate 					date not null, 
    Destination 				varchar(50) not null,
    TotalMilesTraveled 			double not null,
    DateArchived				datetime
);

/* ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
																						                          FLEET DATABASE TABLE CREATIONS                                                                                                            
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
create database FleetMasters;
use FleetMasters;

# Branch Management Table
create table Branch (
	BranchID 					int primary key not null auto_increment,
    BranchName 					varchar(250) not null,
    Location 					varchar(250) not null,
    BranchCellNumber			varchar(50) not null,
    BranchEmail					varchar(50) not null
);

# Manager Records Table
create table Manager (
	ManagerID 					int primary key not null auto_increment,
    FName 						varchar(25) not null,
    LName 						varchar(25) not null,
    ManagerCellNumber 			varchar(50) not null,
    ManagerEmail				varchar(50) not null
);

# Branch & Manager Employement Records
create table Employment (
	EmploymentID 				int primary key not null auto_increment,
    BranchID 					int not null,
    ManagerID 					int not null,
    HireDate					date not null,
    QuitDate					date,
    foreign key (ManagerID) 	references Manager (ManagerID) on delete cascade,
    foreign key (BranchID) 		references Branch (BranchID) on delete cascade
);
 
# Vehicle Management Table
create table Vehicles (
	VehicleID 					int primary key not null auto_increment,
    VehicleType 				varchar(50) not null,
    Model 						varchar(50) not null,
    Make 						varchar(50) not null,
    YearOfManufacture 			year not null,
    PurchaseDate 				date not null,
    PurchasePrice 				double not null, 
    MonthlyLeaseMortgage 		double
);

# Branch's Vehicles Management Records Table
create table BranchVehicles (
	BVMRecordsID 				int primary key not null auto_increment,
    BranchID 					int not null,
    VehicleID 					int not null,
    DateAssigned				date not null,
    DateWithdrawal				date,
    foreign key (BranchID) 		references Branch (BranchID) on delete cascade,
    foreign key (VehicleID) 	references Vehicles (VehicleID) on delete cascade
);

# Drivers Management Table
create table Drivers (
	DriverID 					int primary key not null auto_increment,
    FName 						varchar(25) not null,
    LName 						varchar(25) not null, 
    DriverCellNumber			varchar(50) not null,
    DriverEmail					varchar(50) not null,
    LicenseType 				varchar(25) not null
);

# Maintenance Tracking Table
create table Maintenance (
	MaintenanceID 				int primary key not null auto_increment,
    VehicleID					int not null,
    MaintenanceType 			varchar(25) not null,
    ServiceDate 				date not null,
    ServiceProvider 			varchar(50) not null, 
    Cost 						double not null,
    foreign key (VehicleID) 	references Vehicles (VehicleID) on delete cascade
);

# Expense Tracking Table
create table Expenses (
	ExpenseID 					int primary key not null auto_increment,
    BranchID					int,
    VehicleID					int,
    DriverID					int,
    Category 					varchar(50) not null,
    ExpenseDate 				date not null,
    Amount 						double not null,
    foreign key (BranchID) 		references Branch (BranchID) on delete cascade,
    foreign key (VehicleID) 	references Vehicles (VehicleID) on delete cascade,
    foreign key (DriverID) 		references Drivers (DriverID) on delete cascade
);

# Usage Tracking Table 
create table UsageTracking (
	UsageID 					int primary key not null auto_increment,
    DriverID					int not null,
    VehicleID					int not null,
    StartDate 					date not null,
    EndDate 					date not null, 
    Destination 				varchar(50) not null,
    TotalMilesTraveled 			double not null,
    foreign key (DriverID) 		references Drivers (DriverID) on delete cascade,
    foreign key (VehicleID) 	references Vehicles (VehicleID) on delete cascade
);

/* ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
																						                              DATA TRIGGERS                                                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */

-- Trigger for Deleting a Branch (stores Branch, Employment, Managers, BranchVehicles, Vehicles & Expenses Tables)
delimiter $$
create trigger delete_Branch before delete on FleetMasters.Branch
for each row begin
	insert ignore into Fleet_Archives.Branch (BranchID, BranchName, Location, BranchCellNumber, BranchEmail, DateArchived) 
    values (old.BranchID, old.BranchName, old.Location, old.BranchCellNumber, old.BranchEmail, now());
    
    -- Inserts employment data related to the deleted branch
	insert ignore into Fleet_Archives.Employment (EmploymentID, BranchID, ManagerID, HireDate, QuitDate)
	select EmploymentID, BranchID, ManagerID, HireDate, QuitDate from FleetMasters.Employment
	where BranchID = old.BranchID;
    
    -- Inserts branch's vehicles related to the deleted branch
    insert ignore into Fleet_Archives.BranchVehicles (BVMRecordsID, BranchID, VehicleID, DateAssigned, DateWithdrawl)
	select BVMRecordsID, BranchID, VehicleID, DateAssigned, DateWithdrawal from FleetMasters.BranchVehicles
	where BranchID = old.BranchID;
    
	-- Inserts expenses related to the deleted branch
    insert ignore into Fleet_Archives.Expenses (ExpenseID, BranchID, Category, ExpenseDate, Amount, DateArchived)
	select ExpenseID, BranchID, Category, ExpenseDate, Amount, now() from FleetMasters.Expenses 
	where BranchID = old.BranchID;
    
end 
$$
delimiter ;

-- Trigger for Deleting a Vehicle (stores Vehicle, BranchVehicles, Expenses, Maintenance & UsageTracking)
delimiter $$
create trigger delete_vehicle before delete on FleetMasters.Vehicles
for each row begin
	insert ignore into Fleet_Archives.Vehicles (VehicleID, VehicleType, Model, Make, YearOfManufacture, PurchaseDate, PurchasePrice, MonthlyLeaseMortgage, DateArchived) 
    values (old.VehicleID, old.VehicleType, old.Model, old.Make, old.YearOfManufacture, old.PurchaseDate, old.PurchasePrice, old.MonthlyLeaseMortgage, now());

	-- Inserts BranchVehicles related to the deleted vehicle
    insert ignore into Fleet_Archives.BranchVehicles (BVMRecordsID, BranchID, VehicleID, DateAssigned, DateWithdrawal)
	select BVMRecordsID, BranchID, VehicleID, DateAssigned, DateWithdrawl from FleetMasters.BranchVehicles
	where VehicleID = old.VehicleID;
    
    -- Inserts Expenses related to the deleted vehicle
    insert ignore into Fleet_Archives.Expenses (ExpenseID, VehicleID, Category, ExpenseDate, Amount, DateArchived)
    select ExpenseID, VehicleID, Category, ExpenseDate, Amount, now() from FleetMasters.Expenses
    where VehicleID = old.VehicleID;
    
    -- Inserts Maintenances related to the deleted vehicle 
    insert ignore into Fleet_Archives.Maintenance (MaintenanceID, VehicleID, MaintenanceType, ServiceDate, ServiceProvider, Cost, DateArchived)
	select MaintenanceID, VehicleID, MaintenanceType, ServiceDate, ServiceProvider, Cost, now() from FleetMasters.Maintenance
    where VehicleID = old.VehicleID;
    
    -- Inserts UsageTracking related to the deleted vehicle
    insert ignore into Fleet_Archives.UsageTracking (UsageID, DriverID, VehicleID, StartDate, EndDate, Destination, TotalMilesTraveled, DateArchived)
    select UsageID, DriverID, VehicleID, StartDate, EndDate, Destination, TotalMilesTraveled, now() from FleetMasters.UsageTracking
    where VehicleID = old.VehicleID;
    
end
$$
delimiter ;

-- Trigger for Deleting a Manager (stores Manager & Employement)
delimiter $$
create trigger delete_Manager before delete on FleetMasters.Manager
for each row begin
	insert ignore into Fleet_Archives.Manager (ManagerID, FName, LName, ManagerCellNumber, ManagerEmail, DateArchived)
	values (old.ManagerID, old.Fname, old.LName, old.ManagerCellNumber, old.ManagerEmail, now());
    
    -- Inserts Employment related to the deleted manager
    insert ignore into Fleet_Archives.Employment (EmploymentID, BranchID, ManagerID, HireDate, QuitDate)
    select EmploymentID, BranchID, ManagerID, HireDate, QuitDate from FleetMasters.Employment
    where ManagerID = old.ManagerID;
    
end
$$
delimiter ;

-- Trigger for Deleting Expenses
delimiter $$
create trigger delete_Expense before delete on FleetMasters.Expenses
for each row begin
	insert ignore into Fleet_Archives.Expenses (ExpenseID, BranchID, VehicleID, DriverID, Category, ExpenseDate, Amount, DateArchived)
    values (old.ExpenseID, old.BranchID, old.VehicleID, old.DriverID, old.Category, old.ExpenseDate, old.Amount, now());
    
end
$$
delimiter ;

-- Trigger for Deleing Drivers (stores UsageTracking)
delimiter $$
create trigger delete_Driver before delete on FleetMasters.Drivers
for each row begin
	insert ignore into Fleet_Archives.Driver (DriverID, FName, LName, DriverCellNumber, DriverEmail, LicenseType, DateArchived)
    values (old.DriverID, old.FName, old.LName, old.DriverCellNumber, old.DriverEmail, old.LicenseType, now());

	-- Inserts UsageTracking related to the deleted driver
    insert ignore into Fleet_Archives.UsageTracking (UsageID, DriverID, VehicleID, StartDate, EndDate, Destination, TotalMilesTraveled, DateArchived)
	select UsageID, DriverID, VehicleID, StartDate, EndDate, Destination, TotalMilesTraveled, now() from FleetMasters.UsageTracking
    where DriverID = old.DriverID;
    
end 
$$
delimiter ;

-- Trigger for Deleting UsageTracking
delimiter $$
create trigger delete_Usage before delete on FleetMasters.UsageTracking
for each row begin
	insert ignore into Fleet_Archives.UsageTracking (UsageID, DriverID, VehicleID, StartDate, EndDate, Destination, TotalMilesTraveled, DateArchived)
    values (old.UsageID, old.DriverID, old.VehicleID, old.StartDate, old.EndDate, old.Destination, old.TotalMilesTraveled, now());

end
$$
delimiter ;

-- Trigger for Deleting Maintenance
delimiter $$
create trigger delete_Maintenance before delete on FleetMasters.Maintenance
for each row begin
	insert ignore into Fleet_Archives.Maintenance (MaintenanceID, VehicleID, MaintenanceType, ServiceDate, ServiceProvider, Cost, DateArchived)
	values (old.MaintenanceID, old.VehicleID, old.MaintenanceType, old.ServiceDate, old.ServiceProvider, old.Cost, now());
end
$$
delimiter ;

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
																										VIEWS & STORED PROCEDURES CREATIONS FOR REPRORTS                                                                                                       
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ */

-- Total Expenses per Vehicle
create view VehiclesTotalExpenses as
	select v.VehicleID, VehicleType, Make, Model, sum(e.Amount) as TotalExpenses from Vehicles v
	left join Expenses e
	on v.VehicleID = e.VehicleID
	group by v.VehicleID;

-- Maintenance History by Vehicle
DELIMITER //
create procedure getVehicleMaintenaceHistory (in ID int) 
begin
	select * from Maintenance
    where VehicleID = ID;
end //
DELIMITER ;

-- Usage by Driver
DELIMITER //
create procedure getUsageByDriver (in ID int)
begin
	select * from UsageTracking 
	where DriverID = ID;
end //
DELIMITER ;

-- Branch-wide Fleet Expenses (includes associated vehicles and drivers expenses)
create view viewBranchWideExpenses as
	select b.BranchID, BranchName, Location, sum(e.Amount) as TotalExpenses from Branch b
	join Expenses e
	on b.BranchID = e.BranchID
	join BranchVehicles bv
	on b.BranchID = bv.BranchID
    join Vehicles v
    on bv.VehicleID = v.VehicleID
    join UsageTracking ut 
    on v.VehicleID = v.VehicleID
	group by b.BranchID;

/* -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
																											POPULATING DATA INTO TABLES                                                                                                        
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
# Populates data for 3 months (includes maintenance, expenses, and usage datails) 
-- ------------------------------------------------------------------------------- 
# Populates Branch Table 
  insert into Branch (BranchName, Location, BranchCellNumber, BranchEmail) values 
	('Fleet Masters North', 'New York, NY', '(212) 555-0198','north.branch@fleetmasters.com'),
	('Fleet Masters South', 'Atlanta, GA', '(404) 555-0845', 'south.branch@fleetmasters.com'),
	('Fleet Masters West', 'Los Angeles, CA', '(310) 555-0222', 'west.branch@fleetmasters.com'),
	('Fleet Masters Central', 'Chicago, IL', '(312) 555-0111', 'central.branch@fleetmasters.com');

# Populates Manager Records Table
  insert into Manager (FName, LName, ManagerCellNumber, ManagerEmail) values
	('Daniel', 'Thompson', '(312) 555-0198', 'daniel.thompson@fleetmasters.com'),
	('Maya', 'Rodriguez', '(404) 555-0845', 'maya.rodriguez@fleetmasters.com'),
	('Brian', 'Nguyen', '(310) 555-0222', 'brian.nguyen@fleetmasters.com'),
	('Alicia', 'Carter', '(212) 555-0111', 'alicia.carter@fleetmasters.com'),
	('Jamal', 'Henderson', '(415) 555-0132', 'jamal.henderson@fleetmasters.com'),
	('Sofia', 'Lopez', '(713) 555-0177', 'sofia.lopez@fleetmasters.com'),
	('Marcus', 'Kim', '(206) 555-0155', 'marcus.kim@fleetmasters.com'),
	('Rachel', 'Green', '(818) 555-0166', 'rachel.green@fleetmasters.com'),
	('Omar', 'Singh', '(617) 555-0188', 'omar.singh@fleetmasters.com'),
	('Lena', 'Foster', '(503) 555-0144', 'lena.foster@fleetmasters.com');


# Populates Employement Records Table
  insert into Employment (BranchID, ManagerID, HireDate, QuitDate) values 
	(1, 1, '2023-01-01', null), -- Daniel → North
    (1, 5, '2023-06-15', null), -- Jamal → North
    (2, 2, '2023-02-01', null), -- Maya → South
    (2, 6, '2023-07-20', null), -- Sofia → South
    (3, 3, '2023-03-10', '2024-08-01'), -- Brian → West, left branch
    (3, 7, '2023-05-15', null), -- Marcus → West
    (3, 8, '2023-09-01', null), -- Rachel → West
    (4, 4, '2023-02-20', null), -- Alicia → Central
    (4, 9, '2023-04-30', null), -- Omar → Central
    (4, 10, '2023-05-10', null); -- Lena → Central

# Populates Vehicles Table
-- Vehicles for Branch 1: Fleet Masters North
  insert into Vehicles (VehicleType, Model, Make, YearOfManufacture, PurchaseDate, PurchasePrice, MonthlyLeaseMortgage) values
	('Truck', 'F-150', 'Ford', 2022, '2023-01-15', 45000, 600),
	('Sedan', 'Camry', 'Toyota', 2021, '2022-11-05', 25000, null),
	('SUV', 'CR-V', 'Honda', 2023, '2023-04-01', 30000, 450),
	('Truck', 'Silverado', 'Chevrolet', 2020, '2021-08-20', 42000, 500),
	('Sedan', 'Altima', 'Nissan', 2019, '2020-06-30', 22000, null),
	('SUV', 'Explorer', 'Ford', 2022, '2023-02-10', 35000, 550);

-- Vehicles for Branch 2: Fleet Masters Sorth
  insert into Vehicles (VehicleType, Model, Make, YearOfManufacture, PurchaseDate, PurchasePrice, MonthlyLeaseMortgage) values
	('Truck', 'Ram 1500', 'Dodge', 2021, '2022-10-12', 44000, 580),
	('Sedan', 'Accord', 'Honda', 2022, '2023-03-08', 27000, 430),
	('SUV', 'Rav4', 'Toyota', 2023, '2023-05-20', 32000, 470),
	('Truck', 'Tundra', 'Toyota', 2020, '2021-09-15', 46000, null),
	('Sedan', 'Malibu', 'Chevrolet', 2019, '2020-03-10', 21000, null),
	('SUV', 'Pilot', 'Honda', 2021, '2022-02-18', 34000, 500);

-- Vehicles for Branch 3: Fleet Masters West
  insert into Vehicles (VehicleType, Model, Make, YearOfManufacture, PurchaseDate, PurchasePrice, MonthlyLeaseMortgage) values
	('SUV', 'Highlander', 'Toyota', 2022, '2022-07-15', 36000, 510),
	('Sedan', 'Model 3', 'Tesla', 2023, '2023-06-22', 48000, 620),
	('Truck', 'Ridgeline', 'Honda', 2021, '2021-11-01', 43000, 570),
	('Truck', 'Maverick', 'Ford', 2022, '2022-08-10', 39000, 550),
	('SUV', 'Escape', 'Ford', 2020, '2021-01-25', 31000, null),
	('Sedan', 'Jetta', 'Volkswagen', 2021, '2021-12-05', 24000, null);
    
-- Vehicles for Branch 4: Fleet Masters Central
  insert into Vehicles (VehicleType, Model, Make, YearOfManufacture, PurchaseDate, PurchasePrice, MonthlyLeaseMortgage) values
	('Truck', 'Cybertruck', 'Tesla', 2023, '2024-01-10', 69000, 850),
	('SUV', 'Pathfinder', 'Nissan', 2022, '2023-04-15', 35000, 500),
	('Sedan', 'Fusion', 'Ford', 2020, '2021-06-12', 23000, null),
	('SUV', 'CX-5', 'Mazda', 2021, '2022-05-01', 33000, 460),
	('Truck', 'Frontier', 'Nissan', 2022, '2023-03-30', 42000, 570),
	('Sedan', 'Elantra', 'Hyundai', 2021, '2022-01-20', 22000, null);

# Populates BranchVehicles Table
-- Branch 1: Fleet Masters North
  insert into BranchVehicles (BranchID, VehicleID, DateAssigned, DateWithdrawal) values
	(1, 1, '2023-01-15', null), 
    (1, 2, '2022-11-05', null), 
    (1, 3, '2023-04-01', null),
    (1, 4, '2023-02-20', null), 
    (1, 5, '2020-06-30', null), 
    (1, 6, '2023-02-10', null);

-- Branch 2: Fleet Masters Sorth
  insert into BranchVehicles (BranchID, VehicleID, DateAssigned, DateWithdrawal) values
	(2, 7, '2022-10-12', null),
    (2, 8, '2023-03-08', null),
    (2, 9, '2023-05-20', null), 
    (2, 10, '2021-09-15', null), 
    (2, 11, '2020-03-10', null), 
    (2, 12, '2022-02-18', null),
    (2, 4, '2022-05-02', '2023-02-18');

-- Branch 3: Fleet Masters West
  insert into BranchVehicles (BranchID, VehicleID, DateAssigned, DateWithdrawal) values
	(3, 13, '2022-07-15', null),
    (3, 14, '2023-06-22', null),
    (3, 15, '2021-11-01', null),
    (3, 16, '2022-08-10', null), 
    (3, 17, '2021-01-25', null),
    (3, 18, '2021-12-05', null),
    (3, 8, '2023-02-10', '2023-03-01');

-- Branch 4: Fleet Masters West
  insert into BranchVehicles (BranchID, VehicleID, DateAssigned, DateWithdrawal) values
	(4, 19, '2024-01-10', null),
    (4, 20, '2023-04-15', null),
    (4, 21, '2021-06-12', null),
    (4, 22, '2022-05-01', null),
    (4, 23, '2023-03-30', null),
    (4, 24, '2022-01-20', null);

  insert into Drivers (FName, LName, DriverCellNumber, DriverEmail, LicenseType) values
	('Jason', 'Miller', '(201) 555-0101', 'jason.miller@fleetmasters.com', 'Class A'),
	('Tina', 'Wells', '(202) 555-0102', 'tina.wells@fleetmasters.com', 'Class B'),
	('Carlos', 'Garcia', '(203) 555-0103', 'carlos.garcia@fleetmasters.com', 'Class C'),
	('Amber', 'Johnson', '(204) 555-0104', 'amber.johnson@fleetmasters.com', 'Class A'),
	('Devon', 'Lee', '(205) 555-0105', 'devon.lee@fleetmasters.com', 'Class C'),
	('Fatima', 'Hassan', '(206) 555-0106', 'fatima.hassan@fleetmasters.com', 'Class B'),
	('Ethan', 'Baker', '(207) 555-0107', 'ethan.baker@fleetmasters.com', 'Class A'),
	('Vanessa', 'Choi', '(208) 555-0108', 'vanessa.choi@fleetmasters.com', 'Class C'),
	('Raj', 'Patel', '(209) 555-0109', 'raj.patel@fleetmasters.com', 'Class B'),
	('Leslie', 'Nguyen', '(210) 555-0110', 'leslie.nguyen@fleetmasters.com', 'Class A'),
	('Marcus', 'Brown', '(211) 555-0111', 'marcus.brown@fleetmasters.com', 'Class B'),
	('Natalie', 'Reed', '(212) 555-0112', 'natalie.reed@fleetmasters.com', 'Class C');


# Populates Maintenance Tracking Table ( 3 months worth of data )
insert into Maintenance (VehicleID, MaintenanceType, ServiceDate, ServiceProvider, Cost) values
(22, 'Brake Inspection', '2025-03-05', 'QuickLube', 306.84),
(9, 'Oil Change', '2025-04-04', 'AutoFix Center', 333.0),
(2, 'Engine Tune-up', '2025-04-27', 'EngineCare', 434.31),
(9, 'Oil Change', '2025-04-25', 'QuickLube', 105.14),
(12, 'Battery Replacement', '2025-04-21', 'MechMasters', 278.21),
(16, 'Brake Inspection', '2025-05-31', 'TirePro', 535.65),
(18, 'Engine Tune-up', '2025-04-09', 'TirePro', 219.95),
(15, 'Oil Change', '2025-05-18', 'MechMasters', 193.66),
(2, 'Battery Replacement', '2025-03-21', 'MechMasters', 520.97),
(10, 'Tire Rotation', '2025-05-05', 'AutoFix Center', 525.8),
(4, 'Battery Replacement', '2025-05-18', 'TirePro', 453.78),
(23, 'Engine Tune-up', '2025-03-01', 'EngineCare', 443.75),
(7, 'Tire Rotation', '2025-05-21', 'TirePro', 234.17),
(24, 'Oil Change', '2025-03-16', 'AutoFix Center', 459.45),
(6, 'Brake Inspection', '2025-04-23', 'EngineCare', 597.52),
(15, 'Oil Change', '2025-05-11', 'AutoFix Center', 327.77),
(22, 'Engine Tune-up', '2025-05-05', 'AutoFix Center', 397.72),
(9, 'Brake Inspection', '2025-03-28', 'EngineCare', 213.3),
(6, 'Brake Inspection', '2025-04-02', 'EngineCare', 440.37),
(2, 'Engine Tune-up', '2025-04-04', 'TirePro', 492.87),
(16, 'Engine Tune-up', '2025-04-19', 'TirePro', 326.58),
(2, 'Battery Replacement', '2025-04-01', 'TirePro', 376.32),
(14, 'Oil Change', '2025-05-15', 'MechMasters', 486.71),
(20, 'Battery Replacement', '2025-04-01', 'MechMasters', 541.17),
(10, 'Engine Tune-up', '2025-05-07', 'MechMasters', 533.62),
(7, 'Brake Inspection', '2025-03-16', 'MechMasters', 544.87),
(3, 'Oil Change', '2025-05-16', 'QuickLube', 136.64),
(17, 'Oil Change', '2025-05-13', 'QuickLube', 568.65),
(15, 'Oil Change', '2025-04-21', 'QuickLube', 193.29),
(10, 'Brake Inspection', '2025-03-16', 'TirePro', 243.39),
(18, 'Tire Rotation', '2025-04-13', 'TirePro', 267.6),
(2, 'Tire Rotation', '2025-05-23', 'TirePro', 504.5),
(2, 'Tire Rotation', '2025-04-26', 'QuickLube', 431.76),
(1, 'Brake Inspection', '2025-04-17', 'AutoFix Center', 288.37),
(12, 'Oil Change', '2025-04-13', 'TirePro', 236.01),
(4, 'Brake Inspection', '2025-05-09', 'QuickLube', 132.69),
(23, 'Tire Rotation', '2025-05-12', 'TirePro', 163.94),
(17, 'Brake Inspection', '2025-03-26', 'MechMasters', 483.83),
(2, 'Brake Inspection', '2025-05-04', 'AutoFix Center', 283.43),
(21, 'Battery Replacement', '2025-05-02', 'AutoFix Center', 128.01),
(10, 'Brake Inspection', '2025-05-04', 'AutoFix Center', 152.63),
(9, 'Oil Change', '2025-04-25', 'QuickLube', 377.8),
(2, 'Oil Change', '2025-05-06', 'QuickLube', 411.18),
(2, 'Tire Rotation', '2025-03-12', 'EngineCare', 307.7),
(11, 'Brake Inspection', '2025-05-12', 'MechMasters', 262.97),
(18, 'Engine Tune-up', '2025-05-10', 'QuickLube', 315.33),
(23, 'Battery Replacement', '2025-04-15', 'EngineCare', 414.3),
(8, 'Oil Change', '2025-03-22', 'TirePro', 282.17),
(18, 'Brake Inspection', '2025-05-20', 'AutoFix Center', 208.03),
(10, 'Oil Change', '2025-03-27', 'AutoFix Center', 115.23);


# Populates Expense Tracking Table for Branchs
insert into Expenses (BranchID, VehicleID, DriverID, Category, ExpenseDate, Amount) values
	(1, null, null, 'Office Rent', '2025-03-23', 2599.92),
	(1, null, null, 'Office Rent', '2025-04-14', 2664.63),
	(1, null, null, 'Office Rent', '2025-05-28', 2665.49),
	(1, null, null, 'Utilities & Internet', '2025-03-01', 332.26),
	(1, null, null, 'Utilities & Internet', '2025-04-27', 380.69),
	(1, null, null, 'Utilities & Internet', '2025-05-08', 371.09),
	(1, null, null, 'Office Supplies', '2025-03-10', 144.7),
	(1, null, null, 'Office Supplies', '2025-04-19', 165.93),
	(1, null, null, 'Office Supplies', '2025-05-23', 110.93),
	(1, null, null, 'Cleaning & Maintenance', '2025-03-01', 229.62),
	(1, null, null, 'Cleaning & Maintenance', '2025-04-12', 262.36),
	(1, null, null, 'Cleaning & Maintenance', '2025-05-08', 249.27),
	(1, null, null, 'Security Services', '2025-03-22', 174.32),
	(1, null, null, 'Security Services', '2025-04-13', 230.29),
	(1, null, null, 'Security Services', '2025-05-19', 299.71),
	(1, null, null, 'Marketing & Ads', '2025-03-07', 518.01),
	(1, null, null, 'Marketing & Ads', '2025-04-11', 510.91),
	(1, null, null, 'Marketing & Ads', '2025-05-26', 450.09),
	(1, null, null, 'Property Insurance', '2025-03-13', 595.11),
	(1, null, null, 'Property Insurance', '2025-04-17', 693.21),
	(1, null, null, 'Property Insurance', '2025-05-12', 702.65),
	(2, null, null, 'Office Rent', '2025-03-08', 2436.65),
	(2, null, null, 'Office Rent', '2025-04-15', 2491.61),
	(2, null, null, 'Office Rent', '2025-05-11', 2455.16),
	(2, null, null, 'Utilities & Internet', '2025-03-13', 382.61),
	(2, null, null, 'Utilities & Internet', '2025-04-14', 351.07),
	(2, null, null, 'Utilities & Internet', '2025-05-02', 371.5),
	(2, null, null, 'Office Supplies', '2025-03-14', 125.77),
	(2, null, null, 'Office Supplies', '2025-04-25', 199.92),
	(2, null, null, 'Office Supplies', '2025-05-16', 132.56),
	(2, null, null, 'Cleaning & Maintenance', '2025-03-11', 264.96),
	(2, null, null, 'Cleaning & Maintenance', '2025-04-16', 238.82),
	(2, null, null, 'Cleaning & Maintenance', '2025-05-05', 209.22),
	(2, null, null, 'Security Services', '2025-03-27', 212.95),
	(2, null, null, 'Security Services', '2025-04-09', 165.42),
	(2, null, null, 'Security Services', '2025-05-02', 268.07),
	(2, null, null, 'Marketing & Ads', '2025-03-21', 590.11),
	(2, null, null, 'Marketing & Ads', '2025-04-24', 641.04),
	(2, null, null, 'Marketing & Ads', '2025-05-05', 547.96),
	(2, null, null, 'Property Insurance', '2025-03-11', 515.39),
	(2, null, null, 'Property Insurance', '2025-04-13', 756.82),
	(2, null, null, 'Property Insurance', '2025-05-04', 759.53),
	(3, null, null, 'Office Rent', '2025-03-11', 2705.2),
	(3, null, null, 'Office Rent', '2025-04-08', 2498.84),
	(3, null, null, 'Office Rent', '2025-05-28', 2574.58),
	(3, null, null, 'Utilities & Internet', '2025-03-02', 343.6),
	(3, null, null, 'Utilities & Internet', '2025-04-28', 387.88),
	(3, null, null, 'Utilities & Internet', '2025-05-18', 304.83),
	(3, null, null, 'Office Supplies', '2025-03-09', 175.21),
	(3, null, null, 'Office Supplies', '2025-04-12', 108.64),
	(3, null, null, 'Office Supplies', '2025-05-23', 174.17),
	(3, null, null, 'Cleaning & Maintenance', '2025-03-14', 259.08),
	(3, null, null, 'Cleaning & Maintenance', '2025-04-25', 347.78),
	(3, null, null, 'Cleaning & Maintenance', '2025-05-21', 289.61),
	(3, null, null, 'Security Services', '2025-03-02', 169.54),
	(3, null, null, 'Security Services', '2025-04-15', 246.83),
	(3, null, null, 'Security Services', '2025-05-17', 262.25),
	(3, null, null, 'Marketing & Ads', '2025-03-02', 442.31),
	(3, null, null, 'Marketing & Ads', '2025-04-05', 657.79),
	(3, null, null, 'Marketing & Ads', '2025-05-03', 506.28),
	(3, null, null, 'Property Insurance', '2025-03-21', 543.03),
	(3, null, null, 'Property Insurance', '2025-04-22', 675.25),
	(3, null, null, 'Property Insurance', '2025-05-20', 474.48),
	(4, null, null,'Office Rent','2025-03-17',2726.27),
	(4, null, null,'Office Rent','2025-04-10',2785.14),
	(4, null, null,'Office Rent','2025-05-12',2716.43),
	(4, null, null,'Utilities & Internet','2025-03-17',348.16),
	(4, null, null,'Utilities & Internet','2025-04-15',349.97),
	(4, null, null,'Utilities & Internet','2025-05-21',296.90),
	(4, null, null,'Office Supplies','2025-03-25',199.91),
	(4, null, null,'Office Supplies','2025-04-11',190.07),
	(4, null, null,'Office Supplies','2025-05-13',105.78),
	(4, null, null,'Cleaning & Maintenance','2025-03-12',263.34),
	(4, null, null,'Cleaning & Maintenance','2025-04-22',284.99),
	(4, null, null,'Cleaning & Maintenance','2025-05-25',268.28),
	(4, null, null,'Security Services','2025-03-26',296.69),
	(4, null, null,'Security Services','2025-04-20',251.01),
	(4, null, null,'Security Services','2025-05-25',153.62),
	(4, null, null,'Marketing & Ads','2025-03-26',629.10),
	(4, null, null,'Marketing & Ads','2025-04-01',506.43),
	(4, null, null,'Marketing & Ads','2025-05-02',486.52),
	(4, null, null,'Property Insurance','2025-03-14',796.42),
	(4, null, null,'Property Insurance','2025-04-26',738.20),
	(4, null, null,'Property Insurance','2025-05-13',468.65);
    
# Populates Expense Tracking Table for Vehicles
insert into Expenses (BranchID, VehicleID, DriverID, Category, ExpenseDate, Amount) values
	(null, 1, null, 'Car Wash & Detailing', '2025-03-22', 24.34),
	(null, 1, null, 'Car Wash & Detailing', '2025-04-14', 41.19),
	(null, 1, null, 'Car Wash & Detailing', '2025-05-24', 68.39),
	(null, 1, null, 'Labor', '2025-03-11', 498.43),
	(null, 1, null, 'Labor', '2025-04-16', 189.45),
	(null, 1, null, 'Labor', '2025-05-18', 183.45),
	(null, 1, null, 'Insurance', '2025-03-21', 680.38),
	(null, 1, null, 'Insurance', '2025-04-11', 888.89),
	(null, 1, null, 'Insurance', '2025-05-11', 923.34),
	(null, 1, null, 'Parts', '2025-03-21', 152.62),
	(null, 1, null, 'Parts', '2025-04-25', 214.17),
	(null, 1, null, 'Parts', '2025-05-28', 297.87),
	(null, 2, null, 'Labor', '2025-03-19', 298.86),
	(null, 2, null, 'Labor', '2025-04-16', 153.67),
	(null, 2, null, 'Labor', '2025-05-15', 395.77),
	(null, 2, null, 'Insurance', '2025-03-24', 719.82),
	(null, 2, null, 'Insurance', '2025-04-18', 826.0),
	(null, 2, null, 'Insurance', '2025-05-15', 906.04),
	(null, 2, null, 'Car Wash & Detailing', '2025-03-07', 35.21),
	(null, 2, null, 'Car Wash & Detailing', '2025-04-14', 30.56),
	(null, 2, null, 'Car Wash & Detailing', '2025-05-07', 66.55),
	(null, 2, null, 'Registration & Licensing', '2025-03-06', 222.51),
	(null, 2, null, 'Registration & Licensing', '2025-04-12', 272.09),
	(null, 2, null, 'Registration & Licensing', '2025-05-23', 253.89),
	(null, 3, null,  'Car Wash & Detailing', '2025-03-05', 74.05),
	(null, 3, null, 'Car Wash & Detailing', '2025-04-04', 64.64),
	(null, 3, null, 'Car Wash & Detailing', '2025-05-02', 25.44),
	(null, 3, null, 'Labor', '2025-03-13', 421.56),
	(null, 3, null, 'Labor', '2025-04-25', 309.38),
	(null, 3, null, 'Labor', '2025-05-18', 159.75),
	(null, 3, null, 'Insurance', '2025-03-13', 963.14),
	(null, 3, null, 'Insurance', '2025-04-27', 630.55),
	(null, 3, null, 'Insurance', '2025-05-14', 800.82),
	(null, 3, null, 'Tolls', '2025-03-14', 179.67),
	(null, 3, null,'Tolls', '2025-04-12', 108.2),
	(null, 3, null, 'Tolls', '2025-05-15', 194.69),
	(null, 4, null, 'Tolls', '2025-03-22', 242.97),
	(null, 4, null,  'Tolls', '2025-04-09', 155.46),
	(null, 4, null,  'Tolls', '2025-05-26', 131.46),
	(null, 4, null,  'Fuel', '2025-03-13', 285.04),
	(null, 4, null,  'Fuel', '2025-04-11', 179.3),
	(null, 4, null,  'Fuel', '2025-05-04', 210.94),
	(null, 4, null,  'Registration & Licensing', '2025-03-13', 148.12),
	(null, 4, null,  'Registration & Licensing', '2025-04-21', 161.76),
	(null, 4, null,  'Registration & Licensing', '2025-05-21', 223.61),
	(null, 4, null,  'Parking Fees', '2025-03-19', 25.53),
	(null, 4, null,  'Parking Fees', '2025-04-22', 38.71),
	(null, 4, null,  'Parking Fees', '2025-05-06', 20.84),
	(null, 5, null,  'Parts', '2025-03-24', 255.93),
	(null, 5, null,  'Parts', '2025-04-18', 505.47),
	(null, 5, null,  'Parts', '2025-05-14', 395.85),
	(null, 5, null,  'Insurance', '2025-03-19', 665.43),
	(null, 5, null,  'Insurance', '2025-04-15', 817.67),
	(null, 5, null,  'Insurance', '2025-05-01', 961.64),
	(null, 5, null,  'Car Wash & Detailing', '2025-03-15', 60.33),
	(null, 5, null,  'Car Wash & Detailing', '2025-04-09', 28.85),
	(null, 5, null,  'Car Wash & Detailing', '2025-05-04', 26.1),
	(null, 5, null,  'Parking Fees', '2025-03-06', 28.28),
	(null, 5, null,  'Parking Fees', '2025-04-01', 19.16),
	(null, 5, null,  'Parking Fees', '2025-05-15', 48.88),
	(null, 6, null,  'Parking Fees', '2025-03-09', 32.55),
	(null, 6, null,  'Parking Fees', '2025-04-09', 42.14),
	(null, 6, null,  'Parking Fees', '2025-05-21', 45.56),
	(null, 6, null,  'Car Wash & Detailing', '2025-03-04', 67.26),
	(null, 6, null,  'Car Wash & Detailing', '2025-04-02', 36.05),
	(null, 6, null,  'Car Wash & Detailing', '2025-05-27', 29.75),
	(null, 6, null,  'Labor', '2025-03-20', 178.73),
	(null, 6, null,  'Labor', '2025-04-14', 453.18),
	(null, 6, null,  'Labor', '2025-05-10', 383.99),
	(null, 6, null,  'Tolls', '2025-03-14', 170.54),
	(null, 6, null,  'Tolls', '2025-04-26', 195.66),
	(null, 6, null,  'Tolls', '2025-05-15', 219.19),
	(null, 7, null,  'Car Wash & Detailing', '2025-03-01', 21.36),
	(null, 7, null,  'Car Wash & Detailing', '2025-04-03', 45.73),
	(null, 7, null,  'Car Wash & Detailing', '2025-05-16', 25.84),
	(null, 7, null,  'Tolls', '2025-03-02', 76.64),
	(null, 7, null,  'Tolls', '2025-04-14', 199.9),
	(null, 7, null,  'Tolls', '2025-05-27', 105.38),
	(null, 7, null,  'Parking Fees', '2025-03-21', 28.79),
	(null, 7, null,  'Parking Fees', '2025-04-11', 18.81),
	(null, 7, null,  'Parking Fees', '2025-05-24', 30.63),
	(null, 7, null,  'Registration & Licensing', '2025-03-09', 243.19),
	(null, 7, null,  'Registration & Licensing', '2025-04-22', 130.27),
	(null, 7, null,  'Registration & Licensing', '2025-05-02', 287.44),
	(null, 8, null,  'Tolls', '2025-03-26', 220.41),
	(null, 8, null,  'Tolls', '2025-04-13', 216.28),
	(null, 8, null,  'Tolls', '2025-05-12', 115.12),
	(null, 8, null,  'Fuel', '2025-03-27', 235.1),
	(null, 8, null,  'Fuel', '2025-04-04', 148.69),
	(null, 8, null,  'Fuel', '2025-05-15', 84.31),
	(null, 8, null,  'Labor', '2025-03-16', 466.62),
	(null, 8, null,  'Labor', '2025-04-14', 267.31),
	(null, 8, null,  'Labor', '2025-05-02', 256.17),
	(null, 8, null,  'Parking Fees', '2025-03-17', 41.72),
	(null, 8, null,  'Parking Fees', '2025-04-10', 36.16),
	(null, 8, null,  'Parking Fees', '2025-05-03', 46.27),
	(null, 9, null,  'Tolls', '2025-03-21', 83.84),
	(null, 9, null,  'Tolls', '2025-04-12', 202.55),
	(null, 9, null,  'Tolls', '2025-05-23', 67.61),
	(null, 9, null,  'Labor', '2025-03-04', 140.5),
	(null, 9, null,  'Labor', '2025-04-23', 438.01),
	(null, 9, null,  'Labor', '2025-05-22', 366.14),
	(null, 9, null,  'Fuel', '2025-03-11', 248.64),
	(null, 9, null,  'Fuel', '2025-04-16', 272.13),
	(null, 9, null,  'Fuel', '2025-05-10', 222.31),
	(null, 9, null,  'Parts', '2025-03-16', 454.86),
	(null, 9, null,  'Parts', '2025-04-05', 253.23),
	(null, 9, null,  'Parts', '2025-05-21', 376.57),
	(null, 10, null,  'Registration & Licensing', '2025-03-18', 129.62),
	(null, 10, null,  'Registration & Licensing', '2025-04-22', 225.87),
	(null, 10, null,  'Registration & Licensing', '2025-05-01', 277.26),
	(null, 10, null,  'Car Wash & Detailing', '2025-03-27', 47.73),
	(null, 10, null,  'Car Wash & Detailing', '2025-04-05', 72.66),
	(null, 10, null,  'Car Wash & Detailing', '2025-05-14', 34.63),
	(null, 10, null,  'Labor', '2025-03-03', 190.7),
	(null, 10, null,  'Labor', '2025-04-23', 238.51),
	(null, 10, null,  'Labor', '2025-05-21', 146.34),
	(null, 10, null,  'Insurance', '2025-03-28', 542.23),
	(null, 10, null,  'Insurance', '2025-04-20', 574.04),
	(null, 10, null,  'Insurance', '2025-05-15', 567.78),
	(null, 11, null,  'Fuel', '2025-03-16', 116.65),
	(null, 11, null,  'Fuel', '2025-04-21', 199.86),
	(null, 11, null,  'Fuel', '2025-05-25', 191.15),
	(null, 11, null,  'Tolls', '2025-03-03', 157.31),
	(null, 11, null,  'Tolls', '2025-04-15', 199.49),
	(null, 11, null,  'Tolls', '2025-05-02', 128.25),
	(null, 11, null,  'Registration & Licensing', '2025-03-11', 161.45),
	(null, 11, null,  'Registration & Licensing', '2025-04-10', 110.79),
	(null, 11, null,  'Registration & Licensing', '2025-05-13', 205.68),
	(null, 11, null,  'Parts', '2025-03-24', 308.19),
	(null, 11, null,  'Parts', '2025-04-27', 379.73),
	(null, 11, null,  'Parts', '2025-05-24', 213.54),
	(null, 12, null,  'Car Wash & Detailing', '2025-03-04', 72.79),
	(null, 12, null,  'Car Wash & Detailing', '2025-04-27', 62.94),
	(null, 12, null,  'Car Wash & Detailing', '2025-05-16', 34.37),
	(null, 12, null,  'Tolls', '2025-03-23', 110.85),
	(null, 12, null,  'Tolls', '2025-04-26', 229.06),
	(null, 12, null,  'Tolls', '2025-05-15', 195.39),
	(null, 12, null,  'Parking Fees', '2025-03-07', 23.06),
	(null, 12, null,  'Parking Fees', '2025-04-18', 40.56),
	(null, 12, null,  'Parking Fees', '2025-05-01', 35.42),
	(null, 12, null,  'Insurance', '2025-03-02', 509.23),
	(null, 12, null,  'Insurance', '2025-04-05', 981.39),
	(null, 12, null,  'Insurance', '2025-05-04', 560.19),
	(null, 13, null,  'Registration & Licensing', '2025-03-03', 197.01),
	(null, 13, null,  'Registration & Licensing', '2025-04-01', 171.53),
	(null, 13, null,  'Registration & Licensing', '2025-05-18', 248.37),
	(null, 13, null,  'Insurance', '2025-03-02', 802.11),
	(null, 13, null,  'Insurance', '2025-04-24', 840.25),
	(null, 13, null,  'Insurance', '2025-05-03', 940.92),
	(null, 13, null,  'Car Wash & Detailing', '2025-03-09', 43.82),
	(null, 13, null,  'Car Wash & Detailing', '2025-04-17', 34.68),
	(null, 13, null,  'Car Wash & Detailing', '2025-05-18', 73.18),
	(null, 13, null,  'Parts', '2025-03-05', 515.6),
	(null, 13, null,  'Parts', '2025-04-10', 209.05),
	(null, 13, null,  'Parts', '2025-05-23', 166.58),
	(null, 14, null,  'Labor', '2025-03-18', 385.85),
	(null, 14, null,  'Labor', '2025-04-06', 493.99),
	(null, 14, null,  'Labor', '2025-05-19', 295.51),
	(null, 14, null,  'Tolls', '2025-03-23', 132.9),
	(null, 14, null,  'Tolls', '2025-04-02', 65.66),
	(null, 14, null,  'Tolls', '2025-05-27', 86.62),
	(null, 14, null,  'Parking Fees', '2025-03-23', 49.36),
	(null, 14, null,  'Parking Fees', '2025-04-05', 24.46),
	(null, 14, null,  'Parking Fees', '2025-05-06', 16.48),
	(null, 14, null,  'Registration & Licensing', '2025-03-16', 161.49),
	(null, 14, null,  'Registration & Licensing', '2025-04-09', 221.26),
	(null, 14, null,  'Registration & Licensing', '2025-05-13', 175.54),
	(null, 15, null,  'Insurance', '2025-03-01', 609.04),
	(null, 15, null,  'Insurance', '2025-04-21', 986.87),
	(null, 15, null,  'Insurance', '2025-05-01', 559.13),
	(null, 15, null,  'Parts', '2025-03-24', 487.81),
	(null, 15, null,  'Parts', '2025-04-15', 453.84),
	(null, 15, null,  'Parts', '2025-05-14', 430.17),
	(null, 15, null,  'Fuel', '2025-03-16', 148.51),
	(null, 15, null,  'Fuel', '2025-04-08', 81.84),
	(null, 15, null,  'Fuel', '2025-05-06', 211.16),
	(null, 15, null, 'Tolls', '2025-03-01', 200.2),
	(null, 15, null,  'Tolls', '2025-04-21', 164.8),
	(null, 15, null, 'Tolls', '2025-05-16', 65.06),
	(null, 16, null, 'Fuel', '2025-03-24', 191.99),
	(null, 16, null, 'Fuel', '2025-04-02', 190.69),
	(null, 16, null, 'Fuel', '2025-05-23', 150.29),
	(null, 16, null, 'Labor', '2025-03-13', 141.46),
	(null, 16, null, 'Labor', '2025-04-08', 121.44),
	(null, 16, null, 'Labor', '2025-05-27', 112.24),
	(null, 16, null, 'Insurance', '2025-03-26', 637.28),
	(null, 16, null, 'Insurance', '2025-04-20', 900.97),
	(null, 16, null, 'Insurance', '2025-05-13', 631.93),
	(null, 16, null, 'Car Wash & Detailing', '2025-03-11', 47.59),
	(null, 16, null, 'Car Wash & Detailing', '2025-04-02', 34.22),
	(null, 16, null, 'Car Wash & Detailing', '2025-05-04', 72.87),
	(null, 17, null, 'Registration & Licensing', '2025-03-27', 277.43),
	(null, 17, null, 'Registration & Licensing', '2025-04-05', 224.39),
	(null, 17, null, 'Registration & Licensing', '2025-05-23', 122.49),
	(null, 17, null, 'Insurance', '2025-03-07', 712.68),
	(null, 17, null, 'Insurance', '2025-04-12', 737.26),
	(null, 17, null, 'Insurance', '2025-05-14', 547.64),
	(null, 17, null, 'Parts', '2025-03-26', 409.48),
	(null, 17, null, 'Parts', '2025-04-18', 172.74),
	(null, 17, null, 'Parts', '2025-05-24', 169.56),
	(null, 17, null, 'Parking Fees', '2025-03-23', 47.47),
	(null, 17, null, 'Parking Fees', '2025-04-05', 10.88),
	(null, 17, null, 'Parking Fees', '2025-05-11', 19.13),
	(null, 18, null, 'Parking Fees', '2025-03-16', 17.06),
	(null, 18, null, 'Parking Fees', '2025-04-24', 24.3),
	(null, 18, null, 'Parking Fees', '2025-05-24', 22.59),
	(null, 18, null, 'Insurance', '2025-03-01', 572.32),
	(null, 18, null, 'Insurance', '2025-04-26', 976.89),
	(null, 18, null, 'Insurance', '2025-05-13', 810.67),
	(null, 18, null, 'Car Wash & Detailing', '2025-03-10', 76.81),
	(null, 18, null, 'Car Wash & Detailing', '2025-04-03', 34.56),
	(null, 18, null, 'Car Wash & Detailing', '2025-05-08', 60.1),
	(null, 18, null, 'Parts', '2025-03-05', 303.15),
	(null, 18, null, 'Parts', '2025-04-21', 502.02),
	(null, 18, null, 'Parts', '2025-05-27', 422.68),
	(null, 19, null, 'Insurance', '2025-03-05', 561.0),
	(null, 19, null, 'Insurance', '2025-04-20', 595.04),
	(null, 19, null, 'Insurance', '2025-05-19', 758.29),
	(null, 19, null, 'Parts', '2025-03-13', 527.32),
	(null, 19, null, 'Parts', '2025-04-26', 485.41),
	(null, 19, null, 'Parts', '2025-05-02', 424.73),
	(null, 19, null, 'Car Wash & Detailing', '2025-03-27', 68.4),
	(null, 19, null, 'Car Wash & Detailing', '2025-04-15', 55.41),
	(null, 19, null, 'Car Wash & Detailing', '2025-05-18', 55.26),
	(null, 19, null, 'Tolls', '2025-03-22', 246.52),
	(null, 19, null, 'Tolls', '2025-04-14', 64.88),
	(null, 19, null, 'Tolls', '2025-05-20', 148.96),
	(null, 20, null, 'Parking Fees', '2025-03-10', 40.5),
	(null, 20, null, 'Parking Fees', '2025-04-23', 42.9),
	(null, 20, null, 'Parking Fees', '2025-05-27', 49.43),
	(null, 20, null, 'Insurance', '2025-03-08', 830.73),
	(null, 20, null, 'Insurance', '2025-04-23', 890.66),
	(null, 20, null, 'Insurance', '2025-05-24', 719.52),
	(null, 20, null, 'Car Wash & Detailing', '2025-03-14', 52.54),
	(null, 20, null, 'Car Wash & Detailing', '2025-04-14', 56.97),
	(null, 20, null, 'Car Wash & Detailing', '2025-05-27', 48.41),
	(null, 20, null, 'Registration & Licensing', '2025-03-05', 186.68),
	(null, 20, null, 'Registration & Licensing', '2025-04-08', 212.99),
	(null, 20, null, 'Registration & Licensing', '2025-05-23', 297.73),
	(null, 21, null, 'Fuel', '2025-03-04', 205.85),
	(null, 21, null, 'Fuel', '2025-04-02', 223.7),
	(null, 21, null, 'Fuel', '2025-05-03', 112.33),
	(null, 21, null, 'Labor', '2025-03-01', 427.03),
	(null, 21, null, 'Labor', '2025-04-13', 409.87),
	(null, 21, null, 'Labor', '2025-05-02', 262.34),
	(null, 21, null, 'Parts', '2025-03-11', 176.65),
	(null, 21, null, 'Parts', '2025-04-18', 337.88),
	(null, 21, null, 'Parts', '2025-05-19', 482.26),
	(null, 21, null, 'Insurance', '2025-03-06', 867.3),
	(null, 21, null, 'Insurance', '2025-04-05', 512.94),
	(null, 21, null, 'Insurance', '2025-05-15', 512.49),
	(null, 22, null, 'Labor', '2025-03-02', 214.85),
	(null, 22, null, 'Labor', '2025-04-15', 433.72),
	(null, 22, null, 'Labor', '2025-05-27', 467.55),
	(null, 22, null, 'Insurance', '2025-03-07', 938.1),
	(null, 22, null, 'Insurance', '2025-04-04', 945.6),
	(null, 22, null, 'Insurance', '2025-05-02', 878.01),
	(null, 22, null, 'Registration & Licensing', '2025-03-27', 289.76),
	(null, 22, null, 'Registration & Licensing', '2025-04-07', 207.46),
	(null, 22, null, 'Registration & Licensing', '2025-05-05', 180.26),
	(null, 22, null, 'Tolls', '2025-03-03', 86.87),
	(null, 22, null, 'Tolls', '2025-04-10', 100.35),
	(null, 22, null, 'Tolls', '2025-05-27', 142.54),
	(null, 23, null, 'Parts', '2025-03-05', 432.5),
	(null, 23, null, 'Parts', '2025-04-20', 508.4),
	(null, 23, null, 'Parts', '2025-05-03', 439.9),
	(null, 23, null, 'Parking Fees', '2025-03-18', 38.62),
	(null, 23, null, 'Parking Fees', '2025-04-11', 17.66),
	(null, 23, null, 'Parking Fees', '2025-05-28', 10.46),
	(null, 23, null, 'Fuel', '2025-03-28', 215.31),
	(null, 23, null, 'Fuel', '2025-04-14', 200.71),
	(null, 23, null, 'Fuel', '2025-05-05', 239.69),
	(null, 23, null, 'Registration & Licensing', '2025-03-01', 148.72),
	(null, 23, null, 'Registration & Licensing', '2025-04-22', 245.54),
	(null, 23, null, 'Registration & Licensing', '2025-05-23', 188.34),
	(null, 24, null, 'Labor', '2025-03-25', 381.94),
	(null, 24, null, 'Labor', '2025-04-05', 453.71),
	(null, 24, null, 'Labor', '2025-05-02', 448.23),
	(null, 24, null, 'Tolls', '2025-03-21', 107.41),
	(null, 24, null, 'Tolls', '2025-04-14', 234.28),
	(null, 24, null, 'Tolls', '2025-05-18', 178.21),
	(null, 24, null, 'Registration & Licensing', '2025-03-26', 274.58),
	(null, 24, null, 'Registration & Licensing', '2025-04-09', 241.07),
	(null, 24, null, 'Registration & Licensing', '2025-05-27', 298.41),
	(null, 24, null, 'Parts', '2025-03-01', 504.13),
	(null, 24, null, 'Parts', '2025-04-27', 465.3),
	(null, 24, null, 'Parts', '2025-05-12', 150.59);
    
# Populates Expense Tracking Table for Drivers
insert into Expenses (BranchID, VehicleID, DriverID, Category, ExpenseDate, Amount) values
    (null, null, 1, 'Registration & Licensing', '2025-04-05', 348.31),
	(null, null, 1, 'Vehicle Cleaning', '2025-04-15', 39.0),
	(null, null, 1, 'Labor', '2025-04-25', 488.96),
	(null, null, 1, 'Parts', '2025-05-05', 349.46),
	(null, null, 1, 'Vehicle Cleaning', '2025-05-15', 56.57),
	(null, null, 1, 'Tolls', '2025-05-25', 14.06),
	(null, null, 1, 'Fuel', '2025-06-05', 282.93),
	(null, null, 1, 'Meals & Lodging', '2025-06-15', 319.05),
	(null, null, 1, 'Car Wash & Detailing', '2025-06-25', 55.68),
	(null, null, 2, 'Labor', '2025-04-05', 381.09),
	(null, null, 2, 'Insurance', '2025-04-15', 402.37),
	(null, null, 2, 'Maintenance Supplies', '2025-04-25', 95.04),
	(null, null, 2, 'Fuel', '2025-05-05', 230.48),
	(null, null, 2, 'Vehicle Cleaning', '2025-05-15', 109.89),
	(null, null, 2, 'Parts', '2025-05-25', 205.18),
	(null, null, 2, 'Meals & Lodging', '2025-06-05', 437.09),
	(null, null, 2, 'Insurance', '2025-06-15', 666.39),
	(null, null, 2, 'Registration & Licensing', '2025-06-25', 338.75),
	(null, null, 3, 'Meals & Lodging', '2025-04-05', 331.76),
	(null, null, 3, 'Parts', '2025-04-15', 224.41),
	(null, null, 3, 'Car Wash & Detailing', '2025-04-25', 43.73),
	(null, null, 3, 'Vehicle Cleaning', '2025-05-05', 87.43),
	(null, null, 3, 'Fuel', '2025-05-15', 246.74),
	(null, null, 3, 'Insurance', '2025-05-25', 682.15),
	(null, null, 3, 'Registration & Licensing', '2025-06-05', 273.07),
	(null, null, 3, 'Parking Fees', '2025-06-15', 46.19),
	(null, null, 3, 'Parts', '2025-06-25', 236.14),
	(null, null, 4, 'Tolls', '2025-04-05', 55.95),
	(null, null, 4, 'Vehicle Cleaning', '2025-04-15', 89.52),
	(null, null, 4, 'Labor', '2025-04-25', 280.69),
	(null, null, 4, 'Parts', '2025-05-05', 232.23),
	(null, null, 4, 'Insurance', '2025-05-15', 502.78),
	(null, null, 4, 'Tolls', '2025-05-25', 30.67),
	(null, null, 4, 'Meals & Lodging', '2025-06-05', 160.17),
	(null, null, 4, 'Registration & Licensing', '2025-06-15', 231.29),
	(null, null, 4, 'Tolls', '2025-06-25', 66.73),
	(null, null, 5, 'Vehicle Cleaning', '2025-04-05', 70.24),
	(null, null, 5, 'Parking Fees', '2025-04-15', 39.16),
	(null, null, 5, 'Tolls', '2025-04-25', 26.0),
	(null, null, 5, 'Insurance', '2025-05-05', 864.5),
	(null, null, 5, 'Parts', '2025-05-15', 438.25),
	(null, null, 5, 'Parking Fees', '2025-05-25', 10.77),
	(null, null, 5, 'Car Wash & Detailing', '2025-06-05', 45.37),
	(null, null, 5, 'Labor', '2025-06-15', 381.61),
	(null, null, 5, 'Insurance', '2025-06-25', 369.01),
	(null, null, 6, 'Tolls', '2025-04-05', 50.68),
	(null, null, 6, 'Maintenance Supplies', '2025-04-15', 231.02),
	(null, null, 6, 'Car Wash & Detailing', '2025-04-25', 49.1),
	(null, null, 6, 'Tolls', '2025-05-05', 39.21),
	(null, null, 6, 'Insurance', '2025-05-15', 723.91),
	(null, null, 6, 'Parking Fees', '2025-05-25', 23.8),
	(null, null, 6, 'Vehicle Cleaning', '2025-06-05', 65.27),
	(null, null, 6, 'Car Wash & Detailing', '2025-06-15', 24.88),
	(null, null, 6, 'Insurance', '2025-06-25', 335.76),
	(null, null, 7, 'Meals & Lodging', '2025-04-05', 358.21),
	(null, null, 7, 'Fuel', '2025-04-15', 293.34),
	(null, null, 7, 'Parking Fees', '2025-04-25', 42.45),
	(null, null, 7, 'Parts', '2025-05-05', 357.36),
	(null, null, 7, 'Parking Fees', '2025-05-15', 35.47),
	(null, null, 7, 'Insurance', '2025-05-25', 335.81),
	(null, null, 7, 'Registration & Licensing', '2025-06-05', 250.54),
	(null, null, 7, 'Labor', '2025-06-15', 261.51),
	(null, null, 7, 'Insurance', '2025-06-25', 874.42),
	(null, null, 8, 'Parts', '2025-04-05', 319.57),
	(null, null, 8, 'Parking Fees', '2025-04-15', 36.83),
	(null, null, 8, 'Meals & Lodging', '2025-04-25', 206.93),
	(null, null, 8, 'Parts', '2025-05-05', 399.75),
	(null, null, 8, 'Fuel', '2025-05-15', 157.63),
	(null, null, 8, 'Tolls', '2025-05-25', 52.36),
	(null, null, 8, 'Registration & Licensing', '2025-06-05', 213.7),
	(null, null, 8, 'Parking Fees', '2025-06-15', 18.72),
	(null, null, 8, 'Parts', '2025-06-25', 510.17),
	(null, null, 9, 'Registration & Licensing', '2025-04-05', 326.32),
	(null, null, 9, 'Car Wash & Detailing', '2025-04-15', 22.12),
	(null, null, 9, 'Parking Fees', '2025-04-25', 17.86),
	(null, null, 9, 'Meals & Lodging', '2025-05-05', 151.83),
	(null, null, 9, 'Registration & Licensing', '2025-05-15', 205.81),
	(null, null, 9, 'Fuel', '2025-05-25', 223.68),
	(null, null, 9, 'Meals & Lodging', '2025-06-05', 281.64),
	(null, null, 9, 'Parts', '2025-06-15', 328.4),
	(null, null, 9, 'Insurance', '2025-06-25', 367.18),
	(null, null, 10, 'Parking Fees', '2025-04-05', 43.07),
	(null, null, 10, 'Fuel', '2025-04-15', 269.69),
	(null, null, 10, 'Labor', '2025-04-25', 354.82),
	(null, null, 10, 'Maintenance Supplies', '2025-05-05', 292.03),
	(null, null, 10, 'Car Wash & Detailing', '2025-05-15', 69.61),
	(null, null, 10, 'Tolls', '2025-05-25', 98.28),
	(null, null, 10, 'Parking Fees', '2025-06-05', 18.51),
	(null, null, 10, 'Vehicle Cleaning', '2025-06-15', 35.98),
	(null, null, 10, 'Car Wash & Detailing', '2025-06-25', 53.47),
	(null, null, 11, 'Insurance', '2025-04-05', 642.1),
	(null, null, 11, 'Parking Fees', '2025-04-15', 10.87),
	(null, null, 11, 'Labor', '2025-04-25', 257.55),
	(null, null, 11, 'Parts', '2025-05-05', 318.0),
	(null, null, 11, 'Tolls', '2025-05-15', 91.46),
	(null, null, 11, 'Registration & Licensing', '2025-05-25', 157.32),
	(null, null, 11, 'Maintenance Supplies', '2025-06-05', 278.95),
	(null, null, 11, 'Insurance', '2025-06-15', 484.31),
	(null, null, 11, 'Car Wash & Detailing', '2025-06-25', 46.51),
	(null, null, 12, 'Registration & Licensing', '2025-04-05', 294.04),
	(null, null, 12, 'Tolls', '2025-04-15', 40.66),
	(null, null, 12, 'Fuel', '2025-04-25', 249.58),
	(null, null, 12, 'Meals & Lodging', '2025-05-05', 249.61),
	(null, null, 12, 'Tolls', '2025-05-15', 43.63),
	(null, null, 12, 'Parking Fees', '2025-05-25', 7.57),
	(null, null, 12, 'Fuel', '2025-06-05', 291.01),
	(null, null, 12, 'Insurance', '2025-06-15', 658.51),
	(null, null, 12, 'Labor', '2025-06-25', 246.83);
    
# Populates Usage Tracking Table
insert into UsageTracking (DriverID, VehicleID, StartDate, EndDate, Destination, TotalMilesTraveled) values
	(1, 16, '2025-03-05', '2025-03-07', 'Atlanta', 537.09),
	(2, 23, '2025-03-25', '2025-03-28', 'Houston', 786.9),
	(3, 3, '2025-03-04', '2025-03-07', 'Houston', 175.43),
	(4, 20, '2025-04-11', '2025-04-14', 'Miami', 336.1),
	(5, 21, '2025-05-25', '2025-05-28', 'Miami', 326.31),
	(6, 17, '2025-03-21', '2025-03-24', 'Chicago', 386.94),
	(7, 20, '2025-04-05', '2025-04-09', 'Dallas', 137.61),
	(8, 5, '2025-03-10', '2025-03-14', 'Dallas', 790.54),
	(9, 7, '2025-05-06', '2025-05-09', 'Atlanta', 129.31),
	(10, 13, '2025-04-22', '2025-04-25', 'Atlanta', 427.38),
	(11, 17, '2025-04-24', '2025-04-25', 'Dallas', 493.11),
	(12, 7, '2025-03-04', '2025-03-06', 'Denver', 509.94),
	(5, 1, '2025-05-14', '2025-05-15', 'Miami', 499.6),
	(3, 2, '2025-04-16', '2025-04-20', 'Miami', 237.82),
	(1, 3, '2025-04-07', '2025-04-09', 'Los Angeles', 138.34),
	(11, 4, '2025-03-07', '2025-03-10', 'Miami', 719.4),
	(2, 5, '2025-04-23', '2025-04-24', 'Phoenix', 548.92),
	(8, 6, '2025-04-18', '2025-04-22', 'Phoenix', 399.22),
	(7, 7, '2025-05-13', '2025-05-15', 'Miami', 462.01),
	(7, 8, '2025-03-09', '2025-03-10', 'Atlanta', 712.42),
	(5, 9, '2025-03-15', '2025-03-19', 'Chicago', 375.92),
	(5, 10, '2025-05-22', '2025-05-25', 'Seattle', 593.51),
	(3, 11, '2025-04-21', '2025-04-22', 'Seattle', 621.88),
	(2, 12, '2025-04-04', '2025-04-08', 'Miami', 215.88),
	(11, 13, '2025-05-08', '2025-05-09', 'Houston', 365.83),
	(11, 14, '2025-03-10', '2025-03-11', 'Miami', 474.52),
	(6, 15, '2025-03-15', '2025-03-16', 'Houston', 651.14),
	(6, 16, '2025-05-07', '2025-05-08', 'Los Angeles', 728.85),
	(8, 17, '2025-05-22', '2025-05-25', 'Los Angeles', 425.54),
	(2, 18, '2025-04-04', '2025-04-08', 'Denver', 109.01),
	(10, 19, '2025-03-23', '2025-03-24', 'Dallas', 620.29),
	(9, 20, '2025-04-13', '2025-04-14', 'Houston', 683.81),
	(1, 21, '2025-03-10', '2025-03-13', 'Miami', 131.19),
	(1, 22, '2025-03-06', '2025-03-09', 'Dallas', 273.6),
	(11, 23, '2025-04-06', '2025-04-09', 'Miami', 585.61),
	(11, 24, '2025-05-08', '2025-05-12', 'Dallas', 357.87),
	(9, 14, '2025-04-16', '2025-04-17', 'Phoenix', 416.63),
	(10, 16, '2025-05-18', '2025-05-20', 'Houston', 720.09),
	(1, 18, '2025-05-08', '2025-05-09', 'Seattle', 120.08),
	(4, 9, '2025-05-13', '2025-05-15', 'Chicago', 298.34),
	(3, 1, '2025-04-21', '2025-04-23', 'Miami', 368.56),
	(6, 6, '2025-05-19', '2025-05-21', 'Houston', 448.07),
	(2, 15, '2025-05-11', '2025-05-13', 'Seattle', 606.11),
	(2, 2, '2025-05-19', '2025-05-20', 'Chicago', 165.12),
	(6, 18, '2025-05-06', '2025-05-07', 'Miami', 590.36),
	(7, 22, '2025-04-01', '2025-04-05', 'Denver', 593.91),
	(2, 8, '2025-05-08', '2025-05-09', 'Houston', 220.37),
	(11, 6, '2025-05-18', '2025-05-21', 'New York', 392.54),
	(2, 19, '2025-05-06', '2025-05-07', 'Chicago', 625.14),
	(3, 16, '2025-04-10', '2025-04-12', 'Chicago', 141.35),
	(7, 23, '2025-03-22', '2025-03-26', 'New York', 509.88),
	(7, 19, '2025-03-03', '2025-03-06', 'Houston', 496.65),
	(3, 17, '2025-03-19', '2025-03-20', 'Houston', 606.43),
	(5, 14, '2025-03-25', '2025-03-29', 'Denver', 524.38),
	(5, 12, '2025-04-17', '2025-04-18', 'Denver', 744.67),
	(10, 2, '2025-03-04', '2025-03-05', 'Atlanta', 259.44),
	(10, 6, '2025-04-07', '2025-04-09', 'Chicago', 394.06),
	(10, 4, '2025-05-04', '2025-05-06', 'Denver', 451.94),
	(7, 15, '2025-05-09', '2025-05-13', 'Los Angeles', 285.28),
	(6, 23, '2025-05-08', '2025-05-10', 'Chicago', 531.3),
	(10, 1, '2025-04-13', '2025-04-14', 'Seattle', 403.68),
	(1, 9, '2025-05-25', '2025-05-29', 'Phoenix', 184.13),
	(7, 4, '2025-03-05', '2025-03-07', 'Atlanta', 784.56),
	(9, 14, '2025-05-11', '2025-05-14', 'Chicago', 231.56),
	(8, 14, '2025-04-02', '2025-04-03', 'Denver', 708.66),
	(9, 17, '2025-04-11', '2025-04-13', 'Phoenix', 330.47),
	(9, 11, '2025-03-15', '2025-03-16', 'Atlanta', 625.66),
	(3, 1, '2025-05-07', '2025-05-10', 'New York', 141.3),
	(10, 15, '2025-03-07', '2025-03-08', 'Chicago', 773.47),
	(2, 9, '2025-05-14', '2025-05-17', 'Chicago', 408.62),
	(12, 11, '2025-03-24', '2025-03-27', 'New York', 792.53),
	(1, 14, '2025-03-04', '2025-03-07', 'Dallas', 525.73),
	(3, 16, '2025-03-06', '2025-03-07', 'Miami', 607.1),
	(2, 3, '2025-03-04', '2025-03-07', 'Miami', 262.03),
	(3, 11, '2025-04-10', '2025-04-14', 'Houston', 223.83),
	(1, 18, '2025-03-12', '2025-03-13', 'Seattle', 340.78),
	(1, 1, '2025-03-02', '2025-03-05', 'Los Angeles', 465.69),
	(1, 1, '2025-03-31', '2025-04-02', 'Atlanta', 442.46),
	(1, 1, '2025-04-30', '2025-05-03', 'New York', 685.27),
	(4, 1, '2025-03-05', '2025-03-08', 'Los Angeles', 252.23),
	(4, 1, '2025-04-05', '2025-04-08', 'Chicago', 230.16),
	(2, 5, '2025-03-06', '2025-03-09', 'Chicago', 763.89),
	(2, 5, '2025-04-05', '2025-04-08', 'Los Angeles', 772.9),
	(2, 5, '2025-05-05', '2025-05-08', 'Dallas', 585.63),
	(3, 7, '2025-03-04', '2025-03-05', 'Denver', 477.97),
	(3, 7, '2025-04-02', '2025-04-04', 'Atlanta', 263.37),
	(10, 15, '2025-03-04', '2025-03-06', 'New York', 766.35),
	(10, 15, '2025-04-02', '2025-04-04', 'Houston', 161.4),
	(10, 15, '2025-05-02', '2025-05-03', 'Seattle', 695.15);
    