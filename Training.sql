select first_name,last_name from employees;
select dept_no from departments;
select * from departments;
select * from employees where first_name ="Elvis";
select * from employees where gender="M" and first_name="Kellie";
select * from employees where first_name="Kellie" or first_name="Aruna";
select * from employees where gender="F" and (first_name="Kellie" or first_name="Aruna");
select * from employees where first_name in ("Cathie","Mark","Nathan");
select * from employees where first_name in ("Denis","Elvis");
select * from employees where first_name not in ("John","Mark","Jacob");
select * from employees where first_name like ("mark%");
select * from employees where hire_date like ("2000-__-__");
select * from employees where emp_no like ("1000_");
select * from employees where first_name like ("Jack%");
select * from employees where first_name not like ("Jack%");
select * from salaries;
select * from salaries where salary between 66000 and 70000;
select * from employees where emp_no not between 10004 and 10012;
select * from departments where dept_no between 'd003' and 'd006';
select dept_name from departments where dept_no is not null;
use workers;
select * from employees where gender="F" and hire_date >= "2000-01-01";
select * from salaries where salary > 150000;
select * from salaries;
select distinct(gender) from employees;
select count(distinct(gender)) from employees;
select distinct(hire_date) from employees;
select count(emp_no) from employees;
show tables;
select count(salary) from salaries where salary>100000;
select count(*) from dept_manager;
select * from employees order by first_name;
select * from employees order by first_name desc;
select * from employees order by hire_date desc;
select count(gender),gender from employees group by gender;
select first_name,count(first_name) as count from employees group by first_name order by first_name;
select salary,count(salary) as emps_with_same_salary from salaries where salary>80000 group by salary order by salary;
select * from titles;
select emp_no,avg(salary) from salaries group by emp_no having avg(salary)>120000 order by emp_no;
select first_name,count(first_name) from employees where hire_date>"1999-01-01" group by first_name having count(first_name)<200 order by first_name;
select * from dept_emp;
select emp_no,count(from_date) from dept_emp where from_date>"2000-01-01" group by emp_no having count(from_date)>1 order by emp_no;
select * from dept_emp limit 100;
select emp_no from salaries order by salary desc limit 10;
select count(distinct(dept_no)) from dept_emp;
select sum(salary) from salaries where from_date>"1997-01-01";
select min(emp_no) from employees;
select max(emp_no) from employees;
select avg(salary) from salaries where from_date > "1997-01-01";
select round(avg(salary),2) from salaries where from_date>"1997-01-01";
use workers;
select em.emp_no,em.first_name,dp.dept_no from employees em join dept_manager dp on em.emp_no=dp.emp_no;
CREATE TABLE departments_dup(dept_no CHAR(4) NULL,dept_name VARCHAR(40) NULL);
INSERT INTO departments_dup(dept_no,dept_name)SELECT * FROM departments;
INSERT INTO departments_dup (dept_name) VALUES ('Public Relations');
DELETE FROM departments_dup WHERE dept_no = 'd002';
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (

  emp_no int(11) NOT NULL,

  dept_no char(4) NULL,

  from_date date NOT NULL,

  to_date date NULL

  );

 

INSERT INTO dept_manager_dup select * from dept_manager;

 

INSERT INTO dept_manager_dup (emp_no, from_date) VALUES (999904, '2017-01-01'),(999905, '2017-01-01'),(999906, '2017-01-01'),(999907, '2017-01-01');
DELETE FROM dept_manager_dup WHERE dept_no = 'd001';

select dm.dept_no,dm.emp_no,dp.dept_name from dept_manager dm join departments_dup dp on dm.dept_no=dp.dept_no order by dept_no;
select * from dept_manager limit 3;
select em.emp_no,em.first_name,em.last_name,em.hire_date,dp.dept_no from employees em join dept_manager dp on em.emp_no=dp.emp_no;
select * from titles limit 3;
show tables;
select em.emp_no,em.first_name,em.last_name,em.hire_date,dp.dept_no,dp.from_date from employees em left join dept_manager dp on em.emp_no=dp.emp_no where em.last_name="Markovitch" order by emp_no;
-- Old join syntax without using join and on keyword.
select em.emp_no,em.first_name,em.last_name,em.hire_date,dm.dept_no from employees em, dept_manager dm where em.emp_no=dm.emp_no;
select * from salaries limit 3;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
select em.emp_no,em.first_name,em.last_name,em.hire_date,tl.title from employees em join titles tl on em.emp_no=tl.emp_no where em.first_name="Margareta" and last_name="Markovitch";
use workers;
select emp.gender,avg(s.salary) from employees emp join salaries s on emp.emp_no=s.emp_no group by emp.gender;
select * from titles where title="Manager";

