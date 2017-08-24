/* Formatted on 23.09.2015 10:53:41 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM mms_stat_details
   WHERE     request_status_code IS NOT NULL
         AND MESSAGE_TYPE = 'MM4_forward.RES'
         AND MESSAGE_ID IN
                (SELECT ID
                   FROM (SELECT id, src
                           FROM mms_stat
                          WHERE     src_port IS NOT NULL
                                AND src LIKE '+99450%'
                                AND creation_time BETWEEN TO_DATE (
                                                             '01.07.2015 00.00.00',
                                                             'dd.mm.yyyy HH24.MI.SS')
                                                      AND TO_DATE (
                                                             '31.07.2015 00.00.00',
                                                             'dd.mm.yyyy HH24.MI.SS')
                         UNION
                         SELECT id, src
                           FROM mms_stat
                          WHERE     src_port IS NOT NULL
                                AND src LIKE '+99451%'
                                AND creation_time BETWEEN TO_DATE (
                                                             '01.07.2015 00.00.00',
                                                             'dd.mm.yyyy HH24.MI.SS')
                                                      AND TO_DATE (
                                                             '31.07.2015 00.00.00',
                                                             'dd.mm.yyyy HH24.MI.SS')))
ORDER BY 3 DESC




/* Formatted on 23.09.2015 10:53:11 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM mms_stat_details
   WHERE     request_status_code IS NOT NULL
         AND MESSAGE_TYPE = 'MM4_forward.RES'
         AND MESSAGE_ID IN
                (SELECT ID
                   FROM mms_stat
                  WHERE     src_port IS NOT NULL
                        AND src LIKE '+99455%'
                        AND creation_time BETWEEN TO_DATE (
                                                     '01.09.2015 00.00.00',
                                                     'dd.mm.yyyy HH24.MI.SS')
                                              AND TO_DATE (
                                                     '23.09.2015 00.00.00',
                                                     'dd.mm.yyyy HH24.MI.SS'))
ORDER BY 3 DESC