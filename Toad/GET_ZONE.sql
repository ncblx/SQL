CREATE OR REPLACE FUNCTION AFON_IP.GET_ZONE(IMCC IN VARCHAR2) 
   RETURN VARCHAR2 
   IS 
   pragma Autonomous_Transaction;
   BZONE VARCHAR2(64);
BEGIN 
   SELECT bplan 
   INTO BZONE
   --FROM AFON.online_sms_mscid@TO_BCC_online_sms_mscid 
   FROM AFON_IP.RADZONES
   WHERE MCC = IMCC and rownum = 1;-- and bplan!='ZONE0';
   RETURN(BZONE);
    exception
                    when NO_DATA_FOUND  then
--                            insert into  AFON_IP.RADZONES values(IMCC, 'ZONE0',NULL,sysdate,null);                                         
         RETURN 'ZONE0';
 END get_zone;
/
