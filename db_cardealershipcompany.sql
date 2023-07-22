--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Create Table ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- Office table --
CREATE TABLE Office (
  ID NUMBER PRIMARY KEY,
  Office_Name VARCHAR2(100),
  Address VARCHAR2(100),
  Contact_Number VARCHAR2(20),
  Opening_Hours VARCHAR2(50)
);

-- All datas are obligatory.
ALTER TABLE Office MODIFY (Office_Name VARCHAR2(100) NOT NULL);
ALTER TABLE Office MODIFY (Address VARCHAR2(100) NOT NULL);
ALTER TABLE Office MODIFY (Contact_Number VARCHAR2(20) NOT NULL);
ALTER TABLE Office MODIFY (Opening_Hours VARCHAR2(100) NOT NULL);

------------------------------------------------------------------------------------------------------

-- Customer table --
CREATE TABLE Customer (
  ID NUMBER PRIMARY KEY,
  Name VARCHAR2(50),
  Surname VARCHAR2(50),
  Phone VARCHAR2(20),
  Address VARCHAR2(100),
  Occupation VARCHAR2(50),
  Gender VARCHAR2(10)
);

-- Without Gender And Occupation, every data is obligatory.
ALTER TABLE Customer MODIFY (Name VARCHAR2(50) NOT NULL);
ALTER TABLE Customer MODIFY (Surname VARCHAR2(50) NOT NULL);
ALTER TABLE Customer MODIFY (Phone VARCHAR2(20) NOT NULL);
ALTER TABLE Customer MODIFY (Address VARCHAR2(100) NOT NULL);

------------------------------------------------------------------------------------------------------

-- Salesperson table --
CREATE TABLE Salesperson (
  ID NUMBER PRIMARY KEY,
  Name VARCHAR2(50),
  Surname VARCHAR2(50),
  Phone VARCHAR2(20),
  Email VARCHAR2(100),
  Hire_Date DATE,
  Office_ID NUMBER,
  CONSTRAINT fk_salesperson_office FOREIGN KEY (Office_ID) REFERENCES Office(ID)
);

-- Without Hire date, every data is obligatory.
ALTER TABLE Salesperson MODIFY (Name VARCHAR2(50) NOT NULL);
ALTER TABLE Salesperson MODIFY (Surname VARCHAR2(50) NOT NULL);
ALTER TABLE Salesperson MODIFY (Phone VARCHAR2(20) NOT NULL);
ALTER TABLE Salesperson MODIFY (Email VARCHAR2(100) NOT NULL);
ALTER TABLE Salesperson MODIFY (Office_ID NUMBER NOT NULL);

------------------------------------------------------------------------------------------------------

-- Sales table --
CREATE TABLE Sales (
  ID NUMBER PRIMARY KEY,
  Sale_date DATE,
  Payment_Method VARCHAR2(50),
  Total_Price NUMBER,
  Customer_ID NUMBER,
  Salesperson_ID NUMBER,
  CONSTRAINT fk_customer FOREIGN KEY (Customer_ID) REFERENCES Customer(ID),
  CONSTRAINT fk_salesperson FOREIGN KEY (Salesperson_ID) REFERENCES Salesperson(ID)
);

-- All datas are obligatory.
ALTER TABLE Sales MODIFY (Sale_date DATE NOT NULL);
ALTER TABLE Sales MODIFY (Payment_Method VARCHAR2(50) NOT NULL);
ALTER TABLE Sales MODIFY (Total_Price NUMBER NOT NULL);
ALTER TABLE Sales MODIFY (Customer_ID NUMBER NOT NULL);
ALTER TABLE Sales MODIFY (Salesperson_ID NUMBER NOT NULL);

------------------------------------------------------------------------------------------------------

-- Vehicle table (Supertype) --
CREATE TABLE Vehicle (
  ID NUMBER PRIMARY KEY,
  Brand VARCHAR2(50),
  Model VARCHAR2(50),
  Year_of_manufacture NUMBER,
  Fuel_type VARCHAR2(50),
  Engine_power NUMBER,
  Sales_ID NUMBER,
  CONSTRAINT fk_vehicle_sales FOREIGN KEY (Sales_ID) REFERENCES Sales(ID)
);

-- Without Sales ID, All datas are obligatory.
ALTER TABLE Vehicle MODIFY (Brand VARCHAR2(50) NOT NULL);
ALTER TABLE Vehicle MODIFY (Model VARCHAR2(50) NOT NULL);
ALTER TABLE Vehicle MODIFY (Year_of_manufacture NUMBER(4) NOT NULL);
ALTER TABLE Vehicle MODIFY (Fuel_type VARCHAR2(50) NOT NULL);
ALTER TABLE Vehicle MODIFY (Engine_power NUMBER NOT NULL);

