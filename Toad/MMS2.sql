/* Formatted on 31.10.2016 14:53:37 (QP5 v5.227.12220.39754) */
SELECT *
  FROM mms_stat
 WHERE     dst NOT LIKE '%MAILER-DAEMON%'
       --AND src NOT LIKE '%MAILER-DAEMON%'
       --and ssc_upload_n = 0
       AND (src_port IS NOT NULL OR dst_port IS NOT NULL AND dst_port != 'Deny')
       AND (dst NOT LIKE '+9947%' OR src NOT LIKE '+9947%')
       AND (src not like '000D300%' OR dst not like '000D300%')
       AND (DST not LIKE '000D300%' OR SRC not LIKE '+9947%')
       AND LENGTH (dst) > 10
       --AND src_ADDR  = '79234710363' 
       --and src_addr  like '000D300%'
       --AND N = 543671
       --and ssc_upload_n = '453246'
       and creation_time between  TO_DATE ('28.10.2016 00.00.00', 'dd.mm.yyyy HH24.MI.SS') 
        AND 
        --SYSDATE
        TO_DATE ('28.10.2016 23.59.59', 'dd.mm.yyyy HH24.MI.SS') 
        and dst_port like 'Azercell%'
       order by creation_time desc;
       
       
       
       
       /* Formatted on 14.11.2016 11:14:32 (QP5 v5.227.12220.39754) */
/* Azerfon to Azercell */

SELECT trunc(creation_time, 'dd') day, count(*)
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
                                                  'dd.mm.yyyy HH24.MI.SS'))
                                                  group by trunc(creation_time, 'dd')
                                                  order by 1;
                                                  
                                                  