-- joining more than 2 tables
select em.first_name,em.last_name,em.hire_date,dm.from_date,t.title,d.dept_name
from
employees em join dept_manager dm on em.emp_no=dm.emp_no
join departments d on dm.dept_no=d.dept_no
join titles t on t.emp_no=em.emp_no
where t.title="Manager";
select e.gender,count(e.gender) from employees e join dept_manager dm on e.emp_no=dm.emp_no
join titles t on t.emp_no=e.emp_no where t.title="Manager" group by e.gender;

select e.gender,count(e.gender) from employees e join titles t on t.emp_no=e.emp_no where t.title="Manager" group by e.gender;

SELECT

    e.gender, COUNT(dm.emp_no)

FROM

    employees e

        JOIN

    dept_manager dm ON e.emp_no = dm.emp_no

GROUP BY gender;

SELECT

    *

FROM

    (SELECT

        e.emp_no,

            e.first_name,

            e.last_name,

            NULL AS dept_no,

            NULL AS from_date

    FROM

        employees e

    WHERE

        last_name = 'Denis' UNION SELECT

        NULL AS emp_no,

            NULL AS first_name,

            NULL AS last_name,

            dm.dept_no,

            dm.from_date

    FROM

        dept_manager dm) as a

ORDER BY -a.emp_no DESC
;
select * from employees limit 3;
use workers;
select A.* 
from 
	(select em.emp_no as employee_ID,min(dm.dept_no) as deptartment_code,
		(select emp_no from dept_manager where emp_no=110022) as manager_ID
		from employees em join dept_emp dm on em.emp_no=dm.emp_no where em.emp_no<=10020 group by em.emp_no) as A 
			union 
				select B.* 
                from 
					(select em.emp_no as employee_ID,min(dm.dept_no) as deptartment_code,
						(select emp_no from dept_manager where emp_no=110039) as manager_ID
						from employees em join dept_emp dm on em.emp_no=dm.emp_no where em.emp_no>10020 group by em.emp_no limit 20) as B;



select * from dept_emp limit 10;




select * from employees where hire_date between "1990-01-01" and "1995-01-01" and emp_no in(select emp_no from dept_manager);
select * from employees where emp_no in(select emp_no from titles where title="Assistant Engineer");
select * from employees where emp_no in (select emp_no from dept_manager where dept_no=1245);
select * from employees e where exists(select * from titles t where e.emp_no=t.emp_no and gender="M");
select * from dept_manager where exists(select * from employees where hire_date between "1990-01-01" and "1995-01-01");
select * from employees where emp_no in (select emp_no from titles where title="Assistant Engineer");
(select emp_no from dept_manager where emp_no=110022);
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (

   emp_no INT(11) NOT NULL,

   dept_no CHAR(4) NULL,

   manager_no INT(11) NOT NULL

);



Insert INTO emp_manager SELECT
U.* 
FROM 
	(select 
		A.* 
        from 
			(select e.emp_no,min(de.dept_no),
            (select emp_no 
            from 
				dept_manager 
			where 
				emp_no=110022) as Manager_ID 
		from 
			employees e join dept_emp de on e.emp_no=de.emp_no 
		where 
			e.emp_no<=10020 group by e.emp_no order by e.emp_no) as A
UNION 
	 select B.* from (select e.emp_no,min(de.dept_no),(select emp_no from dept_manager where emp_no=110039) as Manager_ID from employees e join dept_emp de on e.emp_no=de.emp_no where e.emp_no>10020 group by e.emp_no order by e.emp_no) as B
	 UNION 
		select C.* from(select e.emp_no,min(dept_no),(select emp_no from dept_manager where emp_no=110039) as Manager_ID from employees e join dept_emp de on e.emp_no=de.emp_no where e.emp_no=110022 group by e.emp_no order by e.emp_no) as C
        UNION
			select D.* from (select e.emp_no,min(dept_no),(select emp_no from dept_manager where emp_no=110022)as Manager_ID from employees e join dept_emp de on e.emp_no=de.emp_no where e.emp_no=110039 group by e.emp_no order by e.emp_no) as D) as U;


