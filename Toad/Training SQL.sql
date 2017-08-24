SELECT * FROM user_tables

select * from EMPLOYEES

select * from DEPARTMENTS

select department_id, department_name, location_id from DEPARTMENTS --viberaem te kolonki kotorie nam nujni

select sysdate from dual

select first_name, salary, salary+100 from employees --pribovlaet v salary +100 i vivodim rezultat do i posle

select first_name, salary, salary+100 New_Salary from employees --pereiminovuem novii stolbec v kotorom pokazivaet rezultat

select first_name, salary, salary+100 "New Salary" from employees --v kovi4kax mi ukazivaem ima s u4etom reestora novoi kolonki

select first_name||' '||last_name from employees --\\ pomogaet obedenat stolbci 

select first_name||' '||last_name "Name" from employees

select * from employees 

select first_name|| ' is a ' || job_id "Info" from employees 

select first_name|| ' it''s a ' || job_id "Info" from employees 

select q'{sdfasdf asd asd as }' from dual

select q'{dslfjasdl aljkda }' from dual 

select distinct department_id, first_name from employees -- operassiya kotoraya udalaet dublikati ili vivodit unikalnie zna4eniya

describe employees 



/* New */

select * from dual

select systimestamp as test from employees 


select * from afon_ip.inet_usr where id='994702000065' and td>sysdate

select * from AFON_IP.INET_SRV where up='4562469' and td>sysdate 

select * from AFON_IP.INET_SRV_ATTR where up='3608436' and td>sysdate

Select last_name, first_name from employees where 'A '||last_name||first_name = 'A King'

Select last_name, first_name from employees where first_name||' '||last_name = last_name||' '||first_name

Select last_name, first_name, job_id from employees where 'SA_REP'||'King' = job_id||last_name

Select last_name, first_name, job_id from employees where job_id||last_name ='SA_REP'||'King'








select round(19.465,2) from dual 

select trim() from dual


select substr('321',2,1) from dual


select (substr('321',1,1))+(substr('321',2,1))+(substr('321',3,1)) "3+2+1=" from dual


select (substr('&&number',1,1))+(substr('&&number',2,1))+(substr('&&number',3,1)) "3+2+1=" from dual


select first_name, replace(first_name, 'a') from employees



select first_name from employees where instr(first_name, 'a')=0 and instr(first_name, 'A')=0


select first_name, replace(lower(first_name), 'a', 'A') from employees



select N from numbers where mod(n,3)=0

select (n/3) from numbers 


select 4/2 from dual



/* Formatted on 18.10.2012 9:41:24 (QP5 v5.163.1008.3004) */  --d/z #1
SELECT first_name,
          SUBSTR (first_name, -1)
       || SUBSTR (first_name, 2, LENGTH (first_name) - 2)
       || SUBSTR (first_name, 1, 1)
  FROM employees
  

select  substr(first_name, 1, instr(lower(first_name), 'a', 1,1)-1)||substr(first_name, instr(lower(first_name), 'a', 1,1)+1) "Result", first_name from employees --d/z #2

select substr(n, '&&K' + 1)|| SUBSTR (N, 1,'&&K') "N-Result", N from numbers; --D/Z #3

select 1 from dual where mod('&a', '&b')=0 --D/Z #4

select substr(n, '&A'*2-1, 2), n from numbers --D/Z #5





select to_char(to_date('&DD.&MM.&YY', 'DD.MM.YYYY'), '"It''s" DD "of" MONTH ,YYYY') from dual  


select first_name, salary, commission_pct, nvl(commission_pct*2*salary, 100)from employees 


/* Formatted on 23.10.2012 19:25:19 (QP5 v5.163.1008.3004) */
SELECT &&K cislo,
       SUBSTR (&&K, 1, 1) pervoe,
       SUBSTR (&&K, -1, 1) vtoroe,
       NVL2 (NULLIF (SUBSTR (&&K, 1, 1), SUBSTR (&&K, -1, 1)), 'no', 'yes')
          result
  FROM DUAL