-- Add a 'Vehicle_Type' attribute for create 2 new subtypes.
ALTER TABLE Vehicle ADD (Vehicle_Type VARCHAR2(20));

-- New Vehicle table (Subtype) --
CREATE TABLE NewVehicle (
  ID NUMBER PRIMARY KEY,
  Warranty_Length NUMBER,
  CONSTRAINT fk_new_vehicle FOREIGN KEY (ID) REFERENCES Vehicle(ID)
);

-- Second Hand Vehicle table (Subtype) --
CREATE TABLE SecondhandVehicle (
  ID NUMBER PRIMARY KEY,
  Mileage NUMBER,
  Previous_Owners NUMBER,
  CONSTRAINT fk_secondhand_vehicle FOREIGN KEY (ID) REFERENCES Vehicle(ID)
);

------------------------------------------------------------------------------------------------------

-- Maintenance/Repair table --
CREATE TABLE Maintenance_Repair (
  ID NUMBER PRIMARY KEY,
  RepairDate DATE,
  Service_Type VARCHAR2(50),
  Status VARCHAR2(50),
  SHVehicle_ID NUMBER,
  CONSTRAINT fk_shvehicle_maintenance FOREIGN KEY (SHVehicle_ID) REFERENCES SecondhandVehicle(ID)
);

---All datas are obligatory.
ALTER TABLE Maintenance_Repair MODIFY (RepairDate DATE NOT NULL);
ALTER TABLE Maintenance_Repair MODIFY (Service_Type VARCHAR2(50) NOT NULL);
ALTER TABLE Maintenance_Repair MODIFY (Status VARCHAR2(50) NOT NULL);
ALTER TABLE Maintenance_Repair MODIFY (SHVehicle_ID NUMBER NOT NULL);

------------------------------------------------------------------------------------------------------

-- Expense table --
CREATE TABLE Expense (
  ID NUMBER PRIMARY KEY,
  Expense_type VARCHAR2(50),
  Cost NUMBER,
  Receipt_Number VARCHAR2(50),
  Sales_ID NUMBER,
  CONSTRAINT fk_expense_sales FOREIGN KEY (Sales_ID) REFERENCES Sales(ID)
);

-- All datas are obligatory.
ALTER TABLE Expense MODIFY (Expense_type VARCHAR2(50) NOT NULL);
ALTER TABLE Expense MODIFY (Cost NUMBER NOT NULL);
ALTER TABLE Expense MODIFY (Receipt_Number VARCHAR2(50) NOT NULL);
ALTER TABLE Expense MODIFY (Sales_ID NUMBER NOT NULL);


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Add New Data ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

---- Adding data to the Office table ----
INSERT INTO Office (ID, Office_Name, Address, Contact_Number, Opening_Hours)
VALUES (1, 'Istanbul Office', '34230 Esenler Havaalani', '5551253384', '9:00 AM - 5:00 PM');

INSERT INTO Office (ID, Office_Name, Address, Contact_Number, Opening_Hours)
VALUES (2, 'Ankara Office', '06150 Etimeskut Tunahan', '5326812756', '10:00 AM - 6:00 PM');

INSERT INTO Office (ID, Office_Name, Address, Contact_Number, Opening_Hours)
VALUES (3, 'Izmir Office', '35120 Bornova Barbaros', '5056085901', '9:00 AM - 5:00 PM');

------------------------------------------------------------------------------------------------------

---- Adding data to the Customer table ----
INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (1, 'Hakan', 'Gulen', '5326148320', '81460 Sagmalci', 'Engineer', 'Male');

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (2, 'Jane', 'Smith', '5553915540', '35200 Haydar Sokak', 'Technician', 'Female');

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (3, 'Emily', 'Smith', '555123456', '31625 Gonlum Sokak', NULL, 'Female');

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (4, 'Umut', 'Cevik', '555987654', '34350 Kemer Sokak', 'Teacher', NULL);

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (5, 'Sophia', 'Brown', '5329546661', '34156 Gungor Sokak', NULL, NULL);

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (6, 'Sude', 'Kurak', '5054269314', '06246 Kayin Sokak', 'Lawyer', 'Female');

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (7, 'Macit', 'Corak', '5249857831', '06876 Samur Sokak', 'Farmer', 'Male');

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (8, 'Kemal', 'Erdogan', '5052304189', '55113 Gazi Sokak', NULL , 'Male');

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (9, 'Can', 'Yavan', '5319047823', '16236 Segmenler', 'Teacher', NULL);

