/* Formatted on 08.10.2012 10:53:15 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM afon_sms40.short_num
   WHERE sms_fd BETWEEN TO_DATE ('06.03.2015', 'dd.mm.yyyy') 
         --AND TO_DATE ('01.04.2013', 'dd.mm.yyyy')
         AND SYSDATE
         AND destination_address IN  ('1.1.994704385828', '0.1.757')
         AND source_address IN ('1.1.994704385828',  '0.1.757')
         --AND destination_address = '0.1.757'
         --AND source_address='0.1.757'
         --AND text like '%552009292%'
         --AND text like '%Service has been successfully added. Sorry, the database can%'
         --AND STATUS = '5'
ORDER BY sms_fd DESC


/* Formatted on 08.10.2012 10:53:15 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM afon_sms40.short_num
   WHERE sms_fd BETWEEN TO_DATE ('01.03.2015', 'dd.mm.yyyy') 
         AND SYSDATE
         --AND TO_DATE ('16.08.2013', 'dd.mm.yyyy') 
         AND destination_address = '1.1.994774780191'
         --AND destination_address = '0.1.757'
         --OR source_address = '0.1.757'
         ---AND source_address = '0.1.717'
         --AND source_address ='1.1.994772192836'
         AND source_address like '%.777'
         --AND text like '%552009292%'
         --AND text like '%nezerinize chatdirmaq isterdim ki%'
         --AND destination_address in ('1.1.994705401755', '1.1.994703438848')
         --AND status = 5
ORDER BY sms_fd DESC


/* Formatted on 08.10.2012 10:53:15 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM afon_sms40.short_num
   WHERE sms_fd BETWEEN TO_DATE ('04.07.2013', 'dd.mm.yyyy') AND SYSDATE
         AND destination_address='1.1.994702011360'
         --AND source_address='1.1.99706843257'
         --AND text like '%552009292%'
         --AND text like '%Credit%'
ORDER BY sms_fd DESC


/* Formatted on 28.11.2012 9:48:13 (QP5 v5.163.1008.3004) */
  SELECT TO_CHAR (sms_id),
         sms_fd,
         src_addr,
         dst_addr,
         text,
         status
    FROM afon_sms40.tmp_bulk_sms
   WHERE src_port = 'azericard' AND DST_ADDR = '1.1.994559096633'
ORDER BY SMS_FD DESC


/* Formatted on 04.12.2012 10:38:00 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM AFON_SMS40.IN_SMS_COPM_INTRANET
   WHERE trunc_sms_fd BETWEEN TO_DATE ('11.03.2013', 'DD.MM.YYYY') 
         AND SYSDATE
         --AND TO_DATE('28.02.2013', 'dd.mm.yyyy')
         AND destination_address = '994706529289'
         --AND source_address='994773867676'
ORDER BY trunc_sms_fd DESC



/* Formatted on 24.12.2012 11:57:45 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM AFON_SMS40.TMP_BULK_SMS
   WHERE     sms_fd BETWEEN ADD_MONTHS (SYSDATE, -1) AND SYSDATE
         AND dst_addr = '1.1.994552699191'
ORDER BY 2 desc


