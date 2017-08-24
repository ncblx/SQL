/* Formatted on 01.07.2013 10:51:12 (QP5 v5.227.12220.39754) */
BEGIN
   FOR i
      IN (SELECT i.mob_num, ap.id, ap.prepaid_platform
            FROM imsi_to_del i, afon.app@to_bccdb ap
           WHERE     SYSDATE BETWEEN ap.fd AND ap.td
                 AND '994' || ap.mob_num = i.mob_num
                 AND ap.status = 0)
   LOOP
      add_subscriber (i.mob_num,
                      i.id,
                      '40850',
                      i.prepaid_platform,
                      :O_1,
                      :O_2);
   END LOOP;

   COMMIT;
END;