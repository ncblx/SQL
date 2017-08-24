ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI:SS';

EXEC SYS.PKG_VLADS_APP_CONTEXT.SET_FROM_DATE(SYSDATE - 1/24);

EXEC SYS.PKG_VLADS_APP_CONTEXT.SET_TO_DATE(SYSDATE); 

/* Formatted on 14.05.2013 11:32:56 (QP5 v5.227.12220.39754) */
SELECT *
  FROM AFON_SMS40.SHORT_NUM_DYNAMIC
 WHERE (   text = 'Sorry, your query could not be processed'
        OR text =
              'К сожалению, база данных находится на профилактике.'
        OR text LIKE 'K sozhaleniyu, baza danny%')
        
        
        
        
        
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI:SS'; 

EXEC SYS.PKG_VLADS_APP_CONTEXT.SET_FROM_DATE(SYSDATE - 1/48); 

EXEC SYS.PKG_VLADS_APP_CONTEXT.SET_TO_DATE(SYSDATE); 

SELECT * FROM AFON_SMS40. SHORT_NUM_DYNAMIC WHERE 
sms_fd between sysdate -1/1440 and sysdate
and (text = 'Sorry, your query could not be processed' 
OR text = 
'К сожалению, база данных находится на профилактике.' 
OR text LIKE 'K sozhaleniyu, baza danny%') 
order by sms_fd desc; 




/* Formatted on 23/02/2015 11:54:41 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM AFON_SMS40.SHORT_NUM
   WHERE     sms_fd BETWEEN SYSDATE - 1 / 144 AND SYSDATE
         AND (   text = 'Sorry, your query could not be processed'
              OR text =
                    'К сожалению, база данных находится на профилактике.'
              OR text LIKE 'K sozhaleniyu, baza danny%')
ORDER BY sms_fd DESC; 