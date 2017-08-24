CREATE OR REPLACE FUNCTION AFON_IP.CHECK_BALANCE (IN_ID       IN VARCHAR2,
                                                  IN_INPUT    IN VARCHAR2,
                                                  IN_OUTPUT   IN VARCHAR2)
   RETURN VARCHAR2
AS
   PRAGMA AUTONOMOUS_TRANSACTION;
   RET_BAL   VARCHAR2 (64);
BEGIN
   UPDATE AFON_IP.RADBALANCE
      SET CUR_BAL = CUR_BAL + (IN_INPUT + IN_OUTPUT)
    WHERE ID = IN_ID AND TD > SYSDATE;

   COMMIT;

   SELECT CUR_BAL
     INTO RET_BAL
     FROM AFON_IP.RADBALANCE
    WHERE IN_ID = ID AND TD > SYSDATE;

   RETURN (RET_BAL);
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN NULL;
END CHECK_BALANCE;
/