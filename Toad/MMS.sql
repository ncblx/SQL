/* Formatted on 17.12.2015 16:06:13 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM ssc_br
   WHERE fd BETWEEN TO_DATE ('17.12.2015 11.20.00', 'dd.mm.yyyy HH24.MI.SS')
                AND sysdate /*TO_DATE ('11.12.2015 10.40.59', 'dd.mm.yyyy HH24.MI.SS')*/
--and src_addr not like '+9947%' and  src_addr not like '+9945%'
and (vaspin is not null or vaspout is not null and vaspout != 'Deny')
--and src_addr like '%994554583805'
--and r_ses_n like '%T15185671b99'
ORDER BY fd DESC;


/* Formatted on 18.12.2015 15:29:22 (QP5 v5.227.12220.39754) */
SELECT *
  FROM ssc_br
 WHERE     /*(:MaxRowNumber >= n)
       AND (n >= :MinRowNumber)
       AND */ssc_upload_n = 0
       AND ci = 1*
       AND dst_addr NOT LIKE '%MAILER-DAEMON%'
       AND src_addr NOT LIKE '%MAILER-DAEMON%';
       
       

SELECT *
    FROM MMS.SSC_BR
    where fd between sysdate-1 and sysdate
    order by fd desc
    
    
    
    SELECT *
    FROM MMS.MMS_STAT
    where CREATION_TIME between sysdate-1 and sysdate
    order by CREATION_TIME desc


/* Formatted on 27/10/2014 10:08:39 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM AFON_MMS_40.MMS_STAT
   WHERE     creation_time BETWEEN TO_DATE ('01.02.2015', 'dd.mm.yyyy')
         AND SYSDATE
         AND dst = '1.1.994776479015'
         --AND dst = '1.1.994703181808'
         --AND src like '%3018'
ORDER BY creation_time DESC


/* Formatted on 09.10.2012 13:45:16 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM AFON_MMS_40.MMS_STAT
   WHERE src = '1.1.994709280717'
         AND creation_time BETWEEN TO_DATE ('10.07.2014', 'dd.mm.yyyy')
                              AND SYSDATE
ORDER BY creation_time DESC


select afon_sms40.errordecode (262272) from dual


SELECT *
    FROM AFON_MMS_40.MMS_STAT
   WHERE src = '1.1.994702011360'
      and creation_time between to_date ('31.10.2012' , 'dd.mm.yyyy') and sysdate
      order by creation_time desc
      
      



  SELECT *
    FROM AFON_MMS_40.MMS_STAT
   WHERE 
          creation_time 
          > SYSDATE - 1
          --between  
          --to_date('01.07.2014 00:00', 'DD.MM.YYYY HH24:MI')
          --and sysdate
          --and src like '1.1.9947%'
          and dst like '%99455%'
          --and status = '5'
ORDER BY creation_time DESC




  SELECT count (*)
    FROM AFON_MMS_40.MMS_STAT
   WHERE 
          creation_time between 
          to_date('01.01.2014 00:00:00', 'DD.MM.YYYY HH24:MI:SS')
          and 
          to_date('31.01.2014 23:59:59', 'DD.MM.YYYY HH24:MI:SS')
          and src like '1.1.9947%'
ORDER BY creation_time DESC



/* Formatted on 04/03/2014 17:39:45 (QP5 v5.227.12220.39754) */
  select creation_time, count(*) from (SELECT TRUNC (creation_time) creation_time
    FROM AFON_MMS_40.MMS_STAT
   WHERE     creation_time BETWEEN TO_DATE ('01.01.2014 00:00:00', 'DD.MM.YYYY HH24:MI:SS')
                               AND TO_DATE ('31.01.2014 23:59:59', 'DD.MM.YYYY HH24:MI:SS')
         AND src LIKE '1.1.9947%'
ORDER BY creation_time DESC)
group by creation_time
order by creation_time desc

/* Formatted on 04/03/2014 18:12:35 (QP5 v5.227.12220.39754) */
  SELECT creation_time, COUNT (*) COUNT
    FROM (  SELECT TRUNC (creation_time) creation_time
              FROM AFON_MMS_40.MMS_STAT
             WHERE     creation_time BETWEEN TO_DATE ('01.01.2014 00:00:00',
                                                      'DD.MM.YYYY HH24:MI:SS')
                                         AND SYSDATE
                   AND src LIKE '1.1.9947%'
                   AND status = '5'
          ORDER BY creation_time DESC)
GROUP BY creation_time
order by creation_time desc



SELECT *
    FROM AFON_MMS_40.MMS_STAT
   WHERE     creation_time > SYSDATE - 1 / 144
         AND src LIKE '%9945%'
         AND status = 5
ORDER BY creation_time DESC

  SELECT *
    FROM AFON_MMS_40.MMS_STAT
   WHERE     creation_time > SYSDATE - 1 / 144
         AND DST LIKE '%9945%'
         AND status = 5
ORDER BY creation_time DESC
