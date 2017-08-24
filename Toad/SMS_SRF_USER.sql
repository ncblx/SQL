/* Formatted on 25.06.2014 13:16:01 (QP5 v5.227.12220.39754) */
SELECT *
    FROM MESSAGE_LOG
        WHERE insert_date BETWEEN TO_DATE ('12.01.2017 00.00.00', 'dd.mm.yyyy HH24.MI.SS') 
        AND 
        --SYSDATE
        TO_DATE ('12.01.2017 23.59.59', 'dd.mm.yyyy HH24.MI.SS') 
        AND DESTINATION_ADDRESS LIKE '%.994709212843'
        --AND SOURCE_ADDRESS LIKE '%.994706183898'
        --AND SOURCE_ADDRESS NOT LIKE '1.1.%'
        --AND DESTINATION_ADDRESS IN ('0.1.757', '1.1.994772114040')
        --AND SOURCE_ADDRESS IN ('0.1.757', '1.1.994772114040')
        --AND MESSAGE_ID is NOT NULL
        --AND MESSAGE_TEXT IS NOT NULL
        --AND MESSAGE_TEXT like 'test%'
        --AND lower (MESSAGE_TEXT) like '%hesabiniza odenis qebul%'
        --AND to_char(MESSAGE_ID)='2513440816856729'
        --AND ESME_ID = 'softline'
        --AND TRANSACTION_TYPE = 1
        ORDER BY insert_date DESC;
        
        
/* Formatted on 06.10.2016 11:09:18 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM ROUTER_SMS_LOG
   WHERE     DESTINATION_ADDRESS = '1.1.994702350501'
         AND SOURCE_ADDRESS NOT LIKE '1.1.%'
         --AND SOURCE_ADDRESS = '5.0.Bakcell'
ORDER BY 1 DESC;


        
SELECT * 
    FROM SRF_USER.MESSAGE_LOG_DETAILS
    WHERE insert_date BETWEEN TO_DATE ('01.06.2015', 'dd.mm.yyyy') 
        AND SYSDATE 
        AND DESTINATION_ADDRESS = '1.1.972542395505'
        --AND SOURCE_ADDRESS = '1.1.994708977513'
        --AND SOURCE_ADDRESS LIKE '%.702'
        --AND LAST_RESULT_CODE = 34
        ORDER BY insert_date DESC
        
        
        
        
SELECT to_char(message_id), a.*
    FROM SRF_USER.MESSAGE_LOG_DETAILS a
    WHERE insert_date BETWEEN TO_DATE ('15.01.2015', 'dd.mm.yyyy') 
        AND SYSDATE
        --AND DESTINATION_ADDRESS = '1.1.994776011535'
        AND SOURCE_ADDRESS = '1.1.994702011360'
        ORDER BY insert_date DESC
        


SELECT *
    FROM SRF_USER.ROUTER_SMS_LOG
    WHERE SMS_FD BETWEEN TO_DATE ('01.05.2015', 'dd.mm.yyyy') 
        AND SYSDATE
        --AND DESTINATION_ADDRESS ='1.1.994772713043'
        --AND DESTINATION_ADDRESS LIKE '%.9091'
        --AND SOURCE_ADDRESS = '1.1.994702011360'
        --AND SOURCE_ADDRESS in ('1.1.994554301504', '1.1.994505572393', '1.1.994702348470')
        --AND SOURCE_ADDRESS LIKE '%.757'
        AND DESTINATION_ADDRESS IN ('1.1.994704305055', '0.1.757')
        AND SOURCE_ADDRESS IN ('1.1.994704305055', '0.1.757')
        --AND TEXT like '%Skype%'
        --AND MESSAGE_ID is NOT NULL
        --AND MESSAGE_TEXT IS NOT NULL
        --AND to_char(MESSAGE_ID)='2513440816856729'
        ORDER BY SMS_FD DESC
        
        
        
SELECT * 
    FROM SRF_USER.ERROR_CODES
    WHERE CODE = 200