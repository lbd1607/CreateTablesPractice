--Problem 1
drop table Owner cascade constraints;
drop table Office cascade constraints;
drop table Home cascade constraints;
drop table Agent cascade constraints;

CREATE TABLE Owner
(   OwnerSSN INTEGER,
    OwnerName VARCHAR(30),
    OwnerSpouseName VARCHAR(30),
    OwnerProfession VARCHAR(30),
    OwnerSpouseProfession VARCHAR(30),
CONSTRAINT PKOwner PRIMARY KEY (OwnerSSN) );

CREATE TABLE Office
(   OfficeID INTEGER,
    OfficeMgrName VARCHAR(20),
    OfficePhone CHAR(10),
    OfficeAddress VARCHAR(30), 
CONSTRAINT PKOffice PRIMARY KEY (OfficeID) );

CREATE TABLE Agent
(   AgentID INTEGER, 
    AgentName VARCHAR(30),
    AgentPhone CHAR(10), 
    OfficeID INTEGER    NOT NULL,
CONSTRAINT PKAgent PRIMARY KEY (AgentID),
CONSTRAINT FKOfficeID FOREIGN KEY (OfficeID) REFERENCES Office );

CREATE TABLE Home
(   HomeID INTEGER,
    HomeStreet VARCHAR(15),
    HomeCity VARCHAR(15),
    HomeState CHAR(2),
    HomeZip INTEGER,
    HomeNoBedrms INTEGER,
    HomeNoBaths INTEGER,
    HomeSqFt INTEGER,
    HomeOwnOccupied CHAR(3),
    HomeCommission DECIMAL(10,2),
    HomeSalesPrice DECIMAL(10,2),
    OwnerSSN INTEGER    NOT NULL,
    AgentID INTEGER     NOT NULL,
CONSTRAINT PKHome PRIMARY KEY (HomeID),
CONSTRAINT FKOwnerSSN FOREIGN KEY (OwnerSSN) REFERENCES Owner,
CONSTRAINT FKAgentID FOREIGN KEY (AgentID) REFERENCES Agent );
    
--Problem 2  
drop table StmtLine cascade constraints;
drop table Statement cascade constraints;

CREATE TABLE Statement
(   StmtNo INTEGER,
    StmtDate DATE,
    StmtAcctNo INTEGER, 
CONSTRAINT PKStatement PRIMARY KEY (StmtNo) );
    
CREATE TABLE StmtLine
(   StmtNo INTEGER,
    LineNo INTEGER,
    LineMerName VARCHAR(20),
    LineAmt DECIMAL(10,2),
    LineTransDate DATE,
CONSTRAINT PKStmtLine PRIMARY KEY (StmtNo, LineNo),
CONSTRAINT FKStmtNo2 FOREIGN KEY (StmtNo) REFERENCES Statement );


--Problem 9  
drop table Employee cascade constraints;
drop table Customer cascade constraints;
drop table CustOrd cascade constraints;
drop table Product cascade constraints;
drop table OrdContains cascade constraints;

CREATE TABLE Customer
(   CustNo INTEGER,
    CustFirstName VARCHAR(10),
    CustLastName VARCHAR(20),
    CustCity VARCHAR(20),
    CustState CHAR(2),
    CustZip INTEGER,
    CustBal DECIMAL(10,2),
CONSTRAINT PKCustomer PRIMARY KEY (CustNo) );

CREATE TABLE Employee
(   EmpNo INTEGER,
    EmpFirstName VARCHAR(10),
    EmpLastName VARCHAR(20),
    EmpPhone CHAR(10),
    EmpEMail VARCHAR(30),
    EmpDeptName VARCHAR(20),
    EmpCommRate DECIMAL(5,4),
CONSTRAINT PKEmployee PRIMARY KEY (EmpNo), 
CONSTRAINT FKSupervisor FOREIGN KEY (EmpSupervisor) REFERENCES Employee );

