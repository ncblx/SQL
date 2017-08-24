select * from ROUTER_SMS_LOG
where DESTINATION_ADDRESS = '1.1.994703236212'
--and SOURCE_ADDRESS not like '1.1.%'
--and lower (SOURCE_ADDRESS)  like '%uber%'
order by SMS_FD desc


/* Formatted on 27.09.2016 16:29:27 (QP5 v5.227.12220.39754) */
  SELECT DECODE (ESME_ID, '118MSX', '118')
    FROM MESSAGE_LOG
   WHERE     insert_date BETWEEN TO_DATE ('17.06.2016 00.00.00',
                                          'dd.mm.yyyy HH24.MI.SS')
                             AND --SYSDATE
                                 TO_DATE ('17.06.2016 23.59.59',
                                          'dd.mm.yyyy HH24.MI.SS')
         --AND DESTINATION_ADDRESS LIKE '%.994703991982'
         --AND SOURCE_ADDRESS LIKE '0.1.%'
         --AND DESTINATION_ADDRESS IN ('0.1.2014', '1.1.994702650001')
         --AND SOURCE_ADDRESS IN ('0.1.2014', '1.1.994702650001')
         --AND MESSAGE_ID is NOT NULL
         --AND MESSAGE_TEXT IS NOT NULL
         --AND MESSAGE_TEXT like '%Muracietinizle bagli bildirmek isterdik ki%'
         --AND to_char(MESSAGE_ID)='2513440816856729'
         AND ESME_ID = '118MSX'
--AND TRANSACTION_TYPE = 1
ORDER BY insert_date DESC;


/* Formatted on 27.09.2016 16:29:47 (QP5 v5.227.12220.39754) */
  SELECT DECODE (ESME_ID,
                 '118MSX', '118',
                 'xx8msx', '118',
                 '4rcom', 'MT services',
                 'psb', 'Pasha Bank',
                 'bankstd2', 'Bank Standart',
                 ----    'begoc', 'Baku2015',
                 'corpclients', 'Baku2015',
                 'aztlcm', 'Azertelekom',
                 'aztlcm2', 'Azertelekom',
                 'aztelkom1', 'AZTELEKOM',
                 'bankstd', 'Bank Standart',
                 'smrtbnknew', 'Bank Standart',
                 'emobile', 'Emobile',
                 'gmsubulk', 'GMSU ',
                 'mcqs', 'MCQS',
                 'nms', 'Navigator',
                 'n0vamedia2', 'Novamedia',
                 'azericard', 'Now SMS',
                 'nowsms', 'Now SMS',
                 'fresh', 'Oxtel',
                 'bob', 'Bank of Baku',
                 'millicard', 'Millicard',
                 'nmsbulk', 'Navigator',
                 'softline', 'Softline',
                 'softline2', 'Softline',
                 'voidaint', 'Voida',
                 'zed', 'ZED',
                 'azerikom', 'Azericom',
                 'bamboo', 'Bamboo',
                 'ELSE')
            AS CP,
         SOURCE_ADDRESS,
         ESME_ID,
         COUNT (DISTINCT (MESSAGE_ID)) AS COUNT
    FROM MESSAGE_LOG
   WHERE     insert_date BETWEEN TO_DATE ('01.06.2016 00.00.00',
                                          'dd.mm.yyyy HH24.MI.SS')
                             AND TO_DATE ('30.06.2016 23.59.59',
                                          'dd.mm.yyyy HH24.MI.SS')
         AND esme_id IN
                ('118MSX',
                 '4rcom',
                 'azericard',
                 'azerikom',
                 'bamboo',
                 'bob',
                 'fresh',
                 'gmsubulk',
                 'mcqs',
                 'millicard',
                 'n0vamedia2',
                 'nms',
                 'novamedia',
                 'novamedia',
                 'psb',
                 'softline',
                 'softline2',
                 'vialink',
                 'voidaint2',
                 'xx8msx',
                 'zed')
         --AND ESME_ID = '118MSX'
         AND TRANSACTION_TYPE = 1