-- Stored Procedure
drop procedure if exists display;
delimiter $$
drop procedure if exists rithik;
CREATE PROCEDURE rithik ()
BEGIN
select * from employees limit 1000;
END $$
delimiter ;
call rithik();
delimiter $$
create procedure display()
Begin
select * from employees limit 55;
select * from departments;
End $$
delimiter ;

call display();

delimiter $$
create procedure average()
begin
select avg(salary) from salaries;
end $$
delimiter ;
call average();
call workers.average();
call average;
call employees.average;
call emp_salary(11300);

drop procedure if exists avg_salary;
delimiter $$
create procedure avg_salary(IN p_emp_no integer)
begin
select e.first_name,e.last_name,s.salary from employees e join salaries s on e.emp_no=s.emp_no where e.emp_no=p_emp_no;
end $$
delimiter ;
call avg_salary(11300);

drop procedure if exists emp_avg_salary_out;
delimiter $$
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
begin
select avg(salary) into p_avg_salary from salaries s join employees e on e.emp_no=s.emp_no where e.emp_no=p_emp_no;
end$$
delimiter ;
call emp_avg_salary_out(11300);

delimiter $$
create procedure avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
begin
select avg(salary) into p_avg_salary from salaries s where s.emp_no=p_emp_no;
end$$
delimiter ;
call avg_salary_out(11300);

select * from salaries limit 10;

delimiter $$
create procedure emp_info( in p_f_name varchar(20),in p_l_name varchar(20), out p_emp_no int)
begin
select emp_no into p_emp_no from employees e where e.first_name=p_f_name and e.last_name=p_l_name;
end$$
delimiter;
call emp_info("Parto","Bamford");
-- calling the procedure through a variable
set @v_emp_no=0;
call emp_info("Parto","Bamford",@v_emp_no);
select v_emp_no;
drop procedure if exists emp_number;

select * from employees limit 20;
call emp_number("Parto","Bamford");

set @v_avg_salary=0;
call workers.emp_avg_salary_out(11300,@v_avg_salary);
select @v_avg_salary;

set @v_emp_no=0;
call emp_number("Aruna","Journel",@v_emp_no);
select @v_emp_no;
select * from titles;
use workers;

call title_name(10005);

delimiter $$
create procedure min_salary()
BEGIN
select min(salary) from salaries;
END $$
delimiter ;

call min_salary();

delimiter $$
create procedure select_employees()
begin
select * from employees limit 100;
end$$
delimiter ;
call select_employees();

delimiter $$
create procedure avg_sal()
begin
select avg(salary) from salaries;
end$$
delimiter ;

call avg_sal;

delimiter $$
create procedure emp_salary(IN p_emp_no INT)
begin
select e.first_name,e.last_name,s.salary,s.from_date,s.to_date from employees e join salaries s 
on e.emp_no=s.emp_no 
where e.emp_no=p_emp_no;
end$$
delimiter ;

call emp_salary(10002); 

delimiter $$
create procedure avg_emp_salary(IN p_emp_no INT)
begin
select e.first_name,e.last_name,avg(s.salary) from employees e join salaries s 
on e.emp_no=s.emp_no 
where e.emp_no=p_emp_no;
end$$
delimiter ;
call avg_emp_salary(10005);

delimiter $$
create procedure out_avg_emp_salary(IN p_emp_no INT,OUT p_avg_sal DECIMAL(10,2))
begin
select avg(s.salary) into p_avg_sal from employees e join salaries s  
on e.emp_no=s.emp_no 
where e.emp_no=p_emp_no;
end$$
delimiter ;
set @v_sal=0;
call out_avg_emp_salary(11300,@v_sal);
select @v_sal;
delimiter $$
create procedure emp_info(IN p_fname varchar(20),in p_lname varchar(20),out p_emp_no integer)
begin
select e.emp_no into p_emp_no from employees e where e.first_name=p_fname and e.last_name=p_lname;
end$$
delimiter ;

set @v_emp_no=0;
call emp_info("Aruna","Journel",@v_emp_no);
select @v_emp_no;

