/* Azercell to Azerfon  */
SELECT Count(*)
  FROM (SELECT ID, CREATION_TIME, SRC, DST
          FROM mms_stat
         WHERE     src_port IS NOT NULL
               AND src LIKE '+99450%'
               AND creation_time BETWEEN TO_DATE ('01.01.2016 00.00.00',
                                                  'dd.mm.yyyy HH24.MI.SS')
                                     AND TO_DATE ('31.01.2016 23.59.59',
                                                  'dd.mm.yyyy HH24.MI.SS')
        UNION
        SELECT ID, CREATION_TIME, SRC, DST
          FROM mms_stat
         WHERE     src_port IS NOT NULL
               AND src LIKE '+99451%'
               AND creation_time BETWEEN TO_DATE ('01.01.2016 00.00.00',
                                                  'dd.mm.yyyy HH24.MI.SS')
                                     AND TO_DATE ('31.01.2016 23.59.59',
                                                  'dd.mm.yyyy HH24.MI.SS'));


/* Azerfon to Azercell */
SELECT COUNT (*)
  FROM (SELECT id,
               creation_time,
               DST,
               dst_port
          FROM mms_stat
         WHERE     dst_port = 'Azercell_50'
               AND DST LIKE '+99450%'
               AND creation_time BETWEEN TO_DATE ('01.10.2016 00.00.00',
                                                  'dd.mm.yyyy HH24.MI.SS')
                                     AND TO_DATE ('31.10.2016 23.59.59',
                                                  'dd.mm.yyyy HH24.MI.SS')
        UNION
        SELECT id,
               creation_time,
               DST,
               dst_port
          FROM mms_stat
         WHERE     dst_port = 'Azercell_51'
               AND DST LIKE '+99451%'
               AND creation_time BETWEEN TO_DATE ('01.10.2016 00.00.00',
                                                  'dd.mm.yyyy HH24.MI.SS')
                                     AND TO_DATE ('31.10.2016 23.59.59',
                                                  'dd.mm.yyyy HH24.MI.SS'));
                                                  

/*Bakcell to Azerfon*/
SELECT COUNT (*)
  FROM mms_stat
 WHERE     src_port IS NOT NULL
       --and src != 'MAILER-DAEMON@mms.mnc004.mcc400.gprs'
       AND src LIKE '+99455%'
       AND creation_time BETWEEN TO_DATE ('01.08.2016 00.00.00',
                                          'dd.mm.yyyy HH24.MI.SS')
                             AND TO_DATE ('31.08.2016 23.59.59',
                                          'dd.mm.yyyy HH24.MI.SS');



/*Azerfon to Bakcell*/

SELECT COUNT (*)
  FROM (SELECT ID,
               CREATION_TIME,
               SRC,
               DST
          FROM mms_stat
         WHERE     dst_port = 'Bakcell'
               --and src != 'MAILER-DAEMON@mms.mnc004.mcc400.gprs'
               AND DST LIKE '+99455%'
               AND creation_time BETWEEN TO_DATE ('01.08.2016 00.00.00',
                                                  'dd.mm.yyyy HH24.MI.SS')
                                     AND TO_DATE ('31.08.2016 23.59.59',
                                                  'dd.mm.yyyy HH24.MI.SS')
        UNION
        SELECT ID,
               CREATION_TIME,
               SRC,
               DST
          FROM mms_stat
         WHERE     dst_port = 'Bakcell_MNP'
               --AND dst_port = 'Bakcell_MNP'
               --and src != 'MAILER-DAEMON@mms.mnc004.mcc400.gprs'
               AND DST LIKE '+994%'
               AND creation_time BETWEEN TO_DATE ('01.01.2016 00.00.00',
                                                  'dd.mm.yyyy HH24.MI.SS')
                                     AND TO_DATE ('31.01.2016 23.59.59',
                                                  'dd.mm.yyyy HH24.MI.SS'));
                                          