GROUP BY DECODE (ESME_ID,
                 '118MSX', '118',
                 'xx8msx', '118',
                 '4rcom', 'MT services',
                 'psb', 'Pasha Bank',
                 'bankstd2', 'Bank Standart',
                 ----    'begoc', 'Baku2015',
                 'corpclients', 'Baku2015',
                 'aztlcm', 'Azertelekom',
                 'aztlcm2', 'Azertelekom',
                 'aztelkom1', 'AZTELEKOM',
                 'bankstd', 'Bank Standart',
                 'smrtbnknew', 'Bank Standart',
                 'emobile', 'Emobile',
                 'gmsubulk', 'GMSU ',
                 'mcqs', 'MCQS',
                 'nms', 'Navigator',
                 'n0vamedia2', 'Novamedia',
                 'azericard', 'Now SMS',
                 'nowsms', 'Now SMS',
                 'fresh', 'Oxtel',
                 'bob', 'Bank of Baku',
                 'millicard', 'Millicard',
                 'nmsbulk', 'Navigator',
                 'softline', 'Softline',
                 'softline2', 'Softline',
                 'voidaint', 'Voida',
                 'zed', 'ZED',
                 'azerikom', 'Azericom',
                 'bamboo', 'Bamboo',
                 'ELSE'),
         SOURCE_ADDRESS,
         ESME_ID;
         
         
         
        /* Formatted on 27.09.2016 16:31:30 (QP5 v5.227.12220.39754) */
  SELECT DISTINCT md.DESTINATION_ADDRESS, md.LAST_RESULT_CODE
    FROM SRF_USER.MESSAGE_LOG_details md
   WHERE     md.insert_date BETWEEN TO_DATE ('12.09.2016 00.00.00',
                                             'dd.mm.yyyy HH24.MI.SS')
                                AND                                  --SYSDATE
                                   TO_DATE ('12.09.2016 23.59.59',
                                            'dd.mm.yyyy HH24.MI.SS')
         AND EXISTS
                (SELECT m.DESTINATION_ADDRESS
                   FROM SRF_USER.MESSAGE_LOG m
                  WHERE     m.insert_date BETWEEN TO_DATE (
                                                     '12.09.2016 00.00.00',
                                                     'dd.mm.yyyy HH24.MI.SS')
                                              AND TO_DATE (
                                                     '12.09.2016 23.59.59',
                                                     'dd.mm.yyyy HH24.MI.SS')
                        AND m.ESME_ID = 'zed_bulk'
                        AND m.MESSAGE_TEXT LIKE 'Qurban Bayraminiz mubarek!%'
                        AND m.TRANSACTION_TYPE = 2)
         AND md.ESME_ID = 'zed_bulk'
         AND md.MESSAGE_TEXT LIKE 'Qurban Bayraminiz mubarek!%'
         AND md.FORWARD_TO IS NULL
--AND TRANSACTION_TYPE = 0
ORDER BY 1;

