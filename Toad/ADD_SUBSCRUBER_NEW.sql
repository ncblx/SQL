/* Formatted on 01.07.2013 10:51:12 (QP5 v5.227.12220.39754) */
DECLARE 
  I_1 VARCHAR2(32767);
  I_2 VARCHAR2(32767);
BEGIN
      add_subscriber (:I_1,
                      :I_2,
                      '40850',
                      '4',
                      :O_1,
                      :O_2);
                      DBMS_OUTPUT.PUT_LINE ( ':O_1 = ' || :O_1 );
                      DBMS_OUTPUT.PUT_LINE ( ':O_2 = ' || :O_2 );
   COMMIT;
END;