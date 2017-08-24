/* Formatted on 29.01.2013 15:33:47 (QP5 v5.227.12220.39754) */
UPDATE srv_attr
   SET td = SYSDATE
 WHERE     td > SYSDATE
       AND UP IN
              (SELECT n
                 FROM srv
                WHERE     td > SYSDATE
                      AND login IN (SELECT login FROM imsi_to_del));


update srv set td=sysdate where login in (select login from imsi_to_del) and td > sysdate;



select * from imsi_to_del;

TRUNCATE TABLE  imsi_to_del;

delete imsi_to_del where imsi is NULL;





/* Formatted on 29.01.2013 15:59:16 (QP5 v5.227.12220.39754) */
INSERT INTO imsi_to_del
   SELECT *
     FROM (SELECT NULLIF (a.login, b.id) IMSI_TO_DEL
             FROM (SELECT u.id, srv.login
                     FROM srv srv, usr u
                    WHERE     SYSDATE BETWEEN srv.fd AND srv.td
                          AND srv.UP IN (  SELECT UP
                                             FROM srv
                                            WHERE SYSDATE BETWEEN fd AND td
                                         GROUP BY UP
                                           HAVING COUNT (UP) > 1)
                          AND srv.UP = u.n
                          AND SYSDATE BETWEEN u.fd AND u.td) a
                  LEFT OUTER JOIN afon.app@to_bccdb b
                     ON (a.id = '994' || b.mob_num)
            WHERE SYSDATE BETWEEN b.fd AND b.td)
    WHERE imsi_to_del IS NOT NULL;
    
    
    
    


/* Formatted on 29.01.2013 15:59:27 (QP5 v5.227.12220.39754) */
SELECT a.id,
       a.login,
       b.mob_num,
       b.id,
       NULLIF (a.login, b.id)
  FROM (SELECT u.id, srv.login
          FROM srv srv, usr u
         WHERE     SYSDATE BETWEEN srv.fd AND srv.td
               AND srv.UP IN (  SELECT UP
                                  FROM srv
                                 WHERE SYSDATE BETWEEN fd AND td
                              GROUP BY UP
                                HAVING COUNT (UP) > 1)
               AND srv.UP = u.n
               AND SYSDATE BETWEEN u.fd AND u.td) a
       LEFT OUTER JOIN afon.app@to_bccdb b ON (a.id = '994' || b.mob_num)
 WHERE SYSDATE BETWEEN b.fd AND b.td;
 
 
 