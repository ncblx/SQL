/* Formatted on 10/12/2012 2:59:11 PM (QP5 v5.163.1008.3004) */
SELECT /*full(a) full(b)*/COUNT (text)
  FROM afon_sms40.in_sms_copm_details a, afon_sms40.in_sms_copm b
WHERE     a.sms_id = b.sms_id
       AND a.sms_fd BETWEEN SYSDATE - 1 / 24 / 6 AND SYSDATE
       AND b.sms_fd BETWEEN SYSDATE - 1 / 24 / 6 AND SYSDATE
       AND (text = 'Sorry, your query could not be processed'
            OR text =
                  'К сожалению, база данных находится на профилактике.'
            OR text LIKE 'K sozhaleniyu, baza danny%')
            
            
            
/* Formatted on 19.11.2012 11:38:12 (QP5 v5.163.1008.3004) */
SELECT *
  FROM AFON_SMS40.SHORT_NUM_DYNAMIC
 WHERE (text = 'Sorry, your query could not be processed'
        OR text =
              'К сожалению, база данных находится на профилактике.'
        OR text LIKE 'K sozhaleniyu, baza danny%')
       
       
       
       
       

SELECT * FROM AFON_SMS40.IN_MSG_INCOMING_ERROR

Select * from AFON_SMS40.SHORT_NUM