-- Creating a function
delimiter $$
create function emp_info(p_fname varchar(20),p_lname varchar(20)) returns decimal(10,2)
deterministic no sql reads sql data
begin
declare v_salary decimal(10,2);
declare v_max_from_date date;
select max(from_date) into v_max_from_date from employees e join salaries s on e.emp_no=s.emp_no where e.first_name=p_fname and e.last_name=p_lname;
SELECT s.salary INTO v_salary FROM employees e JOIN salaries s ON e.emp_no = s.emp_no WHERE e.first_name = p_first_name
AND e.last_name = p_last_name
AND s.from_date = v_max_from_date;
RETURN v_salary;

END$$
DELIMITER ;

delimiter $$
create function emp_info(p_f_name varchar(20),p_l_name varchar(20)) returns decimal(10,2)
deterministic no sql reads sql data
begin
declare v_salary decimal(10,2);
declare v_max_from_date date;
select max(from_date) into v_max_from_date from employees e join salaries s on e.emp_no=s.emp_no;
select s.salary into v_salary from salaries s join employees e on e.emp_no=s.emp_no where e.first_name=p_f_name and e.last_name=p_l_name and s.from_date=v_max_from_date;
return v_salary;
end$$
delimiter ;

select emp_info("Aruna","Journel");

-- Case Statements--
select e.emp_no,e.first_name,e.last_name,
CASE
when gender="M" then "Male"
Else "Female"
end as sex
from employees e;
use workers;
select * from salaries;
select e.first_name,e.last_name,
case 
when e.gender="M" then "Male"
else "Female" 
end as Gender,sum(s.salary) over(partition by gender order by e.emp_no) as salary_average from employees e join salaries s on e.emp_no=s.emp_no;

select e.first_name,e.last_name,
if (e.gender="M","Male","Female") as Gender
 from employees e;
 select * from dept_manager limit 100;
 select * from salaries limit 20;
 use workers;
 
 select e.emp_no,e.first_name,e.last_name,
 case
 when d.emp_no is not null then "Manager"
 else "Employee"
 end as is_manager
 from employees e left join dept_manager d on e.emp_no=d.emp_no where e.emp_no>109990;
 
 select e.emp_no,e.first_name,e.last_name,max(s.salary)-min(s.salary) as Salary_Difference,
 Case 
 when max(salary)-min(salary)>30000 then "More than 30000"
 else "not more than 30000"
 end as Salary_rise
 from employees e join salaries s on e.emp_no=s.emp_no group by e.emp_no;
 
 select 
 dm.emp_no,e.first_name,e.last_name,max(s.salary)-min(s.salary) as salary_diff,
 case
 when max(s.salary)-min(s.salary)>30000 then "Salary was raised by more than $30000"
 when max(s.salary)-min(s.salary) between 20000 and 30000 then "Salary was raised by more than $20000 but less than $30000"
 else "Salary was raised by less than $20000"
 end as salary_increase
 from dept_manager dm join employees e on dm.emp_no=e.emp_no
 join salaries s on s.emp_no=dm.emp_no
 group by s.emp_no;
 
 select e.emp_no,e.first_name,e.last_name,
 case 
 when dm.emp_no is not null then "Manager"
 else "Employee"  
 end as is_manager
 from employees e join dept_manager dm;
 
 select e.emp_no,e.first_name,e.last_name,max(s.salary)-min(s.salary) as salary_diff,
 case
 when max(s.salary)-min(s.salary)>30000 then "Salary is greater than $30000"
 else "Salary is less than $30000"
 end as salary_increase
 from employees e join salaries s on e.emp_no=s.emp_no 
group by e.emp_no;

select * from dept_emp;