CREATE TABLE CustOrd
(   OrdNo INTEGER,
    OrdName VARCHAR(30),
    OrdCity VARCHAR(20),
    OrdState CHAR(2),
    OrdZip INTEGER,
    CustNo INTEGER      NOT NULL,
CONSTRAINT PKOrder PRIMARY KEY (OrdNo), 
CONSTRAINT FKCustno FOREIGN KEY (CustNo) REFERENCES Customer,
CONSTRAINT FKEmpNo FOREIGN KEY (EmpNo) REFERENCES Employee );
    
CREATE TABLE Product
(   ProdNo INTEGER,
    ProdName VARCHAR(30),
    ProdQOH INTEGER,
    ProdPrice DECIMAL(10,2),
    ProdNextShipDate DATE, 
CONSTRAINT PKProduct PRIMARY KEY (ProdNo) );
    
CREATE TABLE OrdContains
(   ProdNo INTEGER,
    OrdNo INTEGER,
    Qty INTEGER, 
CONSTRAINT PKContains PRIMARY KEY (ProdNo),
CONSTRAINT FKOrdNo FOREIGN KEY (OrdNo) REFERENCES CustOrd,
CONSTRAINT FKProdNo FOREIGN KEY (ProdNo) REFERENCES Product );
 
 
--Problem 10
drop table visitdetail;
drop table item;
drop table visit;
drop table patient; 
drop table employee;
drop table nurse;
drop table physician;
drop table provider;

 CREATE TABLE Provider
(   ProvNo INTEGER,
    ProvFirstName VARCHAR(10),
    ProvLastName VARCHAR(20),
    ProvPhone CHAR(10),
    ProvSpeciality VARCHAR(30),
CONSTRAINT PKProvider PRIMARY KEY (ProvNo) );

CREATE TABLE Nurse
(   ProvNo INTEGER,
    NursePayGrade VARCHAR(20),
    NurseTitle VARCHAR(20),
CONSTRAINT PKNurse PRIMARY KEY (ProvNo),
CONSTRAINT FKNurse FOREIGN KEY (ProvNo) REFERENCES Provider
    ON DELETE CASCADE );

CREATE TABLE Physician
(   ProvNo INTEGER,
    PhyEMail VARCHAR(30),
    PhyHospital VARCHAR(30),
    PhyCertification VARCHAR(20),
CONSTRAINT PKPhysician PRIMARY KEY (ProvNo),
CONSTRAINT FKPhysician FOREIGN KEY (ProvNo) REFERENCES Provider 
    ON DELETE CASCADE );
    
CREATE TABLE Patient
 (  PatNo INTEGER,
    PatFirstName VARCHAR(10),
    PatLastName VARCHAR(20),
    PatCity VARCHAR(10),
    PatState CHAR(2),
    PatZip INTEGER,
    PatHealthPlan VARCHAR(10),
CONSTRAINT PKPatient PRIMARY KEY (PatNo) );

CREATE TABLE Visit
(   VisitNo INTEGER,
    VisitDate DATE,
    VisitPayMethod VARCHAR(10),
    VisitCharge DECIMAL(10,2),
    PatNo INTEGER      NOT NULL,
    ProvNo INTEGER     NOT NULL,
CONSTRAINT PKVisit PRIMARY KEY (VisitNo),
CONSTRAINT FKPatNo FOREIGN KEY (PatNo) REFERENCES Patient,
CONSTRAINT FKProvNo FOREIGN KEY (ProvNo) REFERENCES Physician );

CREATE TABLE Item
(   ItemNo INTEGER,
    ItemDesc VARCHAR(50),
    Itemtype VARCHAR(30),
    ItemPrice DECIMAL(10,2),
CONSTRAINT PKItem PRIMARY KEY (ItemNo) );

CREATE TABLE VisitDetail
(   VisitNo INTEGER    NOT NULL,
    ItemNo INTEGER     NOT NULL, 
    ProvNo INTEGER, 
    VisitDetailNo INTEGER,
CONSTRAINT PKVisitDetail PRIMARY KEY (VisitNo, ItemNo, ProvNo, VisitDetailNo),
CONSTRAINT FKVisitNo2 FOREIGN KEY (VisitNo) REFERENCES Visit,
CONSTRAINT FKItemNo2 FOREIGN KEY (ItemNo) REFERENCES Item,
CONSTRAINT FKProvNo2 FOREIGN KEY (ProvNo) REFERENCES Nurse );
