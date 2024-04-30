-- Create a table
CREATE DATABASE College_Store_Management;
use College_Store_Management;
drop database College_Store_Management;
update  login
set Name='computer'
where email_id='computerhod@mhssce.ac.in' ;
create table login (
	email_id varchar(50) primary key,
    pass_word varchar(100) not null,
    Name varchar(50),
    role ENUM('StoreAdmin', 'Admin', 'Staff','Lab Incharge','HOD','Principal'),
     INDEX idx_Name (Name)
);
drop table login;
select * from login;
drop table Department_Store;
create table Department_Store(
	Department_id varchar(10) primary key,
    Department_name varchar(100) unique not null,
    email_id varchar (50),
    INDEX idx_Department_name (Department_name),
    foreign key (Department_name) references login (name),
    foreign key (email_id) references login (email_id)
        on update cascade
         on delete cascade
    
);
create table Staff(
	Staff_id varchar(10) primary key,
    staff_name varchar(50),
    email_id varchar (50),
    INDEX idx_staff_name (staff_name),
	foreign key (staff_name) references login (name),
	foreign key (email_id) references login (email_id)
    on update cascade
    on delete cascade
    );
    
create table Lab(
	Lab_id varchar(10) primary key,
    Lab_name varchar(50) unique not null,
    email_id varchar (50),
    INDEX idx_Lab_name (Lab_name),
	foreign key (Lab_name) references login (name),
	foreign key (email_id) references login (email_id)
    on update cascade
    on delete cascade
    );
    drop table department_store;
    drop table Staff;
    drop table Lab;
    

CREATE TABLE SL_Req_DS (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    product_type ENUM('consumable','non-consumable'),
    product_name VARCHAR(50),
    product_description text,
    quantity INT,
    department_name VARCHAR(100),
    purpose ENUM('Personal', 'Lab'),
    name VARCHAR(50),
    remark text,
    status ENUM('pending', 'approved', 'rejected','supplying'),
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_name) REFERENCES Department_Store(department_name) ON UPDATE CASCADE ON DELETE CASCADE
);





drop table sl_req_ds;
drop table SL_DS_Main;
-- ye nihce wala bkl tp tsble hai
create table SL_DS_Main(
	request_id int primary key,
    status ENUM('pending', 'approved', 'rejected'),
    created_at varchar(30),
    foreign key (request_id) references Req_DS(request_id)
	on update cascade
    on delete cascade
    );
delete from SL_DS_Main where request_id = 1;
insert into SL_DS_Main values (1,'pending',2020);
CREATE VIEW SL_Req_Main AS
SELECT
    r.request_id,
    r.product_name,
    r.quantity,
    r.department_name,
    r.purpose,
    r.name,
    s.status,
    s.created_at
FROM
    Req_DS r
JOIN
    SL_DS_Main s ON r.request_id = s.request_id;

select * from  SL_Req_Main where status = 'pending';
drop view SL_req_main;

    ALTER TABLE req_main DROP FOREIGN KEY request_id;
    ALTER TABLE req_main DROP COLUMN request_id;
	select * from req_main;
    drop table req_main;

    select * from req_main;
CREATE TABLE Products (
    Product_id INT AUTO_INCREMENT PRIMARY KEY,
    Product_name VARCHAR(50) unique not null,
    INDEX idx_Product_name (Product_name)
);
create table ledger(
	ledger_id int primary key auto_increment,
    ledger_Name varchar(50) unique not null,
     INDEX idx_ledger_name (ledger_name)
);
drop table Products;
ALTER TABLE product
CHANGE Pruduct_name Product_name VARCHAR(30);

