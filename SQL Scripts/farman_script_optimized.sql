/* Formatted on 11-апр-2011 13:10:55 (QP5 v5.149.1003.31008) */
  SELECT                                        /*+ full(nc) parallel(nc 4) */
        strt, COUNT (strt) AS cnt
    FROM afon.num_calls nc                                     --, afon.app ap
   --where up in (select n from afon.app where mob_num='702011345') and
   WHERE                                                         -- nc.up=ap.n
                                                                         --and
             strt >= TO_DATE ('01/10/2010 000000', 'dd/mm/yyyy hh24miss')
         AND strt <= TO_DATE ('01/10/2010 235959', 'dd/mm/yyyy hh24miss')
         AND num = 'INTERNET'
         AND transac BETWEEN (SELECT MIN (t_from)
                                FROM afon.cdr_transac_dates
                               WHERE TO_DATE ('01/10/2010 000000', 'dd/mm/yyyy hh24miss') BETWEEN dt_from
                                                                               AND dt_to)
                         AND (SELECT MAX (t_to)
                                FROM afon.cdr_transac_dates
                               WHERE TO_DATE ('01/10/2010 235959', 'dd/mm/yyyy hh24miss') BETWEEN dt_from
                                                                               AND dt_to)
--ap.td>sysdate
--order by nc.strt desc
GROUP BY strt
  HAVING (COUNT (strt)) > 1
  
  
  
  /* Dublicate INTERNET sessions */
  SELECT                                        /*+ full(nc) parallel(nc 4) */
        nc.strt, COUNT (nc.strt) AS cnt,nc.up
    FROM afon.num_calls nc                                     , afon.app ap
   --where up in (select n from afon.app where mob_num='702011345') and
   WHERE                                                         nc.up=ap.n
   and AP.PREPAID_PLATFORM=8
                                                                         and
                                                                         ap.td>Sysdate and 
             nc.strt >= '22/jul/2011'
         AND nc.strt <= sysdate
         AND nc.num = 'INTERNET'
         and nc.dur>0
         AND nc.transac BETWEEN (SELECT MIN (t_from)
                                FROM afon.cdr_transac_dates
                               WHERE  '22/jul/2011' BETWEEN dt_from
                                                                               AND dt_to)
                         AND (SELECT MAX (t_to)
                                FROM afon.cdr_transac_dates
                               WHERE  sysdate BETWEEN dt_from
                                                                               AND dt_to)
--ap.td>sysdate
--order by nc.strt desc
GROUP BY nc.strt,nc.up
  HAVING (COUNT (nc.strt)) > 1