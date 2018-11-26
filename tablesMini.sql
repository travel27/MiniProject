create schema mini

create table mini.AdminLogin
(
AdminUsername varchar(15) unique not null,
AdminPass varchar(20) not null
)
insert into mini.AdminLogin values('admin','admin')
drop table mini.ManagerLogin

create table mini.ManagerLogin
(
ManagerId int unique,
ManagerName varchar(20),
Username varchar(20),
Password varchar(20)
)

 insert into  mini.ManagerLogin values(20001,'John','John','John')
 insert into  mini.ManagerLogin values(20002,'Paul','Paul','Paul')
 insert into  mini.ManagerLogin values(20003,'Priya','Priya','Priya')
 insert into  mini.ManagerLogin values(20004,'Riya','Riya','Riya')


drop table mini.Agentlogin
create table mini.Agentlogin
(
AgentName varchar(15),
AgentUsername varchar(15) not null,
AgentPass varchar(20) not null
)


drop table mini.EmployeeDetails
create table mini.EmployeeDetails(
 EmployeeId int primary key,
 FirstName varchar(20) not null,
 LastName varchar(20) not null,
 Age int not null,
 Gender varchar(10) not null,
 AddressofEmp varchar(50) not null,
 MobileNumber varchar(20) not null unique,
 EmailId varchar(100) not null unique,
username varchar(15) not null unique,
password varchar(20) not null,
managerId int not null
)


select * from mini.EmployeeDetails
select * from mini.TravelRequest

drop table mini.TravelRequest
create table mini.TravelRequest
(
RequestId int identity not null,
RequestDate date not null,
FromLocation varchar(20) not null,
ToLocation varchar(50) not null,
EmployeeId int not null,
ManagerId int not null,
CurrentStatus varchar(150) 
)

select *from mini.TravelRequest

create proc mini.Employeelogin(

@username varchar(20),
@password varchar(20)
)
as
begin 
Select username,password from mini.EmployeeDetails where Username=@Username
end


select *from mini.EmployeeDetails
delete mini.EmployeeDetails where EmployeeId=6

drop table  mini.Managerlogin





drop proc mini.AddTravelAgent
create proc mini.AddTravelAgent
(
@AgentName varchar(15),
@Username varchar(20),
@Password varchar(20)
)
as 
begin
insert into mini.Agentlogin values(@AgentName,@Username,@Password)
end

select * from mini.Agentlogin 

delete from mini.Agentlogin 

drop table mini.TravelRequest


drop proc mini.addEmployee

create proc mini.addEmployee(
 @EmployeeId int ,
 @FirstName varchar(20),
 @LastName varchar(20),
 @Age int,
 @Gender varchar(10),
 @AddressofEmp varchar(50),
 @MobileNumber varchar(20),
 @EmailId varchar(100),
 @uname varchar(20),
 @password varchar(20),
 @ManagerId int
 )
 as 
 begin
 insert into mini.EmployeeDetails values(@EmployeeId,@FirstName,@LastName,@Age,@Gender,@AddressofEmp,@MobileNumber, @EmailId,@uname,@password,@ManagerId )
 end


 select *from mini.EmployeeDetails



 create proc mini.DeleteEmployee
(
@EmployeeId int
)
as
begin
	delete from  mini.EmployeeDetails
	where EmployeeId = @EmployeeId
end



drop proc mini.AssignManager1


alter procedure mini.AssignManager1
(
@EmployeeId int,
@ManagerId int )
as
begin
 update  mini.EmployeeDetails set ManagerId=@ManagerId where EmployeeId=@EmployeeId
end



alter procedure mini.ManagerDisplay
(
@ManagerId int
)
as
begin
 select * from  mini.TravelRequest where ManagerId=@ManagerId
end


alter procedure mini.DisplayRequestsForAgent

as
begin
 select * from  mini.TravelRequest where CurrentStatus='Manager Approved' or CurrentStatus='Ticket Confirmed' or CurrentStatus='No tickets Avaliable'
end


select *from mini.TravelRequest
select *from mini.EmployeeDetails
select *from mini.ManagerLogin


create procedure mini.DisplayEmpRequest
(
@EmployeeId int
)
as
begin
 select * from  mini.TravelRequest where EmployeeId=@EmployeeId
end


select *from mini.TravelRequest
drop proc mini.bookingRequest

alter procedure mini.bookingRequest(
@RequestId int out,
@requestDate date,
@FromLocation varchar(20),
@ToLocation varchar(20),
@EmployeeId int,
@ManagerId int
)
as
begin
insert into mini.TravelRequest(RequestDate,FromLocation,ToLocation,EmployeeId,ManagerId) values(@requestDate, @FromLocation,@ToLocation,@EmployeeId,@ManagerId)
set  @RequestId=SCOPE_IDENTITY()
end

select *from mini.TravelRequest

use Training_19Sep18_Pune

create procedure mini.updateStatusByManager
(
@CurrentStatus varchar(150),
@EmployeeId int
)
as
begin
 update mini.TravelRequest set CurrentStatus= @CurrentStatus where EmployeeId=@EmployeeId 
end

drop proc mini.updateStatusByTravelAgent

select * from mini.TravelRequest

create procedure mini.updateStatusByTravelAgent
(
@CurrentStatus varchar(150),
@RequestId int
)
as
begin
 update mini.TravelRequest set CurrentStatus= @CurrentStatus where RequestId =@RequestId
end

Alter procedure mini.Cancelrequest
(
@RequestId int
)
as
 begin
  delete from mini.TravelRequest where RequestId=@RequestId
end

drop proc mini.getdetails

create procedure mini.getdetails
(
@username varchar(15),
@password varchar(20),
@EmployeeId int out,
@managerid int out
)
as
begin
	select   @EmployeeId=EmployeeId , @managerid=ManagerId from mini.EmployeeDetails where username=@username and password=@password
end


select *from mini.TravelRequest


select * from mini.EmployeeDetails

alter proc mini.GetManagersBYID
as
begin
	select ManagerId,ManagerName 
	from mini.ManagerLogin
	order by ManagerName
end
drop proc mini.GetManagers

create procedure mini.GetManagers
(
@username varchar(15),
@password varchar(20),
@Managername varchar(20)  out,
@managerid int out
)
as
begin
	select   @managerid=ManagerId , @Managername=ManagerName from mini.ManagerLogin where Username=@username and Password=@password
end