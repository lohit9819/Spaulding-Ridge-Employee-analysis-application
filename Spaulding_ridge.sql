create database employee;
use employee;
show tables;
select * from employee_data;
SET SQL_SAFE_UPDATES = 0;
UPDATE employee_data 
SET Years_of_Experience = NULL 
WHERE Years_of_Experience = '';
select * from employee_data;
ALTER TABLE employee_data
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE employee_data
RENAME COLUMN `Current_Comp_(INR)` TO current_comp_inr;
ALTER TABLE employee_data
ADD COLUMN current_comp_int INT;
UPDATE employee_data
SET current_comp_int = CONVERT(REPLACE(current_comp_inr, ',', ''), UNSIGNED INTEGER);
ALTER TABLE employee_data
DROP COLUMN current_comp_inr;
ALTER TABLE employee_data
ADD Column Last_Working_Day_clean date;
select * from employee_data;
Select Distinct Last_Working_Day From employee_data;
describe employee_data;
UPDATE employee_data
SET Last_Working_Day_clean = CASE
WHEN TRIM(Last_Working_Day) REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
    THEN STR_TO_DATE(TRIM(Last_Working_Day), '%e/%c/%Y')
  WHEN TRIM(Last_Working_Day) REGEXP '^[A-Za-z]+ [0-9]{1,2}, [0-9]{4}$'
    THEN STR_TO_DATE(TRIM(Last_Working_Day), '%M %e, %Y')
  ELSE '2100-12-31'
END;
ALTER TABLE employee_data
DROP COLUMN Last_Working_Day;
Select * from average_industry_compensation;
ALTER TABLE average_industry_compensation
ADD COLUMN average_industry_comp_int INT;
UPDATE average_industry_compensation
SET average_industry_comp_int = CONVERT(REPLACE(Average_Industry_Compensation, ',', ''), UNSIGNED INTEGER);
ALTER TABLE average_industry_compensation
DROP COLUMN Average_Industry_Compensation;
ALTER TABLE average_industry_compensation
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
select * from average_industry_compensation;
ALTER TABLE employee_rating
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
select* from employee_rating;
UPDATE employee_rating 
SET YoE = NULL 
WHERE YoE = '';
select* from employee_rating;
select  * from employee_data;
select * from average_industry_compensation;
create table employee_master ( employee_id int,
role_id int,
current_compensation int,
last_working_day date,
active_status text,
manager_rating int,
average_industry_compensation int);
insert into employee_master 
select e.id as employee_id, r.id as role_id, current_comp_int as current_compensation, Last_Working_Day_clean as last_working_day, Active as  active_status, L3Q_Average_Manager_Rating as manager_rating, average_industry_comp_int as average_industry_compensation
from
employee_data as e 
left join employee_rating as er 
on e.id=er.id 
left join average_industry_compensation as r on e.Location=r.Location and e.Role = r.Role;
select * from employee_master;