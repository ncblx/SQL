/* Formatted on 2007/09/03 20:11 (Formatter Plus v4.5.2) */
SELECT a.n, a.id, f.idf
  FROM in_app a,
       in_service s,
       in_cs_srv c,
       in_fragment f
 WHERE SYSDATE BETWEEN a.fd AND a.td
   AND SYSDATE BETWEEN s.fd AND s.td
   AND SYSDATE BETWEEN c.fd AND c.td
   AND SYSDATE BETWEEN f.fd AND f.final_time
   AND a.n = s.up
   AND s.n = c.up
   AND c.n = f.up
   AND ID like '702000663'
   AND f.idf =11112;