/* Formatted on 27.09.2016 16:31:51 (QP5 v5.227.12220.39754) */
  SELECT COUNT (LAST_RESULT_CODE) AS COUNT,
         LAST_RESULT_CODE,
         (SELECT Description
            FROM srf_user.ERROR_CODES
           WHERE code = LAST_RESULT_CODE)
            AA
    FROM (  SELECT DISTINCT md.DESTINATION_ADDRESS, md.LAST_RESULT_CODE
              FROM SRF_USER.MESSAGE_LOG_details md
             WHERE     md.insert_date BETWEEN TO_DATE ('12.09.2016 00.00.00',
                                                       'dd.mm.yyyy HH24.MI.SS')
                                          AND                        --SYSDATE
                                             TO_DATE ('12.09.2016 23.59.59',
                                                      'dd.mm.yyyy HH24.MI.SS')
                   AND EXISTS
                          (SELECT m.DESTINATION_ADDRESS
                             FROM SRF_USER.MESSAGE_LOG m
                            WHERE     m.insert_date BETWEEN TO_DATE (
                                                               '12.09.2016 00.00.00',
                                                               'dd.mm.yyyy HH24.MI.SS')
                                                        AND TO_DATE (
                                                               '12.09.2016 23.59.59',
                                                               'dd.mm.yyyy HH24.MI.SS')
                                  AND m.ESME_ID = 'zed_bulk'
                                  AND m.MESSAGE_TEXT LIKE
                                         'Qurban Bayraminiz mubarek!%'
                                  AND m.TRANSACTION_TYPE = 2)
                   AND md.ESME_ID = 'zed_bulk'
                   AND md.MESSAGE_TEXT LIKE 'Qurban Bayraminiz mubarek!%'
                   AND md.FORWARD_TO IS NULL
          --AND TRANSACTION_TYPE = 0
          ORDER BY 1)
GROUP BY LAST_RESULT_CODE
ORDER BY 1 DESC;



/* Formatted on 22.09.2016 14:31:46 (QP5 v5.227.12220.39754) */
  SELECT COUNT (md.LAST_RESULT_CODE) AS COUNT,
         md.LAST_RESULT_CODE,
         DECODE (md.LAST_RESULT_CODE,
                 md.LAST_RESULT_CODE, (SELECT Description
                                         FROM srf_user.ERROR_CODES
                                        WHERE code = LAST_RESULT_CODE))
            aa
    FROM SRF_USER.MESSAGE_LOG_details md
   WHERE     md.insert_date BETWEEN TO_DATE ('12.09.2016 00.00.00',
                                             'dd.mm.yyyy HH24.MI.SS')
                                AND                                  --SYSDATE
                                   TO_DATE ('12.09.2016 23.59.59',
                                            'dd.mm.yyyy HH24.MI.SS')
         AND EXISTS
                (SELECT DISTINCT m.DESTINATION_ADDRESS
                   FROM SRF_USER.MESSAGE_LOG m
                  WHERE     m.insert_date BETWEEN TO_DATE (
                                                     '12.09.2016 00.00.00',
                                                     'dd.mm.yyyy HH24.MI.SS')
                                              AND TO_DATE (
                                                     '12.09.2016 23.59.59',
                                                     'dd.mm.yyyy HH24.MI.SS')
                        AND m.ESME_ID = 'zed_bulk'
                        AND m.MESSAGE_TEXT LIKE 'Qurban Bayraminiz mubarek!%'
                        AND m.TRANSACTION_TYPE = 1)
         AND md.ESME_ID = 'zed_bulk'
         AND md.MESSAGE_TEXT LIKE 'Qurban Bayraminiz mubarek!%'
         AND md.FORWARD_TO IS NULL
--AND TRANSACTION_TYPE = 0
GROUP BY md.LAST_RESULT_CODE
ORDER BY 1 DESC;