/* Formatted on 23.10.2012 19:25:05 (QP5 v5.163.1008.3004) */
SELECT &&K cislo,
       SUBSTR (&&K, 1, 1) pervoe,
       SUBSTR (&&K, -1, 1) vtoroe,
       NVL2 (NULLIF (SUBSTR (&&K, 1, 1), SUBSTR (&&K, -1, 1)), 'no', 'yes')
          result,
       CASE NVL (NULLIF (SUBSTR (&&K, 1, 1), SUBSTR (&&K, -1, 1)), 0)
          WHEN '0' THEN 'yes'
          ELSE 'no'
       END
          result2
  FROM dual



/* Formatted on 23.10.2012 19:34:45 (QP5 v5.163.1008.3004) */
SELECT &&K1,
       &&K2,
       CASE
          WHEN &&K1 > &&k2 THEN 'pervoe bolwe vtorogo'
          WHEN &&K1 < &&K2 THEN 'pervoe menwe vtorogo'
          ELSE 'oni ravni'
       END
          result
  FROM DUAL


select * from employees

select substr(first_name, 0,1), count(substr(first_name, 0, 1)) from employees group by substr(first_name, 0,1) order by 1


select substr(first_name, 0,1), count(*) from employees group by substr(first_name, 0,1) order by 1

select * from emp

select DEPARTMENT_ID, sum(salary)/count(salary) from emp group by DEPARTMENT_ID order by 2

select first_name, salary from emp having salary=max(salary) group by salary order by 2 desc 

select salary from emp where salary < max(salary)

select max(salary) from emp order by 1 desc



/* Formatted on 13.12.2012 15:16:08 (QP5 v5.227.12220.39754) */
  SELECT c1.city, COUNT (*)
    FROM employees a1
         JOIN departments b1 ON (a1.DEPARTMENT_ID = b1.DEPARTMENT_ID)
         JOIN
         locations c1
            ON     (b1.location_id = c1.location_id)
               AND commission_pct IS NOT NULL
               AND city = 'Oxford'
GROUP BY c1.city

/* Formatted on 13.12.2012 15:50:47 (QP5 v5.227.12220.39754) */
  SELECT a1.first_name || ' ' || a1.last_name Rabotnik,
         a1.Salary Rab,
         a1.manager_id,
         b1.employee_id,
         b1.first_name || ' ' || b1.last_name Manager,
         b1.Salary Man,
         (b1.salary - a1.salary) Raznisa
    FROM employees a1 JOIN employees b1
   on a1.manager_id = b1.employee_id
ORDER BY 3

/* Formatted on 13.12.2012 16:13:50 (QP5 v5.227.12220.39754) */
/*vivesti rabotnikov i magaerov s job_id Programmer*/
  SELECT a1.first_name || ' ' || a1.last_name Rabotnik,
         a1.job_id,
         b1.first_name || ' ' || b1.last_name Manager,
         b1.job_id
    FROM employees a1  JOIN employees b1
   on     a1.manager_id = b1.employee_id
         where a1.job_id = 'IT_PROG'
         AND b1.job_id = 'IT_PROG'
ORDER BY 2

/* Formatted on 13.12.2012 16:39:27 (QP5 v5.227.12220.39754) */
SELECT a1.first_name || ' ' || a1.last_name Rabotnik,
       a2.first_name || ' ' || a2.last_name Manager
  FROM employees a1
       JOIN employees a2 ON a1.manager_id = a2.employee_id
       JOIN departments b1 ON a1.department_id = b1.department_id
       JOIN locations c1 ON b1.location_id = c1.location_id
 WHERE city = 'London'
 SELECT model, price FROM PC WHERE model = (SELECT model FROM Product WHERE maker = 'B' AND type = 'PC') UNION SELECT model, price FROM Laptop WHERE model = (SELECT model FROM Product WHERE maker = 'B' AND type = 'Laptop') UNION SELECT model, price FROM Printer WHERE model = (SELECT model FROM Product WHERE maker = 'B' AND type = 'Printer')