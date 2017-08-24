/* Formatted on 03.09.2012 17:29:05 (QP5 v5.163.1008.3004) */
UPDATE in_fragment
   SET replicated = 0
 WHERE idf IN
          (SELECT temp3.idf
             FROM afon_in.in_app,
                  (SELECT in_service.UP,
                          temp2.idf,
                          temp2.final_time,
                          temp2.active
                     FROM afon_in.in_service,
                          (SELECT in_cs_srv.UP,
                                  temp1.idf,
                                  temp1.final_time,
                                  in_cs_srv.active
                             FROM afon_in.in_cs_srv,
                                  (SELECT UP, idf, final_time
                                     FROM afon_in.in_fragment
                                    WHERE SYSDATE BETWEEN fd AND td
                                          AND UP != 0/*and /*final_time between sysdate and td and trunc(sysdate) + 1 = trunc(final_time)*/
                                                     ) temp1
                            WHERE temp1.UP = in_cs_srv.n
                                  AND SYSDATE BETWEEN in_cs_srv.fd
                                                  AND in_cs_srv.td) temp2
                    WHERE in_service.n = temp2.UP
                          AND SYSDATE BETWEEN in_service.fd AND in_service.td) temp3
            WHERE     in_app.n = temp3.UP
                  AND SYSDATE BETWEEN in_app.fd AND in_app.td
                  AND in_app.id IN ('706472438'))