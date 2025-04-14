CREATE DATABASE GYM;
USE GYM;

CREATE TABLE Workout (
    Workout_ID VARCHAR(5) PRIMARY KEY,
    Workout_Name VARCHAR(75) NOT NULL,
    Work_Description TEXT NOT NULL
);

CREATE TABLE Members (
    Member_ID VARCHAR(5) PRIMARY KEY,
    FName VARCHAR(30) NOT NULL,
    LName VARCHAR(30) NOT NULL,
    Member_Password VARCHAR(75) NOT NULL,
    Age INT CHECK (Age >= 18) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')) NOT NULL,
    City VARCHAR(75) NOT NULL,
    Zipcode VARCHAR(15),
    Membership_ID VARCHAR(5) NOT NULL
);

CREATE TABLE Membership (
    Membership_ID VARCHAR(5) PRIMARY KEY,
    Membership_Name VARCHAR(75) NOT NULL,
    Subscription DECIMAL(10, 2) NOT NULL,
    Membership_Duration INT NOT NULL,
    Joining_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Member_ID VARCHAR(5) NOT NULL,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Instructor (
    Instr_ID VARCHAR(5) PRIMARY KEY,
    FName VARCHAR(30) NOT NULL,
    LName VARCHAR(30) NOT NULL,
    Instr_Password VARCHAR(75) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')) NOT NULL,
    City VARCHAR(75) NOT NULL,
    Zipcode VARCHAR(15),
    Age INT NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Instr_MemberID VARCHAR(5) NOT NULL,
    Dual_ID VARCHAR(5),
    FOREIGN KEY (Instr_MemberID) REFERENCES Members(Member_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Dual_ID) REFERENCES Instructor(Instr_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Payment (
    Pay_ID VARCHAR(5) PRIMARY KEY,
    Member_ID VARCHAR(5) NOT NULL,
    Payment_Time TIME NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Payment_Date DATE NOT NULL,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Merchandise (
    Item_NO INT PRIMARY KEY,
    Item_Name VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL,
    Quantity INT CHECK (Quantity <= 10) NOT NULL,
    Merch_MemberID VARCHAR(5) NOT NULL,
    FOREIGN KEY (Merch_MemberID) REFERENCES Members(Member_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Member_Skills (
    Member_ID VARCHAR(5) NOT NULL,
    Skill_Name VARCHAR(75) NOT NULL,
    PRIMARY KEY (Member_ID, Skill_Name),
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Workout_Plan (
    Plan_ID VARCHAR(5),
    Member_ID VARCHAR(5),
    Work_Instr_ID VARCHAR(5),
    Workout_Time TIME NOT NULL,
    PRIMARY KEY (Plan_ID, Member_ID),
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Work_Instr_ID) REFERENCES Instructor(Instr_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Has (
    Plan_ID VARCHAR(5),
    Workout_ID VARCHAR(5),
    Workout_Date DATE NOT NULL,
    PRIMARY KEY (Plan_ID, Workout_ID),
    FOREIGN KEY (Plan_ID) REFERENCES Workout_Plan(Plan_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Workout_ID) REFERENCES Workout(Workout_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Contact (
    Member_ID VARCHAR(10),
    PhoneNum VARCHAR(15),
    Email VARCHAR(75),
    PRIMARY KEY (Member_ID, PhoneNum, Email),
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Members (Member_ID, FName, LName, Member_Password, Age, Gender, City, Zipcode, Membership_ID) 
VALUES 
('M1234', 'Fellwa', 'Alhudaithy', 'fellwa_password', 20, 'F', 'Qasim', '11576', 'MS001'),
('M8746', 'Fajer', 'Alzmanan', 'Fajer_password',20, 'F', 'Jeddah', '21476', 'MS002'),
('M5409', 'Fahad', 'Alshaya', 'fahad_password', 25, 'M', 'Medina', '41470', 'MS003'),
('M3322', 'Sarah', 'Altheeb', 'sarah_password', 20, 'F', 'Khobar', '31450', 'MS004'),
('M2365', 'Khalid', 'Alqahtani', 'khalid_password', 40, 'M', 'Mecca', '21955', 'MS005'),
('M4988', 'Layla', 'Alotaibi', 'layla_password', 32, 'F', 'Tabuk', '71450', 'MS006'),
('M8888', 'Karim', 'Aldossary', 'karim_password', 33, 'M', 'Abha', '62325', 'MS007'),
('M3517', 'Haneen', 'Alghamdi', 'haneen_password', 27, 'F', 'Taif', '21911', 'MS008'),
('M1209', 'Sami', 'Alkhalaf', 'sami_password', 29, 'M', 'Yanbu', '45000', 'MS009'),
('M4545', 'Noor', 'Alkhalaf', 'noor_password', 31, 'F', 'Riyadh', '70100', 'MS010');


INSERT INTO Instructor (Instr_ID, FName, LName, Instr_Password, Gender, City, Zipcode, Age, PhoneNumber, Instr_MemberID, Dual_ID)
VALUES
('I1234', 'Youssef', 'Alhassan', 'youssef_password', 'M', 'Riyadh', '70100', 30, '+123456789', 'M1234', NULL),
('I8746', 'Aisha', 'Bin Saud', 'aisha_password', 'F', 'Jeddah', '21476', 35, '+987654321', 'M8746', 'I1234'),
('I5409', 'Mohammed', 'Alharbi', 'mohammed_password', 'M', 'Dammam', '31450', 25, '+987654321', 'M5409', 'I8746'),
('I3322', 'Leena', 'Alzahrani', 'leena_password', 'F', 'Mecca', '21955', 28, '+123456789', 'M3322', NULL),
('I2365', 'Ibrahim', 'Alotaibi', 'ibrahim_password', 'M', 'Medina', '41470', 40, '+123456789', 'M2365', NULL),
('I4988', 'Noora', 'Bin Khaled', 'noora_password', 'F', 'Tabuk', '71450', 32, '+987654321', 'M4988', NULL),
('I8888', 'Omar', 'Alsulaiman', 'omar_password', 'M', 'Abha', '62325', 33, '+987654321', 'M8888', NULL),
('I3517', 'Reem', 'Bin Abdullah', 'reem_password', 'F', 'Taif', '21911', 27, '+123456789', 'M3517', 'I3322'),
('I1209', 'Ahmed', 'Aldossary', 'ahmed_password', 'M', 'Yanbu', '45000', 29, '+123456789', 'M1209', NULL),
('I4545', 'Marwa', 'Bin Mohammed', 'marwa_password', 'F', 'Hail', '70412', 31, '+987654321', 'M4545', 'I4988');


INSERT INTO Payment (Pay_ID, Member_ID, Payment_Time, Amount, Payment_Date)
VALUES 
('P001', 'M1234', '12:30:00', 50.00, '2024-05-10'),
('P002', 'M8746', '14:45:00', 60.00, '2024-05-11'),
('P003', 'M5409', '10:00:00', 70.00, '2024-05-12'),
('P004', 'M3322', '16:00:00', 45.00, '2024-05-13'),
('P005', 'M2365', '09:30:00', 55.00, '2024-05-14'),
('P006', 'M4988', '11:15:00', 65.00, '2024-05-15'),
('P007', 'M8888', '13:20:00', 70.00, '2024-05-16'),
('P008', 'M3517', '15:45:00', 80.00, '2024-05-17'),
('P009', 'M1209', '17:30:00', 90.00, '2024-05-18'),
('P010', 'M4545', '19:00:00', 100.00, '2024-05-19');

INSERT INTO Merchandise (Item_NO, Item_Name, Price, Quantity, Merch_MemberID)
VALUES 
(1, 'T-Shirt', 15.99, 5, 'M3322'),
(2, 'Water Bottle', 5.99, 10, 'M4988'),
(3, 'Yoga Mat', 20.50, 8, 'M8888'),
(4, 'Resistance Bands', 12.99, 6, 'M3322'),
(5, 'Jump Rope', 8.50, 10, 'M4988'),
(6, 'Dumbbell Set', 45.00, 3, 'M8888'),
(7, 'Exercise Ball', 25.00, 7, 'M1209'),
(8, 'Foam Roller', 18.99, 4, 'M4545'),
(9, 'Sports Bra', 19.99, 8, 'M3517'),
(10, 'Running Shoes', 60.00, 5, 'M2365');

INSERT INTO Membership (Membership_ID, Membership_Name, Subscription, Membership_Duration, Joining_Date, End_Date, Member_ID)
VALUES
('MS001', 'Gold Membership', 150.00, 30, '2024-05-10', '2024-06-09', 'M1234'),
('MS002', 'Silver Membership', 100.00, 30, '2024-05-11', '2024-06-10', 'M8746'),
('MS003', 'Bronze Membership', 75.00, 30, '2024-05-12', '2024-06-11', 'M5409'),
('MS004', 'Platinum Membership', 200.00, 30, '2024-05-13', '2024-06-12', 'M3322'),
('MS005', 'Basic Membership', 50.00, 30, '2024-05-14', '2024-06-13', 'M2365'),
('MS006', 'Premium Membership', 180.00, 30, '2024-05-15', '2024-06-14', 'M4988'),
('MS007', 'VIP Membership', 250.00, 30, '2024-05-16', '2024-06-15', 'M8888'),
('MS008', 'Standard Membership', 90.00, 30, '2024-05-17', '2024-06-16', 'M3517'),
('MS009', 'Elite Membership', 220.00, 30, '2024-05-18', '2024-06-17', 'M1209'),
('MS010', 'Exclusive Membership', 300.00, 30, '2024-05-19', '2024-06-18', 'M4545');

INSERT INTO Member_Skills (Member_ID, Skill_Name)
VALUES
('M1234', 'Weightlifting'),
('M8746', 'Yoga'),
('M5409', 'Cardio'),
('M3322', 'Pilates'),
('M2365', 'Swimming'),
('M4988', 'CrossFit'),
('M8888', 'Barre'),
('M3517', 'Zumba'),
('M1209', 'Rock Climbing'),
('M4545', 'Martial Arts');

INSERT INTO Workout (Workout_ID, Workout_Name, Work_Description)
VALUES
('W001', 'Gold Membership Workout', 'This high-intensity interval training (HIIT) workout combines strength training exercises with bursts of cardio to maximize calorie burn and build muscle. It is ideal for those seeking a challenging and efficient workout.'),
('W002', 'Silver Membership Workout', 'This full-body strength training workout focuses on compound exercises that target multiple muscle groups at once. It is perfect for those wanting to build overall strength and improve muscle tone.'),
('W003', 'Bronze Membership Workout', 'This beginner-friendly circuit training workout incorporates bodyweight exercises and light weights to improve cardiovascular health, build foundational strength, and increase flexibility.'),
('W004', 'Platinum Membership Workout', 'This personalized workout plan is designed by a certified trainer to meet your specific fitness goals, addressing any limitations or preferences you may have.'),
('W005', 'Basic Membership Workout', 'This low-impact cardio workout utilizes activities like brisk walking, stationary cycling, or light jogging to increase heart rate and burn calories, ideal for those starting their fitness journey.'),
('W006', 'Premium Membership Workout', 'This yoga and Pilates fusion class combines strengthening postures from Pilates with the flexibility and mindfulness of yoga, promoting core stability, balance, and improved posture.'),
('W007', 'VIP Membership Workout', 'This exclusive swim coaching session provides personalized instruction tailored to your swimming goals, whether you are a beginner or looking to refine your technique.'),
('W008', 'Standard Membership Workout', 'This group fitness class offers a dynamic mix of cardio exercises like dance, kickboxing, or Zumba, providing a fun and social way to get your heart rate up and burn calories.'),
('W009', 'Elite Membership Workout', 'This advanced rock climbing session challenges your strength, endurance, and problem-solving skills. It is perfect for experienced climbers seeking a challenging and rewarding workout.'),
('W010', 'Exclusive Membership Workout', 'This personalized martial arts training program allows you to choose from various disciplines like Muay Thai, Karate, or Brazilian Jiu-Jitsu, under the guidance of a qualified instructor.');

INSERT INTO Workout_Plan (Plan_ID, Member_ID, Work_Instr_ID, Workout_Time)
VALUES 
('P001', 'M1234', 'I1234', '08:00:00'),
('P002', 'M8746', 'I8746', '09:00:00'),
('P003', 'M5409', 'I5409', '10:00:00'),
('P004', 'M3322', 'I3322', '11:00:00'),
('P005', 'M2365', 'I2365', '12:00:00'),
('P006', 'M4988', 'I4988', '13:00:00'),
('P007', 'M8888', 'I8888', '14:00:00'),
('P008', 'M3517', 'I3517', '15:00:00'),
('P009', 'M1209', 'I1209', '16:00:00'),
('P010', 'M4545', 'I4545', '17:00:00');

INSERT INTO Has (Plan_ID, Workout_ID, Workout_Date)
VALUES 
('P001', 'W001', '2024-05-10'),
('P002', 'W002', '2024-05-11'),
('P003', 'W003', '2024-05-12'),
('P004', 'W004', '2024-05-13'),
('P005', 'W005', '2024-05-14'),
('P006', 'W006', '2024-05-15'),
('P007', 'W007', '2024-05-16'),
('P008', 'W008', '2024-05-17'),
('P009', 'W009', '2024-05-18'),
('P010', 'W010', '2024-05-19');


INSERT INTO Contact (Member_ID, PhoneNum, Email)
VALUES
('M1234', '+966508177918', 'Fellwa123@gmail.com'), 
('M8746', '+447456123456', 'Fajer456@gmail.com'), 
('M5409', '+12067890123', 'Fahad789@gmail.com'),  
('M3322', '+966554143272', 'Sarah900@gmail.com'), 
('M2365', '+491578901234', 'Khalid012@gmail.com'),  
('M4988', '+19175678900', 'Layla345@gmail.com'), 
('M8888', '+61412345678', 'Karim678@gmail.com'), 
('M3517', '+971551234567', 'Haneen901@gmail.com'), 
('M1209', '+442078901234', 'Sami012@gmail.com'),  
('M4545', '+966543210987', 'Noor345@gmail.com');

-- we will insert new Instructor
INSERT INTO Instructor (Instr_ID, FName, LName, Instr_Password, Gender, City, Zipcode, Age, PhoneNumber, Instr_MemberID, Dual_ID)
VALUES
('I0123', 'Albandry', 'Alotaibi', 'bano_password', 'F', 'Riyadh', '70100', 21, '+123456789', 'M1234', 'I4988');

INSERT INTO Workout_Plan (Plan_ID, Member_ID, Work_Instr_ID, Workout_Time)
VALUES 
('P011', 'M1234', 'I0123', '08:30:00');

INSERT INTO Has (Plan_ID, Workout_ID, Workout_Date)
VALUES 
('P011', 'W001', '2024-05-20');

-- add delete then update here

-- DELETE
-- We will delete the member "Noor"
DELETE FROM Members WHERE Member_ID = 'M4545';

-- "UPDATE" (Layla, 32 years old)
UPDATE Members
SET Age = 21
WHERE Member_ID = 'M4988';


-- Using "LIKE" to display members whos name start with "F"
SELECT * FROM Members WHERE FName LIKE 'F%';

-- Amount "Between" 50 and 100
SELECT Pay_ID, Member_ID, Amount FROM Payment WHERE Amount BETWEEN 50.00 AND 100.00;

-- Instructor "IN" 3 cities ('Riyadh', 'Jeddah', 'Medina')
SELECT Instr_ID, FName, LName, Gender, City, Zipcode FROM Instructor WHERE City IN ('Riyadh', 'Jeddah', 'Medina');

-- USING "ORDER BY" (descending order)
SELECT * FROM Members
ORDER BY Age DESC;

-- USING "IS NULL" Find all instructors who do not have a Dual_ID
SELECT FName,LName FROM Instructor WHERE Dual_ID IS NULL;


-- F PART ********
-- Retrieve combined information from Workout_Plan and Has tables based on Plan_ID
SELECT * FROM Workout_Plan NATURAL JOIN Has;

-- Retrieve all workout plans along with associated workout sessions, if any, based on Plan_ID
SELECT * FROM Workout_Plan LEFT OUTER JOIN Has ON Workout_Plan.Plan_ID = Has.Plan_ID;

-- Retrieve member information along with their membership details, including members without memberships
SELECT Members.Member_ID, FName, LName, Gender, Members.Membership_ID 
FROM Members RIGHT OUTER JOIN Membership ON Members.Member_ID = Membership.Member_ID;

-- Retrieve member information for members who have made payments
SELECT Member_ID, FName, LName FROM Members
WHERE EXISTS (
    SELECT 1
    FROM Payment
    WHERE Members.Member_ID = Payment.Member_ID
);

/*This function retrieves the discount percentage associated with a given membership ID
        from the Membership table and returns it.*/
DELIMITER $$
CREATE FUNCTION GetDiscountPercent (membership_id VARCHAR(5))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE discount DECIMAL(5,2);
    
    SELECT Subscription * 0.1
    INTO discount
    FROM Membership
    WHERE Membership_ID = membership_id
    LIMIT 1; -- Limit to only one row
    
    RETURN discount;
END$$

-- This view combines merchandise purchases with member details, showing who purchased what.

CREATE VIEW Merchandise_Purchases AS
SELECT 
    M.Item_NO,
    M.Item_Name,
    M.Price,
    M.Quantity,
    CONCAT(MB.FName, ' ', MB.LName) AS Member_Name,
    MB.Age AS Member_Age,
    MB.Gender AS Member_Gender,
    MB.City AS Member_City,
    MB.Zipcode AS Member_Zipcode
FROM 
    Merchandise M
JOIN 
    Members MB ON M.Merch_MemberID = MB.Member_ID;
    
    -- S PART *******
    
    -- INTERSECT: Common cities between Members and Instructor
SELECT DISTINCT m.City
FROM Members m
JOIN Instructor i ON m.City = i.City;

-- EXCEPT: Cities in Members but not in Instructor
SELECT DISTINCT m.City
FROM Members m
LEFT JOIN Instructor i ON m.City = i.City
WHERE i.City IS NULL;


-- UNION: All unique cities from Members and Instructor
SELECT City FROM Members
UNION
SELECT City FROM Instructor;

-- GROUP BY and HAVING
SELECT Member_ID, SUM(Amount) AS Total_Amount
FROM Payment
GROUP BY Member_ID
HAVING SUM(Amount) > 10;

    -- Stored Procedure
DELIMITER &&
CREATE PROCEDURE GetMemberInfo(IN input_Member_ID VARCHAR(5))
BEGIN
    SELECT * FROM Members WHERE Member_ID = input_Member_ID;
END &&
DELIMITER ;
CALL GetMemberInfo('M1234');

-- Trigger
DELIMITER //

CREATE TRIGGER AfterMemberInsert
AFTER INSERT ON Members
FOR EACH ROW
BEGIN
    INSERT INTO Contact (Member_ID, PhoneNum, Email)
    VALUES (NEW.Member_ID, 'default_phone', 'default_email@example.com');
END //
DELIMITER ;
INSERT INTO Members (Member_ID, FName, LName, Member_Password, Age, Gender, City, Zipcode, Membership_ID) 
VALUES ('M5678', 'John', 'Doe', 'john_password', 22, 'M', 'TestCity', '12345', 'MS011');
-- FOR TESTING MY TRIGGER:
SELECT * FROM Contact WHERE Member_ID = 'M5678';

-- Nasted Query in WHERE clause
SELECT FName, LName
FROM Members
WHERE Member_ID IN (
    SELECT Merch_MemberID
    FROM Merchandise
    WHERE Item_Name = 'T-Shirt'
);