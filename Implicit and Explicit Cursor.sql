//Praticed in Pl/SQL Developer Editor

//implicit Cursors

//using SQL%ROWCOUNT 

//Used for increase the salary of each customer by 500

//output before 


Select * from customers;  

+----+----------+-----+-----------+----------+ 
| ID | NAME     | AGE | ADDRESS   | SALARY   | 
+----+----------+-----+-----------+----------+ 
|  1 | Ramesh   |  32 | Ahmedabad |  2000.00 | 
|  2 | Khilan   |  25 | Delhi     |  1500.00 | 
|  3 | kaushik  |  23 | Kota      |  2000.00 | 
|  4 | Chaitali |  25 | Mumbai    |  6500.00 | 
|  5 | Hardik   |  27 | Bhopal    |  8500.00 | 
|  6 | Komal    |  22 | MP        |  4500.00 | 
+----+----------+-----+-----------+----------+

DECLARE  
   total_rows number(2); 
BEGIN 
   UPDATE customers 
   SET salary = salary + 500; 
   IF sql%notfound THEN 
      dbms_output.put_line('no customers selected'); 
   ELSIF sql%found THEN 
      total_rows := sql%rowcount;
      dbms_output.put_line( total_rows || ' customers selected '); 
   END IF;  
END; 
/   

//output after :

Select * from customers;  

+----+----------+-----+-----------+----------+ 
| ID | NAME     | AGE | ADDRESS   | SALARY   | 
+----+----------+-----+-----------+----------+ 
|  1 | Ramesh   |  32 | Ahmedabad |  2500.00 | 
|  2 | Khilan   |  25 | Delhi     |  2000.00 | 
|  3 | kaushik  |  23 | Kota      |  2500.00 | 
|  4 | Chaitali |  25 | Mumbai    |  7000.00 | 
|  5 | Hardik   |  27 | Bhopal    |  9000.00 | 
|  6 | Komal    |  22 | MP        |  5000.00 | 
+----+----------+-----+-----------+----------+


// Explicit Cursor

//Used for allocate memory for gaing control over the contex area

DECLARE 
   c_id customers.id%type; 
   c_name customers.name%type; 
   c_addr customers.address%type; 
   CURSOR c_customers is 
      SELECT id, name, address FROM customers; 
BEGIN 
   OPEN c_customers; 
   LOOP 
   FETCH c_customers into c_id, c_name, c_addr; 
      EXIT WHEN c_customers%notfound; 
      dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_addr); 
   END LOOP; 
   CLOSE c_customers; 
END; 
/

// output Explicit Cursor

Select * from customers;  

+----+----------+-----+-----------+----------+ 
| ID | NAME     | AGE | ADDRESS   | SALARY   | 
+----+----------+-----+-----------+----------+ 
|  1 | Ramesh   |  32 | Ahmedabad |  2500.00 | 
|  2 | Khilan   |  25 | Delhi     |  2000.00 | 
|  3 | kaushik  |  23 | Kota      |  2500.00 | 
|  4 | Chaitali |  25 | Mumbai    |  7000.00 | 
|  5 | Hardik   |  27 | Bhopal    |  9000.00 | 
|  6 | Komal    |  22 | MP        |  5000.00 | 
+----+----------+-----+-----------+----------+


//Select with the INNER JOIN clause and set the cur_chief cursor to this result set

CURSOR cur_chief
IS
  SELECT
    first_name, last_name, department_name
  FROM
    employees e
  INNER JOIN departments d ON d.manager_id = e.employee_id;



// printing a list of chief and name of departments as follows

SET SERVEROUTPUT ON SIZE 1000000;
DECLARE
  -- declare a cursor
  CURSOR cur_chief IS
      SELECT first_name,
             last_name,
             department_name
      FROM employees e
      INNER JOIN departments d ON d.manager_id = e.employee_id;

  r_chief cur_chief%ROWTYPE;
BEGIN
  OPEN cur_chief;
  LOOP
    -- fetch information from cursor into record
    FETCH cur_chief INTO r_chief;

    EXIT WHEN cur_chief%NOTFOUND;

    -- print department - chief
    DBMS_OUTPUT.PUT_LINE(r_chief.department_name || ' - ' ||
                         r_chief.first_name || ',' ||
                         r_chief.last_name);
  END LOOP;
  -- close cursor cur_chief
  CLOSE cur_chief;
END;
/