INSERT INTO Products (Product_id, Product_name)
VALUES (1, 'Computer'),
(2,'Keyboard');
INSERT INTO Products (Product_id, Product_name)
VALUES (3, 'Blackboard'),
(4,'AC');
INSERT INTO Department_Store (Department_id, Department_name,email_id)
VALUES (101, 'Computer Engineering','computer@mhssce.ac.in'),
(102,'Mechanical Engineering','mechanical@mhssce.ac.in');
delete from Login where email_id = 'zamanshaikh@mhssce.ac.in';
delete from Department_Store where department_name != "a";
INSERT INTO Login (email_id, pass_word, name, role)
VALUES 
   ('computer@mhssce.ac.in', 'computer', 'Computer Engineering', 'StoreAdmin'),
    ('mechanical@mhssce.ac.in', 'mechanical', 'Mechanical Engineering', 'StoreAdmin'),
    ('CBLab@mhssce.ac.in', 'CB', 'CB Lab', 'Lab Incharge'),
     ('zamanshaikh@mhssce.ac.in', '12345', 'Zaman', 'Staff'),
     ('computerhod@mhssce.ac.in', 'hodpassword', 'Computer Engineering', 'HOD'),
     ('MPLab@mhssce.ac.in', 'MP', 'MP Lab', 'Lab Incharge'),
    ('principal@mhssce.ac.in', 'principal', 'Abdul Wahab', 'Principal');

INSERT INTO Login (email_id, pass_word,name,role)
VALUES ('admin@mhssce.ac.in','admin',"Main Store",'Admin');
INSERT ignore INTO Product (Product_name) values ("Printer");
INSERT INTO Staff (staff_id,staff_name,email_id)
VALUES ('1', 'Zaman','zamanshaikh@mhssce.ac.in');
INSERT INTO Lab (Lab_id,Lab_name,email_id)
VALUES ('1', 'CB Lab','CBLab@mhssce.ac.in');
select * from  product;
ALTER TABLE product AUTO_INCREMENT = 1;

select * from staff;
select * from sl_req_ds;
explain select * 
    FROM staff_req_ds
    WHERE request_id = 1;
INSERT INTO staff_req_ds (Product_id,quantity,Department_id,Staff_id,purpose,status) VALUES (1,5,101,1,"Personal","pending");
delete from product where product_id != 1;
delete from req_ds where request_id != 5;
ALTER TABLE req_ds AUTO_INCREMENT = 1;

ALTER TABLE Product MODIFY Product_id INT AUTO_INCREMENT;
ALTER TABLE staff_req_ds MODIFY request_id INT AUTO_INCREMENT;
ALTER TABLE Product
CHANGE COLUMN Pruduct_name Product_name VARCHAR(30); 
DELETE FROM Product WHERE Product_name = "Printer";

create table Stock(
    item_id int primary key auto_increment,
	Product_name varchar(50),
    product_type ENUM('consumable','non-consumable'),
    Product_description text,
    quantity int,
    supplied_quantity int default 0,
    amount double,
	created_at timestamp default current_timestamp,
    name_of_supplier varchar(50),
    status ENUM('supplied', 'available') default 'available'
); 
INSERT INTO Stock (Product_name, Product_description, quantity, supplied_quantity, amount, created_at, name_of_supplier, status)
VALUES ('Computer', 'Description1', 10, 2, 50000, '2024-04-05', 'ASUS', 'available'),
       ('Keyboard', 'Description2', 15, 0, 750, '2024-04-05', 'ACER', 'available');
delete from stock where item_id!=10;
CREATE VIEW AvailableStock AS
SELECT * FROM Stock WHERE status = 'available';
drop view AvailableStock;
drop table stock;
insert into req_ds values(5,"computer",4,"Computer Engineering","Personal","CB Lab","pending","03/30/2024");
drop table DS_req_Main;
create table DS_req_Main(
	request_id int auto_increment primary key,
    department_name varchar(100) ,
    product_type ENUM('consumable','non-consumable'),
	Product_name varchar(50),
    product_description text,
	quantity INT,
    remark text,
    status ENUM('pending', 'approved', 'approved by Principal','approved by HOD' , 'rejected','rejected by HOD','rejected by Principal','supplying'),
    requested_by varchar(50),
    requested_at timestamp default current_timestamp,
    foreign key (department_name) references Department_Store(Department_name)
     on update cascade
    on delete cascade
    );