select e.emp_no,e.first_name,e.last_name,
case
when de.to_date>"2024-11-08" then "current_employee"
else "Not an employee anymore" 
end as Employeed
from employees e join dept_emp de on e.emp_no=de.emp_no group by e.emp_no limit 100;
use workers;
-- Window Function
select emp_no,salary,ROW_NUMBER() OVER(partition by emp_no order by salary) as row_num from salaries;
select * from salaries limit 20;
select emp_no,dept_no,row_number() over(order by emp_no) as row_num from dept_manager;
select emp_no,first_name,last_name,row_number() over(partition by first_name order by last_name) from employees;
select dm.emp_no,s.salary,row_number()over() as row1,row_number() over(partition by dm.emp_no order by salary desc) as row2 from dept_manager dm join salaries s on dm.emp_no=s.emp_no;
SELECT dm.emp_no,s.salary,row_number() over(partition by dm.emp_no order by s.salary) as row1,row_number() over(partition by dm.emp_no order by s.salary desc) as row2 from dept_manager dm join salaries s on dm.emp_no=s.emp_no;
select emp_no,salary,row_number() over w as row1 from salaries window w as (partition by emp_no order by salary desc);
select *,row_number() over w from employees window w as (partition by first_name order by emp_no asc); 
select emp_no,salary,row_number() over(partition by emp_no order by salary) as row_num from salaries;
select dept_no,emp_no,row_number() over(order by emp_no) from dept_manager;
select emp_no,first_name,last_name,row_number() over(partition by first_name order by last_name) from employees;
select emp_no,salary,
row_number() over() as row_num1,
row_number() over(partition by emp_no) as row_num2,
row_number() over(partition by emp_no order by salary desc) as row_num3,
row_number() over(order by salary desc) as row_num4
from salaries order by emp_no,salary;
select d.emp_no,s.salary,row_number() over() as row_num1, row_number() over(partition by d.emp_no order by s.salary) as row_num2 from dept_manager d join salaries s on d.emp_no=s.emp_no order by row_num1,emp_no,salary;
select d.emp_no,s.salary,row_number() over(partition by d.emp_no order by s.salary) as row_num1,
row_number() over(partition by d.emp_no order by s.salary desc) as row_num2
from dept_manager d join salaries s on d.emp_no=s.emp_no;

select row_number() over() as row_num1,t.emp_no,t.title,s.salary,
row_number() over(partition by t.emp_no order by s.salary desc) as row_num2 from titles t join salaries s on t.emp_no=s.emp_no where t.title="Staff" and t.emp_no<10007 order by t.emp_no,s.salary,row_num1;

select emp_no,salary, row_number() over w as row_num1
from salaries
window w as (partition by emp_no order by salary desc);

select emp_no,first_name,last_name, row_number() over w as row_num1 from employees
window w as (partition by first_name order by emp_no);

select a.emp_no,a.salary as max_salary from (select emp_no,salary,row_number() over(partition by emp_no order by salary desc) as row_num1 from salaries) a where a.row_num1=1;

select a.emp_no,a.salary as min_salary from (select emp_no,salary, row_number() over w as row_num1 from salaries window w as (partition by emp_no order by salary)) a where a.row_num1=1;
select a.emp_no,min(salary) as min_salary from (select emp_no,salary, row_number() over w as row_num1 from salaries window w as (partition by emp_no order by salary)) a group by emp_no;
select emp_no,salary,row_number() over(partition by emp_no order by salary desc) from salaries;
select emp_no,salary,row_number() over() as row_num1 from salaries where emp_no=11839;

-- Rank()--
select emp_no,salary, rank() over(partition by emp_no order by salary) as rank_num from salaries where emp_no=11839; 
select emp_no,salary, dense_rank() over(partition by emp_no order by salary) as rank_num from salaries where emp_no=11839; 
select emp_no,salary,rank() over(partition by emp_no order by salary desc) as rank_num1 from salaries where emp_no=10560;
select s.emp_no,count(s.salary) from salaries s join dept_manager d on s.emp_no=d.emp_no group by s.emp_no order by s.emp_no;
select emp_no,salary, rank() over w as rank_num from salaries where emp_no=10560 window w as (partition by emp_no order by salary);
select emp_no,salary,dense_rank() over w rank_num from salaries where emp_no=10560 window w as (partition by emp_no order by salary);
select dd.dept_no,s.emp_no,s.salary,s.from_date,s.to_date,d.from_date,d.to_date,rank() over (partition by dd.dept_no order by s.salary desc) as rank1 
from 
salaries s join dept_manager d 
on 
s.emp_no=d.emp_no 
and s.from_date between d.from_date and d.to_date
and s.to_date between d.from_date and d.to_date
join departments dd 
on 
dd.dept_no=d.dept_no;

