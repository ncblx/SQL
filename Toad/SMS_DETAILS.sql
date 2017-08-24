/* Formatted on 29/10/2013 11:18:19 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM AFON_SMS40.IN_SMS_COPM_DETAILS
   WHERE SMS_FD BETWEEN TO_DATE ('01.03.2015', 'dd.mm.yyyy') 
         AND SYSDATE
         --AND TO_DATE ('08.09.2014', 'dd.mm.yyyy') 
         --AND DESTINATION_ADDRESS = '1.1.994772713043'
         --AND DESTINATION_ADDRESS like '1.1.994702011328'
         AND SOURCE_ADDRESS = '1.1.994774830338'
         --AND SOURCE_ADDRESS in ('1.1.994554301504', '1.1.994505572393', '1.1.994702348470')
         --AND SOURCE_ADDRESS = '0.1.711'
         --AND SOURCE_ADDRESS = '5.0.RalphLauren'
         --AND SOURCE_ADDRESS like '%.9191'
ORDER BY sms_fd desc


/* Formatted on 07.11.2012 14:43:03 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM AFON_SMS40.IN_SMS_COPM_DETAILS
   WHERE     sms_fd BETWEEN 
   TO_DATE ('13.10.2013', 'dd.mm.yyyy') 
    -- sysdate -1
       AND SYSDATE
         --AND TO_DATE('23.02.2013', 'dd.mm.yyyy')
         --AND destination_address = '1.1.994703066540'
         --AND source_address in  ('1.1.994702323194', '1.1.994706476885', '1.1.994707314174','1.1.994705068608', '1.1.994709496355', '1.1.994703523166')
         AND destination_address in  ('1.1.994705401755', '1.1.994703438848', '1.1.994703979454', '1.1.994773260955', '1.1.994702771718', '1.1.994705322910')
         --AND destination_address = '1.1.994707120219'
         --AND source_address = '1.1.994706305885'
         AND status = '3'
ORDER BY sms_fd desc 