INSERT INTO Customer (ID, Name, Surname, Phone, Address, Occupation, Gender)
VALUES (10, 'Zeynep', 'Yurdagiren', '5231902356', '20816 Kalaylar', NULL, 'Female');

------------------------------------------------------------------------------------------------------

---- Adding data to the Salesperson table ----
INSERT INTO Salesperson (ID, Name, Surname, Phone, Email, Hire_Date, Office_ID)
VALUES (1, 'Yasin', 'Kaya', '5051244419', 'yasink@gmail.com', TO_DATE('2022-01-05', 'YYYY-MM-DD'), 1);

INSERT INTO Salesperson (ID, Name, Surname, Phone, Email, Hire_Date, Office_ID)
VALUES (2, 'Kadir', 'Kumcu', '5550129655', 'kkumcu@yahoo.com', NULL, 3);

INSERT INTO Salesperson (ID, Name, Surname, Phone, Email, Hire_Date, Office_ID)
VALUES (3, 'Merve', 'Gunaydin', '5329418633', 'mervegun@gmail.com', TO_DATE('2023-01-22', 'YYYY-MM-DD'), 2);

INSERT INTO Salesperson (ID, Name, Surname, Phone, Email, Hire_Date, Office_ID)
VALUES (4, 'Musa', 'Mestan', '5553180510', 'musames@gmail.com', NULL, 1);

INSERT INTO Salesperson (ID, Name, Surname, Phone, Email, Hire_Date, Office_ID)
VALUES (5, 'Melisa', 'Bozkan', '5059613380', 'bozkmelisa@yandex.com', TO_DATE('2023-03-18', 'YYYY-MM-DD'), 3);

INSERT INTO Salesperson (ID, Name, Surname, Phone, Email, Hire_Date, Office_ID)
VALUES (6, 'Bora', 'Mutlu', '5559248736', 'mervegun@gmail.com', TO_DATE('2023-01-22', 'YYYY-MM-DD'), 2);

------------------------------------------------------------------------------------------------------