select e.emp_no,s.salary, rank() over(partition by emp_no order by salary desc) as ranking from employees e join salaries s on e.emp_no=s.emp_no where e.emp_no between 10500 and 10600; 
select e.emp_no,s.salary,dense_rank() over(partition by emp_no order by salary) as ranking from employees e join salaries s on e.emp_no=s.emp_no where e.emp_no between (10500 AND 10600) and year(s.from_date)-year(e.hire_date) >=5;

select e.emp_no,s.salary,dense_rank() over(partition by emp_no order by salary) as ranking from employees e join salaries s on e.emp_no=s.emp_no and year(s.from_date)-year(e.hire_date) >=4 where e.emp_no between 10500 AND 10600;
select e.emp_no,s.salary,dense_rank() over(partition by emp_no order by salary) as ranking from employees e join salaries s on e.emp_no=s.emp_no where e.emp_no between 10500 AND 10600 and year(s.from_date)-year(e.hire_date) >=4;

select emp_no,salary, rank() over(partition by emp_no order by salary desc) as ranking from salaries where emp_no between 10500 and 10600;

-- LAG() LEAD() Value Window Functions--
use workers;
select row_number() over(partition by emp_no order by salary) as row_num,emp_no,salary,lag(salary) over w as pre_salary ,lead(salary) over w as next_salary,salary-lag(salary) over w as diff_salary_lag,lead(salary) over w-salary as diff_salary_lead from salaries where emp_no between 10001 and 10003 window w as (order by salary);
select emp_no,salary,lag(salary) over w as previous_salary, lead(salary) over w as next_salary, salary-lag(salary) over w as pre_sal_diff, lead(salary) over w - salary as next_sal_diff from salaries where salary>80000 and emp_no between 10500 and 10600 window w as (partition by emp_no order by salary);
select emp_no,salary,lag(salary) over w,lag(salary,2) over w,lead(salary) over w,lead(salary) over w from salaries window w as (order by salary) limit 100; 

select emp_no,salary,from_date,to_date from salaries where to_date>sysdate();
select sysdate();
select s.emp_no,s.salary,s.from_date,s.to_date from salaries s join (select emp_no,max(from_date) as from_date from salaries group by emp_no) a1 on s.from_date=a1.from_date where s.to_date>sysdate() ;
select s.emp_no,s.salary,s.from_date,s.to_date from salaries s join (select emp_no,min(from_date) as from_date from salaries group by emp_no)a1 on s.from_date=a1.from_date where s.to_date>sysdate();
select * from dept_emp where emp_no=10018 order by from_date;

select * from dept_manager order by from_date limit 100;
select s.emp_no,s.salary,s.from_date,s.to_date from salaries s join (select emp_no,max(to_date) as to_date from salaries group by emp_no) s1 on s.emp_no=s1.emp_no where sysdate()<s.to_date and s.to_date=s1.to_date;

-- CTE--
select avg(salary) from salaries;

with cte as
(select avg(salary) as avg_salary from salaries)
select sum(case when s.salary>c.avg_salary then 1 else 0 END) as sum_female_salary_abv_avg,count(s.salary) as total_no_of_salary_contracts
from salaries s join employees e on e.emp_no=s.emp_no and e.gender="F" cross join cte c; 

with cte as (select avg(salary) as avg_salary from salaries) select s.emp_no,e.first_name,e.last_name,s.salary from salaries s join employees e on e.emp_no=s.emp_no and e.gender="F" join cte c where s.salary>c.avg_salary;

with cte as
(select avg(salary) as avg_salary from salaries)
select sum(case when s.salary>c.avg_salary then 1 else 0 end) as sum_f_salary_abv_avg from employees e join salaries s on e.emp_no=s.emp_no and e.gender="M"
cross join cte c where s.salary>=c.avg_salary;

with cte as 
(select avg(salary) as avg_salary from salaries)
select count(case when s.salary>c.avg_salary then s.salary else null end) as count_f_salary_abv_avg from employees e join
salaries s on e.emp_no=s.emp_no and e.gender="M" cross join cte c where s.salary>c.avg_salary;

select count(case when s.salary>a.avg_salary then s.salary else null end) as count_f_salary_abv_avg from employees e
join salaries s on e.emp_no=s.emp_no and e.gender="M" cross join (select avg(salary) as avg_salary from salaries) a where s.salary>a.avg_salary;

