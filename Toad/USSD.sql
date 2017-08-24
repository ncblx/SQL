/* Formatted on 07.11.2012 22:10:08 (QP5 v5.163.1008.3004) */
SELECT *
  FROM AFON.USSD_LOG
 WHERE strt BETWEEN TO_DATE ('20.03.2015', 'dd.mm.yyyy')
       AND SYSDATE
       AND mob_num = '772771487'
       --AND NMRB = '164'
       --AND mob_num IN (707372626, 705140112, 709592588, 705149194, 703111975) 
       --AND request LIKE '%10'
       --AND request = '0'
       ORDER
 BY strt DESC
 
 
 /* Formatted on 28.02.2013 17:37:55 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM AFON.USSD_LOG
   WHERE     strt BETWEEN TO_DATE ('01.03.2013', 'dd.mm.yyyy') 
         AND SYSDATE
         --AND mob_num = '777501150'
         --AND request LIKE '%050%'
         --AND nmrb='790'
ORDER BY strt DESC

/* Formatted on 09.02.2013 0:53:39 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM AFON.USSD_LOG
   WHERE nmrb = '790' AND answer LIKE '%DBERROR' AND strt > SYSDATE - 1 / 144
ORDER BY strt DESC


/* Formatted on 09.02.2013 0:53:39 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM AFON.USSD_LOG
   WHERE strt > SYSDATE - 1 / 144
ORDER BY strt DESC


 
select count(*) from afon.ussd_log where strt between sysdate  -1/144 and sysdate and request like '%11%' and answer like '%BADPINC%' order by strt desc

select * from afon.ussd_log where strt between sysdate  -1/144 and sysdate and request like '%11%' and answer like '%BADPINC%' order by strt desc

select * from afon.ussd_log where strt between sysdate -1/144 and sysdate order by strt desc


SELECT COUNT (*) AS count_ 
FROM afon.ussd_log 
WHERE answer LIKE '%Sorry, your query could not be processed%' 
AND strt > SYSDATE - 1 / 144

/* Formatted on 11.03.2013 14:46:22 (QP5 v5.227.12220.39754) */
SELECT *
  FROM afon.ussd_log
 WHERE     strt BETWEEN SYSDATE -1  / 144 AND SYSDATE
       AND answer LIKE '%Sorry, your query%'
       order by strt desc


/* Formatted on 20/10/2014 13:18:26 (QP5 v5.227.12220.39754) */
  SELECT machine, program, COUNT (program)
    FROM afon.ussd_log
   WHERE     strt BETWEEN SYSDATE - 1 / 144 AND SYSDATE
         AND answer LIKE '%Sorry, your query%'
GROUP BY machine, program
ORDER BY machine DESC


/* Formatted on 20/10/2014 13:18:26 (QP5 v5.227.12220.39754) */
  SELECT machine, program, COUNT (program)
    FROM afon.ussd_log
   WHERE     strt BETWEEN SYSDATE - 1 / 144 AND SYSDATE
         AND answer LIKE '%BADPINC%'
GROUP BY machine, program
ORDER BY 3 DESC