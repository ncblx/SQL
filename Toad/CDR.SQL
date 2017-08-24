select * from ssc_br 
--where ssc_upload_n = 0 
--where src_addr = 'MAILER-DAEMON@mms.narmobile.az'
where vaspout is not null
order by fd desc;


select * from ssc_details_upload
where n = '417897'



/* Formatted on 13.08.2015 15:31:37 (QP5 v5.227.12220.39754) */
  SELECT SUBSTR (dst_addr, 2) AS DST_ADDR
    FROM ssc_br
   WHERE dst_addr in (SELECT MSISDN FROM med.ent_mnp@lnk_TO_MNP)
ORDER BY fd DESC;



/* Formatted on 13.08.2015 15:41:53 (QP5 v5.227.12220.39754) */
SELECT a.*
  FROM ssc_br a, med.ent_mnp@lnk_TO_MNP b
 WHERE SUBSTR (a.src_addr, 2) = b.msisdn 
 and b.PORTINGENDTIME is null
 AND a.vaspin Is NULL
               AND fd BETWEEN TO_DATE ('01.08.2015 00.00.00',
                                       'dd.mm.yyyy HH24.MI.SS')
                          AND TO_DATE ('13.08.2015 23.59.59',
                                       'dd.mm.yyyy HH24.MI.SS')
               AND a.typ = 22
               AND a.sub_typ = 2211
               




/* Formatted on 13.08.2015 16:20:29 (QP5 v5.227.12220.39754) */
SELECT *
  FROM ssc_br
 WHERE     dst_ADDR IN
              (SELECT a.dst_ADDR
                 FROM ssc_br a, med.ent_mnp@lnk_TO_MNP b
                WHERE     SUBSTR (a.dst_addr, 2) != b.msisdn
                      AND b.PORTINGENDTIME IS NULL
                      --and b.RECIPENTID = 1
                      --and b.RECIPENTID != 2
                      )
                      --and dst_addr like '+99451%'
                      --and src_addr like '+9945%'
       AND fd BETWEEN TO_DATE ('01.08.2015 00.00.00',
                               'dd.mm.yyyy HH24.MI.SS')
                  AND TO_DATE ('13.08.2015 23.59.59',
                               'dd.mm.yyyy HH24.MI.SS')
                               and VASPIN is null
                               and vaspout is null
       --AND typ = 22
       --AND sub_typ = 2211
       
       
       
UPDATE ssc_br
   SET ssc_upload_n = 0, typ = 22, sub_typ = 2223, vaspout = 'Bakcell_MNP'
 WHERE dst_ADDR IN
              (SELECT a.dst_ADDR
                 FROM ssc_br a, med.ent_mnp@lnk_TO_MNP b
                WHERE     SUBSTR (a.dst_addr, 2) = b.msisdn
                      AND b.PORTINGENDTIME IS NULL
                      and b.RECIPENTID = 1
                      and b.RECIPENTID != 2)
       AND fd BETWEEN TO_DATE ('01.08.2015 00.00.00',
                               'dd.mm.yyyy HH24.MI.SS')
                  AND TO_DATE ('13.08.2015 23.59.59',
                               'dd.mm.yyyy HH24.MI.SS')
       AND typ = 22
       AND sub_typ = 2223
       
       
/* Formatted on 13.08.2015 17:29:01 (QP5 v5.227.12220.39754) */
UPDATE ssc_br
   SET ssc_upload_n = 0,
       typ = 22,
       sub_typ = 2223,
       dir = 10,
       vaspout = 'Azercell_51'
 WHERE     dst_ADDR IN
              (SELECT a.dst_ADDR
                 FROM ssc_br a, med.ent_mnp@lnk_TO_MNP b
                WHERE     SUBSTR (a.dst_addr, 2) != b.msisdn
                      AND b.PORTINGENDTIME IS NULL/*and b.RECIPENTID = 1
                                                  AND b.RECIPENTID != 2*/
                                                  )
       AND fd BETWEEN TO_DATE ('01.08.2015 00.00.00',
                               'dd.mm.yyyy HH24.MI.SS')
                  AND TO_DATE ('13.08.2015 23.59.59',
                               'dd.mm.yyyy HH24.MI.SS')
       AND dst_addr LIKE '+99451%'
       AND VASPIN IS NULL
       AND vaspout IS NULL
--AND typ = 22
--AND sub_typ = 2211