drop table DS_req_main;
select * from login ;
select * from DS_req_main;
SELECT staff, ENGINE
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'college_store';
drop table stock_DS;
create table stock_DS(
	approved_id int primary key,
    bill_no varchar(15),
    Inward_no varchar(15),
    deadstock_no varchar(15),
	foreign key (approved_id) references DS_Req_Main(request_id)
	on update cascade
    on delete cascade
);
drop table stock_ds;
CREATE TABLE availableMainStock (
    item_id INT PRIMARY KEY,
    product_type ENUM('consumable','non-consumable'),
    Product_name VARCHAR(50),
    Product_description TEXT,
    quantity INT,
    amount double,
    created_at timestamp default current_timestamp,
    name_of_supplier VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES stock(item_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
drop table availablemainstock;
drop table supplyingDS;
CREATE TABLE supplyingDS (
	Approved_id int primary key,
    item_id INT,
    department_name varchar(100),
    Product_name VARCHAR(50),
    product_type ENUM('consumable','non-consumable'),
    Product_description TEXT,
    quantity INT,
    amount double,
    bill_no varchar(15),
    Inward_no varchar(15),
    deadstock_no varchar(15),
    name_of_supplier VARCHAR(50),
	FOREIGN KEY (Approved_id) REFERENCES DS_Req_Main(request_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
CREATE TABLE suppliedDS (
    Approved_id INT,
    stock_ref_id INT,
    ds_item_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name varchar(100),
    Product_name VARCHAR(50),
    product_type ENUM('consumable','non-consumable'),
    Product_description TEXT,
    quantity INT,
    supplied_quantity INT,
    amount double,
    bill_no varchar(15),
    Inward_no varchar(15),
    deadstock_no varchar(15),
    status enum('supplied','available') default 'available',
    recieved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name_of_supplier VARCHAR(50),
    FOREIGN KEY (Approved_id) REFERENCES DS_Req_Main(request_id),
    FOREIGN KEY (stock_ref_id) REFERENCES stock(item_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    INDEX (Approved_id)
);
drop table suppliedDS;
DELIMITER //

CREATE TRIGGER after_insert_suppliedDSStock
AFTER INSERT ON suppliedDS
FOR EACH ROW
BEGIN
	IF NEW.status = 'available' THEN
        INSERT INTO availableDSStock (stock_ref_id,item_id,department_name, Product_name,Product_type, Product_description, quantity, amount,bill_no,Inward_no,Deadstock_no, recieved_at,name_of_supplier)
        VALUES (NEW.stock_ref_id, NEW.ds_item_id,NEW.department_name, NEW.Product_name,NEW.Product_type, NEW.Product_description, NEW.quantity, NEW.amount,NEW.bill_no,NEW.Inward_no,NEW.Deadstock_no,NEW.recieved_at, NEW.name_of_supplier);
	END IF;
END//

DELIMITER ;
drop trigger after_insert_suppliedDSStock;
CREATE VIEW RecievedDS_stock_view AS
SELECT s.approved_id, s.stock_item_id,s.ds_item_id, s.Product_name, s.Product_description,
       s.quantity AS supplied_quantity, s.amount AS amount, s.status ,s.name_of_supplier, 
       st.bill_no, st.Inward_no, st.deadstock_no 
FROM suppliedDS s
JOIN stock_DS st ON s.Approved_id = st.approved_id;

drop view RecievedDS_stock_view;
drop table suppliedDS;
drop table supplyingDS;
insert into supplyingds(approved_id) values (3);
DELIMITER //

CREATE TRIGGER insert_into_available_stock AFTER INSERT ON stock
FOR EACH ROW
BEGIN
    IF NEW.status = 'available' THEN
        INSERT INTO availablemainstock (item_id, Product_name,Product_type, Product_description, quantity,amount ,created_at, name_of_supplier)
        VALUES (NEW.item_id, NEW.Product_name,NEW.Product_type, NEW.Product_description, NEW.quantity,NEW.amount, NEW.created_at, NEW.name_of_supplier);
    END IF;
END//

DELIMITER ;

DROP TRIGGER after_insert_suppliedDSStock;



-- Create a stored function to calculate the discounted price
DELIMITER //
CREATE FUNCTION calculate_discounted_price(product_id INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE original_price DECIMAL(10,2);
    DECLARE discount DECIMAL(4,2);
    DECLARE discounted_price DECIMAL(10,2);
    
    -- Retrieve the original price of the product from the products table
    SELECT price INTO original_price FROM products WHERE id = product_id;
    
    -- Retrieve the discount for the product from the discounts table
    SELECT discount INTO discount FROM discounts WHERE product_id = product_id;
    
    -- Calculate the discounted price
    SET discounted_price = original_price - (original_price * (discount / 100));
    
    RETURN discounted_price;
END//
DELIMITER ;
SET GLOBAL log_bin_trust_function_creators = 0;

-- DELIMITER //

-- CREATE FUNCTION calculate_unit_price(item_id_param INT)
-- RETURNS DECIMAL(10, 2)
-- DETERMINISTIC
-- BEGIN
--     DECLARE total_quantity INT;
--     DECLARE total_amount DECIMAL(10, 2);
--     DECLARE unit_price DECIMAL(10, 2);

--     -- Retrieve total quantity and total amount using a subquery
--     SELECT SUM(quantity), SUM(amount) INTO total_quantity, total_amount
--     FROM stock
--     WHERE item_id = item_id_param;

--     -- Check if total_quantity is greater than 0 to avoid division by zero error
--     IF total_quantity > 0 THEN
--         SET unit_price = total_amount / total_quantity;
--     ELSE
--         SET unit_price = 0;
--     END IF;

--     RETURN unit_price;
-- END//


drop function calculate_unit_price;

drop trigger before_insert_supplyingDS;
DELIMITER //

CREATE TRIGGER before_insert_supplyingDS
BEFORE INSERT ON supplyingDS
FOR EACH ROW
BEGIN
	DECLARE total_amount double;
    DECLARE total_quantity int;
    DECLARE supp_quantity int;
    DECLARE remaining_quantity INT;
    DECLARE prod_quantity INT;
    DECLARE prod_type ENUM('consumable','non-consumable');
    DECLARE prod_name VARCHAR(50);
    DECLARE available_item_id INT;
    DECLARE available_quantity INT;
    DECLARE amount_for_available double;
    DECLARE amount_for_required double;
    DECLARE amount_per_piece double;
    DECLARE prod_description text;
    DECLARE name_supplier varchar(50);

    -- Retrieve product quantity and product name from the Products table using request_id
    SELECT quantity, Product_name,Product_type INTO prod_quantity, prod_name,prod_type
    FROM DS_Req_Main
    WHERE request_id = NEW.Approved_id;

    -- Set product quantity and product name in supplyingDS
    
    SET NEW.quantity = prod_quantity;
    SET NEW.Product_name = prod_name;
    SET NEW.Product_type = prod_type;
    
     -- Fetch the item_id from availablestock where quantity is greater than prod_quantity and product name matches prod_name
    SELECT item_id, product_description,quantity,name_of_supplier INTO available_item_id, prod_description,name_supplier
    FROM availablemainstock
    WHERE quantity >= prod_quantity
    AND Product_name = prod_name
    ORDER BY created_at ASC
    LIMIT 1;
    SET NEW.item_id = available_item_id;
    SET NEW.product_description = prod_description;
    SET NEW.name_of_supplier = name_supplier;
	
	SELECT quantity , amount,supplied_quantity INTO total_quantity,total_amount,supp_quantity
    FROM stock
    WHERE item_id = available_item_id;
    
    SET amount_per_piece = total_amount / total_quantity;
    
    SET available_quantity = total_quantity - (supp_quantity + prod_quantity);
    
    SET amount_for_available = amount_per_piece * available_quantity;
    SET amount_for_required = amount_per_piece * prod_quantity;
	
    UPDATE stock
    SET supplied_quantity = supp_quantity + prod_quantity
    WHERE item_id = available_item_id;

    -- Subtract the supplied quantity from availablestock
    UPDATE availablemainstock
    SET quantity = available_quantity,
    amount = amount_for_available
    WHERE item_id = available_item_id;

    -- Calculate remaining quantity in availablestock
    
    SET NEW.amount = amount_for_required;
    -- Calculate total amount for the remaining quantity
    IF available_quantity = 0 THEN
        DELETE FROM availablemainstock WHERE item_id = available_item_id;
        UPDATE stock
		SET status = "supplied"
		WHERE item_id = available_item_id;
    END IF;

  
END;
//

DELIMITER ;

drop trigger before_insert_supplyingds;


DELIMITER //

CREATE TRIGGER before_insert_supplyingSL
BEFORE INSERT ON supplyingSL
FOR EACH ROW
BEGIN
	DECLARE total_amount double;
    DECLARE total_quantity int;
    DECLARE supp_quantity int;
    DECLARE remaining_quantity INT;
    DECLARE prod_quantity INT;
    DECLARE dept_name VARCHAR(100);
    DECLARE prod_name VARCHAR(50);
    DECLARE prod_type ENUM('consumable','non-consumable');
    DECLARE sl_name VARCHAR(50);
    DECLARE B_no VARCHAR(15);
    DECLARE I_no VARCHAR(15);
    DECLARE D_no VARCHAR(15);
    DECLARE available_item_id INT;
    DECLARE stock_ref int;
    DECLARE available_quantity INT;
    DECLARE amount_for_available double;
    DECLARE amount_for_required double;
    DECLARE amount_per_piece double;
    DECLARE prod_description text;
    DECLARE name_supplier varchar(50);

    -- Retrieve product quantity and product name from the Products table using request_id
    SELECT quantity, Product_name,Product_type,Department_name,name INTO prod_quantity, prod_name,prod_type,dept_name,sl_name
    FROM SL_Req_DS
    WHERE request_id = NEW.Approved_id;

    -- Set product quantity and product name in supplyingDS
    
    SET NEW.quantity = prod_quantity;
    SET NEW.Product_name = prod_name;
    SET NEW.Product_type = prod_type;
    SET NEW.name = sl_name;
    
     -- Fetch the item_id from availablestock where quantity is greater than prod_quantity and product name matches prod_name
    SELECT item_id,stock_ref_id, product_description,name_of_supplier,bill_no,Inward_no,Deadstock_no INTO available_item_id,stock_ref, prod_description,name_supplier,B_no,I_no,D_no
    FROM availabledsstock
    WHERE quantity > prod_quantity
    AND Product_name = prod_name
    AND Department_name = dept_name
    ORDER BY created_at ASC
    LIMIT 1;
    SET NEW.ds_item_id = available_item_id;
    SET NEW.stock__id = available_item_id;
    SET NEW.product_description = prod_description;
    SET NEW.name_of_supplier = name_supplier;
    SET NEW.Inward_no = I_no;
    SET NEW.Deadstock_no = D_no;
    SET NEW.Bill_no = B_no;
	
	SELECT quantity , amount,supplied_quantity INTO total_quantity,total_amount,supp_quantity
    FROM suppliedds
    WHERE item_id = available_item_id;
    
    SET amount_per_piece = total_amount / total_quantity;
    
    SET available_quantity = total_quantity - (supp_quantity + prod_quantity);
    
    SET amount_for_available = amount_per_piece * available_quantity;
    SET amount_for_required = amount_per_piece * prod_quantity;
	
    UPDATE suppliedds
    SET supplied_quantity = supp_quantity + prod_quantity
    WHERE item_id = available_item_id;

    -- Subtract the supplied quantity from availablestock
    UPDATE availabledsstock
		SET 
			quantity = total_quantity - (supp_quantity + prod_quantity),
			amount = amount_per_piece * available_quantity
		WHERE 
			item_id = available_item_id;


    -- Calculate remaining quantity in availablestock
    
    SET NEW.amount = amount_for_required;
    -- Calculate total amount for the remaining quantity
    IF available_quantity = 0 THEN
        DELETE FROM availabledsstock WHERE item_id = available_item_id;
        UPDATE suppliedds
		SET status = "supplied"
		WHERE item_id = available_item_id;
    END IF;

  
END;
//

DELIMITER ;


drop database College_store;

SELECT product_name, SUM(quantity) AS total_quantity
FROM sl_req_ds
GROUP BY product_name;







 SELECT product_name, SUM(quantity) AS total_quantity
        FROM sl_req_ds
        WHERE status = "pending" AND department_name = "Computer Engineering"
        GROUP BY product_name;
SELECT * 
FROM sl_req_ds
WHERE YEAR(requested_at) = 2024;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50),
    total_amount DECIMAL(10, 2),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO orders (customer_name, total_amount) VALUES
('John Doe', 100.50),
('Alice Smith', 75.20),
('Bob Johnson', 150.75);

SELECT *
FROM orders
WHERE YEAR(order_date) = 2023;

drop table orders;
drop table availableDSStock;
CREATE TABLE availableDSStock (
	department_name varchar(100),
    item_id INT PRIMARY KEY,
    stock_ref_id int,
    product_type ENUM('consumable','non-consumable'),
    Product_name VARCHAR(50),
    Product_description TEXT,
    quantity INT,
    amount double,
    bill_no varchar(15),
    Inward_no varchar(15),
    deadstock_no varchar(15),
    recieved_at timestamp default current_timestamp,
    name_of_supplier VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES  suppliedDS(ds_item_id),
    FOREIGN KEY (stock_ref_id) REFERENCES  suppliedDS(stock_ref_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
drop table availableDSStock;
drop table supplyingsl;
create table supplyingSL(
	Approved_id int primary key,
    stock_ref_id INT,
    ds_item_id INT,
    department_name varchar(100),
    Product_name VARCHAR(50),
    product_type ENUM('consumable','non-consumable'),
    name varchar(50),
    Product_description TEXT,
    quantity INT,
    amount double,
    bill_no varchar(15),
    Inward_no varchar(15),
    deadstock_no varchar(15),
    name_of_supplier VARCHAR(50),
	FOREIGN KEY (Approved_id) REFERENCES SL_Req_DS(request_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
    );
    drop table suppliedsl;
    create table suppliedSL(
	Approved_id int primary key,
    stock_ref_id INT,
    ds_item_id INT,
    department_name varchar(100),
    Product_name VARCHAR(50),
    product_type ENUM('consumable','non-consumable'),
    name varchar(50),
    Product_description TEXT,
    quantity INT,
    amount double,
    bill_no varchar(15),
    Inward_no varchar(15),
    deadstock_no varchar(15),
    recieved_at timestamp default current_timestamp,
    name_of_supplier VARCHAR(50),
	FOREIGN KEY (Approved_id) REFERENCES SL_Req_DS(request_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
    );
    drop table supplyingsl;
    drop table suppliedsl;
    
    drop view SL_Req_DS_With_Available_Quantity;
    CREATE VIEW sl_req_ds_with_available_quantity AS
SELECT 
    r.request_id,
    r.product_type,
    r.product_name,
    r.product_description,
    r.quantity AS requested_quantity,
    r.department_name,
    r.purpose,
    r.name,
    r.remark,
    r.status,
    r.requested_at,
    COALESCE(s.available_quantity, 0) AS available_quantity
FROM 
    SL_Req_DS r
LEFT JOIN (
    SELECT 
        Product_name,
        SUM(quantity) AS available_quantity
    FROM 
        availableDSStock
    GROUP BY 
        Product_name
) s ON r.product_name = s.Product_name;

drop view DS_req_Main_With_Available_Quantity;
CREATE VIEW DS_req_Main_With_Available_Quantity AS
SELECT 
    m.request_id,
    m.department_name,
    m.product_type,
    m.Product_name,
    m.product_description,
    m.quantity AS requested_quantity,
    m.remark,
    m.status,
    m.requested_by,
    m.requested_at,
    COALESCE(s.available_quantity, 0) AS available_quantity
FROM 
    DS_req_Main m
LEFT JOIN (
    SELECT 
        Product_name,
        SUM(quantity) AS available_quantity
    FROM 
        availableMainStock
    GROUP BY 
        Product_name
) s ON m.Product_name = s.Product_name;
select* from department_store;

DELIMITER //

CREATE TRIGGER before_insert_supplyingDS
BEFORE INSERT ON supplyingDS
FOR EACH ROW
BEGIN
    DECLARE total_amount double;
    DECLARE total_quantity INT;
    DECLARE supp_quantity INT;
    DECLARE remaining_quantity INT;
    DECLARE prod_type ENUM('consumable','non-consumable');
    DECLARE prod_quantity INT;
    DECLARE prod_name VARCHAR(50);
    DECLARE dept_name VARCHAR(100);
    DECLARE available_item_id INT;
    DECLARE available_quantity INT;
    DECLARE amount_for_available double;
    DECLARE amount_for_required double;
    DECLARE amount_per_piece double;
    DECLARE prod_description TEXT;
    DECLARE name_supplier VARCHAR(50);

    -- Retrieve product quantity and product name from the DS_Req_Main table using request_id
    SELECT quantity, product_type, Product_name, department_name INTO prod_quantity, prod_type, prod_name, dept_name
    FROM DS_Req_Main
    WHERE request_id = NEW.Approved_id;

    -- Set product quantity and product name in supplyingDS
    SET NEW.quantity = prod_quantity;
    SET NEW.product_type = prod_type;
    SET NEW.Product_name = prod_name;
    SET NEW.department_name = dept_name;

    -- Fetch the item_id from availablemainstock where quantity is greater than prod_quantity and product name matches prod_name
    SELECT item_id, product_description,quantity, name_of_supplier INTO available_item_id, prod_description,available_quantity, name_supplier
    FROM availablemainstock
    WHERE quantity >= prod_quantity
    AND Product_name = prod_name 
    ORDER BY created_at ASC
    LIMIT 1;

    -- Check if item_id is NULL, indicating no stock is available
   --  IF available_item_id IS NULL THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'No stock available for ' || prod_name;
--     END IF;

    -- Proceed with processing if stock is available
    -- Set remaining details for supplyingDS
    SET NEW.item_id = available_item_id;
    SET NEW.product_description = prod_description;
    SET NEW.name_of_supplier = name_supplier;

    -- Fetch total quantity and total amount from stock table
    SELECT quantity, amount, supplied_quantity INTO total_quantity, total_amount, supp_quantity
    FROM stock
    WHERE item_id = available_item_id;
    
    SET amount_per_piece = total_amount / total_quantity;
    
    SET available_quantity = total_quantity - (supp_quantity + prod_quantity);
    SET amount_for_available = amount_per_piece * available_quantity;
    SET amount_for_required = amount_per_piece * prod_quantity;

    -- Update supplied quantity in the stock table
    UPDATE stock
    SET supplied_quantity = supp_quantity + prod_quantity
    WHERE item_id = available_item_id;

    -- Update quantity and amount in availablemainstock table
    UPDATE availablemainstock
    SET quantity = available_quantity, amount = amount_for_available
    WHERE item_id = available_item_id;

    -- Set amount for the supplied quantity in supplyingDS
    SET NEW.amount = amount_for_required;

    -- Delete the row from availablemainstock if available quantity becomes 0
    IF available_quantity = 0 THEN
        DELETE FROM availablemainstock WHERE item_id = available_item_id;
        -- Update the status in the stock table to 'supplied'
        UPDATE stock
        SET status = 'supplied'
        WHERE item_id = available_item_id;
    END IF;
END;
//

DELIMITER ;
-- trigger for supplying sl :-
DELIMITER //

CREATE TRIGGER before_insert_supplyingSL
BEFORE INSERT ON supplyingSL
FOR EACH ROW
BEGIN
    DECLARE total_amount double;
    DECLARE total_quantity INT;
    DECLARE supp_quantity INT;
    DECLARE remaining_quantity INT;
    DECLARE prod_type ENUM('consumable','non-consumable');
    DECLARE prod_quantity INT;
    DECLARE prod_name VARCHAR(50);
    DECLARE sl_name VARCHAR(50);
    DECLARE dept_name VARCHAR(100);
    DECLARE available_item_id INT;
    DECLARE stock_ref INT;
    DECLARE available_quantity INT;
    DECLARE amount_for_available double;
    DECLARE amount_for_required double;
    DECLARE amount_per_piece double;
    DECLARE B_no VARCHAR(15);
    DECLARE I_no VARCHAR(15);
    DECLARE D_no VARCHAR(15);
    DECLARE prod_description TEXT;
    DECLARE name_supplier VARCHAR(50);

    -- Retrieve product quantity and product name from the SL_req_DS table using request_id
    SELECT quantity, product_type, Product_name,name ,department_name INTO prod_quantity, prod_type, prod_name,sl_name, dept_name
    FROM SL_Req_DS
    WHERE request_id = NEW.Approved_id;

    -- Set product quantity and product name in supplyingSL
    SET NEW.quantity = prod_quantity;
    SET NEW.product_type = prod_type;
    SET NEW.Product_name = prod_name;
    SET NEW.department_name = dept_name;
    SET NEW.name = sl_name;

    -- Fetch the item_id from availabldsstock where quantity is greater than prod_quantity and product name matches prod_name
    SELECT item_id,stock_ref_id, product_description,quantity,Inward_no,bill_no,deadstock_no, name_of_supplier INTO available_item_id,stock_ref, prod_description,available_quantity,I_no,B_no,D_no, name_supplier
    FROM availabledsstock
    WHERE quantity >= prod_quantity
    AND Product_name = prod_name AND department_name = dept_name
    ORDER BY recieved_at ASC
    LIMIT 1;

    -- Check if item_id is NULL, indicating no stock is available
   --  IF available_item_id IS NULL THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'No stock available for ' || prod_name;
--     END IF;
	 IF available_item_id IS NULL THEN
		SET @error_message = CONCAT('No stock available for ', prod_name);
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
    END IF;


    -- Proceed with processing if stock is available
    -- Set remaining details for supplyingSL
    SET NEW.ds_item_id = available_item_id;
    SET NEW.stock_ref_id = stock_ref;
    SET NEW.product_description = prod_description;
    SET NEW.name_of_supplier = name_supplier;
	SET NEW.Inward_no = I_no;
    SET NEW.deadstock_no = D_no;
    SET NEW.bill_no = B_no;
    -- Fetch total quantity and total amount from suppliedds table
    SELECT quantity, amount, supplied_quantity INTO total_quantity, total_amount, supp_quantity
    FROM suppliedds
    WHERE ds_item_id = available_item_id;
    
    SET amount_per_piece = total_amount / total_quantity;
    
    SET available_quantity = total_quantity - (supp_quantity + prod_quantity);
    SET amount_for_available = amount_per_piece * available_quantity;
    SET amount_for_required = amount_per_piece * prod_quantity;

    -- Update supplied quantity in the stock table
    UPDATE suppliedds
    SET supplied_quantity = supp_quantity + prod_quantity
    WHERE ds_item_id = available_item_id;

    -- Update quantity and amount in availablemainstock table
    UPDATE availabledsstock
    SET quantity = available_quantity, amount = amount_for_available
    WHERE item_id = available_item_id;

    -- Set amount for the supplied quantity in supplyingDS
    SET NEW.amount = amount_for_required;

    -- Delete the row from availablemainstock if available quantity becomes 0
    IF available_quantity = 0 THEN
        DELETE FROM availabledsstock WHERE item_id = available_item_id;
        -- Update the status in the stock table to 'supplied'
        UPDATE suppliedds
        SET status = 'supplied'
        WHERE ds_item_id = available_item_id;
    END IF;
END;
//

DELIMITER ;
drop trigger before_insert_supplyingSL;
DESCRIBE suppliedDS;


SELECT product_name, SUM(quantity) AS total_quantity , SUM(amount) AS total_amount
                    FROM suppliedds
                    group by Product_name;