/* Formatted on 22.09.2016 12:47:14 (QP5 v5.227.12220.39754) */
  SELECT COUNT (LAST_RESULT_CODE) AS COUNT,
         LAST_RESULT_CODE,
         DECODE (LAST_RESULT_CODE,
                 LAST_RESULT_CODE, (SELECT Description
                                      FROM ERROR_CODES
                                     WHERE code = LAST_RESULT_CODE))
    FROM SRF_USER.MESSAGE_LOG_details
   WHERE     insert_date BETWEEN TO_DATE ('12.09.2016 00.00.00',
                                          'dd.mm.yyyy HH24.MI.SS')
                             AND --SYSDATE
                                 TO_DATE ('12.09.2016 23.59.59',
                                          'dd.mm.yyyy HH24.MI.SS')
         AND (   DESTINATION_ADDRESS NOT IN
                    (SELECT DESTINATION_ADDRESS
                       FROM SRF_USER.MESSAGE_LOG
                      WHERE     insert_date BETWEEN TO_DATE (
                                                       '12.09.2016 00.00.00',
                                                       'dd.mm.yyyy HH24.MI.SS')
                                                AND TO_DATE (
                                                       '12.09.2016 23.59.59',
                                                       'dd.mm.yyyy HH24.MI.SS')
                            AND ESME_ID = 'zed_bulk'
                            AND TRANSACTION_TYPE = 1)
              OR DESTINATION_ADDRESS IN
                    (SELECT DESTINATION_ADDRESS
                       FROM SRF_USER.MESSAGE_LOG
                      WHERE     insert_date BETWEEN TO_DATE (
                                                       '12.09.2016 00.00.00',
                                                       'dd.mm.yyyy HH24.MI.SS')
                                                AND TO_DATE (
                                                       '12.09.2016 23.59.59',
                                                       'dd.mm.yyyy HH24.MI.SS')
                            AND ESME_ID = 'zed_bulk'
                            AND TRANSACTION_TYPE = 2))
         AND ESME_ID = 'zed_bulk'
         AND MESSAGE_TEXT LIKE 'Qurban Bayraminiz mubarek!%'
         AND FORWARD_TO IS NULL
--AND TRANSACTION_TYPE = 0
GROUP BY LAST_RESULT_CODE
ORDER BY 1 DESC;
        
        
/* Formatted on 22.09.2016 10:00:16 (QP5 v5.227.12220.39754) */
  SELECT distinct DESTINATION_ADDRESS
    FROM SRF_USER.MESSAGE_LOG
   WHERE     insert_date BETWEEN TO_DATE ('13.09.2016 00.00.00',
                                          'dd.mm.yyyy HH24.MI.SS')
                             AND TO_DATE ('13.09.2016 23.59.59',
                                          'dd.mm.yyyy HH24.MI.SS')
         AND DESTINATION_ADDRESS NOT IN
                (SELECT DESTINATION_ADDRESS
                   FROM SRF_USER.MESSAGE_LOG
                  WHERE     insert_date BETWEEN TO_DATE (
                                                   '13.09.2016 00.00.00',
                                                   'dd.mm.yyyy HH24.MI.SS')
                                            AND TO_DATE (
                                                   '13.09.2016 23.59.59',
                                                   'dd.mm.yyyy HH24.MI.SS')
                        AND ESME_ID = 'zed_bulk'
                        AND TRANSACTION_TYPE = 1)
         AND MESSAGE_TEXT LIKE 'Qurban Bayraminiz mubarek!%'
         AND ESME_ID = 'zed_bulk'
         AND TRANSACTION_TYPE = 2
ORDER BY insert_date DESC;
        
        
        SELECT DESTINATION_ADDRESS
    FROM SRF_USER.MESSAGE_LOG
        WHERE insert_date BETWEEN TO_DATE ('12.09.2016 00.00.00', 'dd.mm.yyyy HH24.MI.SS') 
        AND 
        --SYSDATE
        TO_DATE ('12.09.2016 23.59.59', 'dd.mm.yyyy HH24.MI.SS') 
        --AND DESTINATION_ADDRESS 
        --AND MESSAGE_TEXT like 'Qurban Bayraminiz mubarek!%'
         AND ESME_ID = 'zed_bulk'
        AND TRANSACTION_TYPE = 1
        ORDER BY insert_date DESC;
        
        

   SELECT INSERT_DATE, count(*) from (SELECT TRUNC (INSERT_DATE, 'HH24') INSERT_DATE
     FROM message_log
    WHERE     esme_id = 'wroam'
          AND transaction_type = '1'
          AND insert_date BETWEEN SYSDATE - 14 AND SYSDATE)
          group by INSERT_DATE
          order by 1 desc;
          
          
      SELECT *
     FROM message_log
    WHERE     esme_id = 'wroam'
          AND transaction_type = '1'
          AND insert_date BETWEEN SYSDATE - 1 / 24 AND SYSDATE;
          
         
    

         
         
         
         