/* Formatted on 17.10.2012 17:56:54 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM AFON.PAYMENT_LOAD
   WHERE     fd BETWEEN TO_DATE ('20.02.2015', 'dd.mm.yyyy') AND 
         --TO_DATE ('10.08.2013','DD.MM.YY') 
         SYSDATE
         --AND DSC = 'MEGA'
         --AND account = '687088'
         --AND idt_payer LIKE '%702237579'
         --AND REF2 = '707114802'
         --AND order_id like '%428304606551'
         --AND order_id='NarMobile062833430'
         --AND order_id in ('2879441494', '2879431959', '2879439427', '2879431975', '2879442856', '2879440482', '2879440144')
         --AND UP = '1522335'
         --AND REF = '1522335'
ORDER BY fd DESC


/* Formatted on 19.11.2012 15:23:48 (QP5 v5.163.1008.3004) */
  SELECT TRUNC (fd, 'hh24'), COUNT (TRUNC (fd, 'hh24')) AS say
    FROM afon.payment
   WHERE recv_acc = '1947400'
         AND fd BETWEEN TRUNC (SYSDATE - 1, 'dd') AND TRUNC (SYSDATE, 'dd')
GROUP BY TRUNC (fd, 'hh24')
ORDER BY TRUNC (fd, 'hh24') ASC




select * from AFON.SHORT_CODES_CP where code = 7070

afon.short_codes_cp