/* Formatted on 16.12.2014 18:57:06 (QP5 v5.227.12220.39754) */
  SELECT TO_DATE (sms_fd, 'dd.mm.yy') DATA,
         source_address,
         status,
         COUNT (status) AS COUNT
    FROM afon_sms40.short_num
   WHERE     sms_fd BETWEEN TO_DATE ('15.12.2014', 'dd.mm.yyyy') AND SYSDATE
         AND source_address in ('0.1.3330', '0.1.3331', '0.1.3320', '0.1.9012', '0.1.9797', '0.1.9013', '0.1.6550')
GROUP BY status, source_address, TO_DATE (sms_fd, 'dd.mm.yy')
ORDER BY 3, 4 DESC