---- Adding data to the Sales table ----
INSERT INTO Sales (ID, Sale_date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (1, TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'Credit Card', 250000, 1, 1);                 

INSERT INTO Sales (ID, Sale_date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (2, TO_DATE('2020-03-20', 'YYYY-MM-DD'), 'Cash', 180000, 1, 2);                         

INSERT INTO Sales (ID, Sale_Date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (3, TO_DATE('2023-01-19', 'YYYY-MM-DD'), 'Credit Card', 1000000, 2, 2);

INSERT INTO Sales (ID, Sale_Date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (4, TO_DATE('2022-12-18', 'YYYY-MM-DD'), 'Cash', 817000, 3, 3);

INSERT INTO Sales (ID, Sale_Date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (5, TO_DATE('2020-05-31', 'YYYY-MM-DD'), 'Bank Transfer', 30000, 4, 5);

INSERT INTO Sales (ID, Sale_date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (6, TO_DATE('2022-12-14', 'YYYY-MM-DD'), 'Credit Card', 250000, 5, 6);

INSERT INTO Sales (ID, Sale_date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (7, TO_DATE('2023-05-20', 'YYYY-MM-DD'), 'Cash', 18020, 6, 2);

INSERT INTO Sales (ID, Sale_Date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (8, TO_DATE('2021-02-15', 'YYYY-MM-DD'), 'Credit Card', 252030, 7, 5);

INSERT INTO Sales (ID, Sale_Date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (9, TO_DATE('2022-11-18', 'YYYY-MM-DD'), 'Cash', 121400, 8, 4);

INSERT INTO Sales (ID, Sale_Date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (10, TO_DATE('2023-08-21', 'YYYY-MM-DD'), 'Bank Transfer', 32300, 9, 4);

INSERT INTO Sales (ID, Sale_Date, Payment_Method, Total_Price, Customer_ID, Salesperson_ID)
VALUES (11, TO_DATE('2020-03-20', 'YYYY-MM-DD'), 'Bank Transfer', 32300, 10, 3);

------------------------------------------------------------------------------------------------------

---- Adding data to the Vehicle table ----
INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (1, 'Toyota', 'Camry', 2022, 'Gasoline', 180, 'NewVehicle', 1);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (2, 'Honda', 'Civic', 2020, 'Diesel', 150,'NewVehicle', 2);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (3, 'Ford', 'Mustang', 2005, 'Gasoline', 190,'SecondhandVehicle', 3);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (4, 'Chevrolet', 'Cruze', 2012, 'Gasoline', 150,'SecondhandVehicle', 4);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (5, 'Audi', 'A4', 2004, 'Diesel', 300,'SecondhandVehicle', 5);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (6, 'Mercedes', 'C-Class', 2022, 'Gasoline', 180, 'NewVehicle', 6);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (7, 'Volkswagen', 'Golf', 2021, 'Gasoline', 180, 'NewVehicle', NULL);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (8, 'Nissan', 'Altima', 2017, 'Diesel', 180, 'NewVehicle', 7);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (9, 'Hyundai', 'Elantra', 2011, 'Diesel', 180, 'SecondhandVehicle', 8);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (10, 'Kia', 'Sportage', 2015, 'Gasoline', 180, 'NewVehicle', 9);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (11, 'Ford', 'Escape', 2016, 'Gasoline', 180, 'NewVehicle', 10);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (12, 'Chevrolet', 'Silverado', 2009, 'Diesel', 180, 'SecondhandVehicle', 11);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (13, 'BMW', '3 Series', 2022, 'Diesel', 180, 'NewVehicle', NULL);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (14, 'Mercedes', 'GLE', 2019, 'Gasoline', 180, 'NewVehicle', NULL);

INSERT INTO Vehicle (ID, Brand, Model, Year_of_manufacture, Fuel_type, Engine_power, Vehicle_Type, Sales_ID)
VALUES (15, 'Hyundai', 'Getz', 2018, 'Diesel', 180, 'NewVehicle', NULL);

------------------------------------------------------------------------------------------------------

---- Adding data to the NewVehicle table ----
INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (1, 3);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (2, 2);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (6, 5);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (7, 3);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (9, 2);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (10, 2);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (12, 5);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (13, 3);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (14, 2);

INSERT INTO NewVehicle (ID, Warranty_Length)
VALUES (15, 4);

------------------------------------------------------------------------------------------------------

---- Adding data to the SecondhandVehicle table ----
INSERT INTO SecondhandVehicle (ID, Mileage, Previous_Owners)
VALUES (3, 51400, 2);

INSERT INTO SecondhandVehicle (ID, Mileage, Previous_Owners)
VALUES (4, 8050, 1);

INSERT INTO SecondhandVehicle (ID, Mileage, Previous_Owners)
VALUES (5, 186500, 1);

INSERT INTO SecondhandVehicle (ID, Mileage, Previous_Owners)
VALUES (8, 12400, 2);

INSERT INTO SecondhandVehicle (ID, Mileage, Previous_Owners)
VALUES (11, 35120, 3);

------------------------------------------------------------------------------------------------------

---- Adding data to the Maintenance/Repair table ----
INSERT INTO Maintenance_Repair (ID, RepairDate, Service_Type, Status, SHVehicle_ID)
VALUES (1, TO_DATE('2023-01-18', 'YYYY-MM-DD'), 'Oil Change', 'Completed', 3);

INSERT INTO Maintenance_Repair (ID, RepairDate, Service_Type, Status, SHVehicle_ID)
VALUES (2, TO_DATE('2023-05-27', 'YYYY-MM-DD'), 'Tire Rotation', 'In Progress', 4);

INSERT INTO Maintenance_Repair (ID, RepairDate, Service_Type, Status, SHVehicle_ID)
VALUES (3, TO_DATE('2020-05-30', 'YYYY-MM-DD'), 'Radiator replacement', 'Completed', 5);

INSERT INTO Maintenance_Repair (ID, RepairDate, Service_Type, Status, SHVehicle_ID)
VALUES (4, TO_DATE('2023-05-19', 'YYYY-MM-DD'), 'Cooling System Flush', 'Completed', 8);

INSERT INTO Maintenance_Repair (ID, RepairDate, Service_Type, Status, SHVehicle_ID)
VALUES (5, TO_DATE('2023-08-20', 'YYYY-MM-DD'), 'Suspension Inspection', 'Completed', 11);

------------------------------------------------------------------------------------------------------

---- Adding data to the Expense table ----
INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (1, 'Licensing Fees', 699, 'EXP-001', 1);

INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (2, 'Administrative Costs', 999, 'EXP-002', 3);

INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (3, 'Transportation Costs', 699, 'EXP-003', 3);

INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (4, 'Licensing Fees', 1299, 'EXP-004', 4);

INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (5, 'Marketing Expenses', 799, 'EXP-005', 5);

INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (6, 'Marketing Expenses', 699, 'EXP-006', 7);

INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (7, 'Transportation Costs', 1499, 'EXP-007', 8);

INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (8, 'Transportation Costs', 299, 'EXP-008', 9);

INSERT INTO Expense (ID, Expense_type, Cost, Receipt_Number, Sales_ID)
VALUES (9, 'Administrative Costs', 1999, 'EXP-009', 10);


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------