with cte as 
(select avg(salary) as avg_salary from salaries)
select count(case when s.salary<c.avg_salary then s.salary else null end) as no_f_salaries_below_avg,count(s.salary) as no_of_f_salary_contracts from salaries s join employees e on e.emp_no=s.emp_no and e.gender="F" cross join cte c;

with cte1 as
(select avg(salary) as avg_salary from salaries),
cte2 as(
select e.emp_no,max(s.salary) as max_salary from employees e join salaries s on s.emp_no=e.emp_no and e.gender="F" group by e.emp_no)
select sum(case when c2.max_salary>c1.avg_salary then 1 else 0 end) as f_highest_salary from employees e join cte2 c2
on e.emp_no=c2.emp_no join cte1 c1;
use workers;

with cte1 as
(select avg(salary) as avg_salary from salaries),
cte2 as(
select e.emp_no,max(s.salary) as max_salary from employees e join salaries s on s.emp_no=e.emp_no and e.gender="F" group by e.emp_no)
select sum(case when c2.max_salary>c1.avg_salary then 1 else 0 end) as f_highest_salary from employees e join cte2 c2
on e.emp_no=c2.emp_no join cte1 c1;

with cte1 as (
    select avg(salary) as avg_salary from salaries
),
cte2 as (
    select e.emp_no, max(s.salary) as max_salary 
    from employees e 
    join salaries s on s.emp_no = e.emp_no 
    and e.gender = "F" 
    group by e.emp_no
)
select sum(case when c2.max_salary > c1.avg_salary then 1 else 0 end) as f_highest_salary, count(c2.emp_no) as no_of_fe_employees,round(sum(case when c2.max_salary > c1.avg_salary then 1 else 0 end)/count(c2.emp_no)*100,2) as percentage
from cte2 c2 
join cte1 c1;
-- Exercise 1 --
with cte1 as(
select avg(salary) as avg_salary from salaries),
cte2 as(
select s.emp_no,max(s.salary) as max_salary from salaries s join employees e on e.emp_no=s.emp_no and e.gender="M" group by s.emp_no)
select sum(case when c2.max_salary<c1.avg_salary then 1 else 0 end) as sum_f_less_than_avg from cte1 c1 join cte2 c2;

with cte1 as(
select avg(salary) as avg_salary from salaries),
cte2 as(
select s.emp_no,max(s.salary) as max_salary from salaries s join employees e on e.emp_no=s.emp_no and e.gender="M" group by e.emp_no)
select count(case when c2.max_salary<c1.avg_salary then c2.max_salary else null end) as count_f_less_than_avg from cte2 c2 join cte1 c1;

with cte1 as(
select avg(salary) as avg_salary from salaries),
cte2 as(
select count(salary) as total_no_of_salary_contracts from salaries)
select sum(case when s.salary>c1.avg_salary then 1 else 0 end) as no_m_salaries_above_avg,(select total_no_of_salary_contracts from cte2) as total_no_of_salary_contracts from employees e join salaries s on e.emp_no=s.emp_no and e.gender="M" join cte1 c1;
create temporary table female_highest_salary
select s.emp_no,max(s.salary) from salaries s join employees e on e.emp_no=s.emp_no and e.gender="F" group by s.emp_no;
select * from female_highest_salary;

create temporary table male_max_salaries
select s.emp_no,max(s.salary) from salaries s join employees e on e.emp_no=s.emp_no where e.gender="M" group by e.emp_no;

create temporary table male_min_salaries
select s.emp_no,min(s.salary) as min_salary from employees e join salaries s on e.emp_no=s.emp_no and e.gender="M" group by e.emp_no;
CREATE TEMPORARY TABLE dates
select 
now() as current_t,
date_sub(now(),interval 1 month) as one_month_earlier,
date_sub(now(),interval -1 year) as one_year_later;
SELECT * FROM dates;
drop table if exists dates;
create temporary table dates
select now() as current_date,
date_sub(now(),interval 2 month) 2_m_earlier,
date_sub(now(),interval -2 year) 2_y_earlier;

create temporary table salaries_adjusted_for_inflation as
select emp_no,salary,round(case when from_date between "1970-01-01" and "1989-01-01" then salary*6.5 when from_date between "1990-01-01" and "1999-01-31" then salary*2.8 else salary*3 end) as inflation_adjusted_salary, from_date,to_date from salaries;
select * from salaries_adjusted_for_inflation;
use workers;