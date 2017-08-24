CREATE OR REPLACE FUNCTION AFON_IP.CHECK_VAL_PRETOPOST (
   ATTR            IN VARCHAR2,
   VAL             IN VARCHAR2,
   SGSN_MCCMNC     IN VARCHAR2,                            --not using anymore
   SGSN_IPADDR     IN VARCHAR2,
   CALLING_ID      IN VARCHAR2,
   LOCATION_INFO   IN VARCHAR2)
   RETURN VARCHAR2
AS
   --configuration params:

   BYPASS       BOOLEAN := FALSE; --true if you want bypass the prepaid traffic (in the new year)
   P2P          BOOLEAN := TRUE; --true when we want convert postpaid to prepaid



   RET_VAL      VARCHAR2 (64);
   MCCMNC       VARCHAR2 (64) := SGSN_MCCMNC;              --not using anymore
   LOC_MCCMNC   VARCHAR2 (12);
   V_VAL        VARCHAR2 (64);
   IPADDR       VARCHAR2 (64) := SGSN_IPADDR;
BEGIN
   IF P2P
   THEN
      IF VAL = 'POSTPAID'
      THEN
         V_VAL := 'PREPAID' || AFON_IP.IS_AVAILABLE (CALLING_ID);
      ELSE
         IF VAL = 'WHITE'
         THEN
            V_VAL := 'POSTPAID';
         ELSE
            V_VAL := VAL;
         END IF;
      END IF;
   ELSE
      V_VAL := VAL;
   END IF;

   SELECT    reverse (SUBSTR (LOCATION_INFO, 5, 2))
          || reverse (SUBSTR (LOCATION_INFO, 8, 1))
          || reverse (SUBSTR (LOCATION_INFO, 9, 2))
     INTO LOC_MCCMNC
     FROM DUAL;

   IF CALLING_ID = 'MSISDN'
   THEN
      LOC_MCCMNC := '40004';
      IPADDR := '77.244.112.29';
   END IF;


   /*
    IF    LOC_MCCMNC != '40004'
     THEN
        LOC_MCCMNC := '00100';
     END IF;
  */


   /* <<<<<<<TEST>>>>>>>>> */
   IF CALLING_ID = '99470200092400'
   THEN
      LOC_MCCMNC := '257';
   --      IPADDR := '0.0.0.0';
   END IF;

   /* <<<<<<<TEST>>>>>>>>> */
   IF CALLING_ID = '994776479118'
   THEN
      LOC_MCCMNC := '25700';
   --      IPADDR := '0.0.0.0';
   END IF;

  


   /* <<<<<<<TEST>>>>>>>>> */
   IF CALLING_ID = '994776479020'
   THEN
      LOC_MCCMNC := '77700';
   --      IPADDR := '0.0.0.0';
   END IF;





   IF LOC_MCCMNC IS NULL
   THEN
      LOC_MCCMNC := '00000';
   END IF;



   IF LOC_MCCMNC = '43709'
   THEN
      LOC_MCCMNC := '00100';
   END IF;


   IF LOC_MCCMNC = '42402'
   THEN
      LOC_MCCMNC := '00100';
   END IF;


   IF LOC_MCCMNC = '22802'
   THEN
      LOC_MCCMNC := '00100';
   END IF;

   IF LOC_MCCMNC = '25001'
   THEN
      LOC_MCCMNC := '00100';
   END IF;



   IF IPADDR = '195.211.12.174'
   THEN
      LOC_MCCMNC := '00100';
   END IF;

   IF    IPADDR LIKE '213.87.78.%'
      OR IPADDR LIKE '193.27.231.%'
      OR IPADDR LIKE '213.87.68.%'
      OR IPADDR LIKE '217.74.254.%'
      OR IPADDR LIKE '217.8.235.%'
      OR IPADDR LIKE '213.87.41.%'
      OR IPADDR LIKE '213.87.40%'
   THEN
      LOC_MCCMNC := '00100';
   END IF;


   IF    IPADDR LIKE '2.48.0.%'
      OR IPADDR LIKE '217.164.95.%'
      OR IPADDR LIKE '217.164.94.%'
      OR IPADDR LIKE '31.219.178.%'
      OR IPADDR LIKE '86.96.240.%'
      OR IPADDR LIKE '94.57.236.%'
      OR IPADDR LIKE '31.219.224.%'
      OR (    IPADDR LIKE '31.219.225.%'
          AND SUBSTR (IPADDR,
                        INSTR (IPADDR,
                               '.',
                               1,
                               3)
                      + 1) BETWEEN 0
                               AND 63)
   THEN
      LOC_MCCMNC := '00100';
   END IF;

   /* <<<<<<<TEST>>>>>>>>> */
   IF CALLING_ID = '99477647901900'
   THEN
      LOC_MCCMNC := '44402';
   -- IPADDR := '0.0.0.0';
   END IF;



   IF ATTR = 'Nokia-Session-Charging-Type'
   THEN
      CASE
         WHEN (V_VAL = '_PREPAID_BUNDLE' OR V_VAL LIKE 'POSTPAID%')
         THEN
            RET_VAL := CHR (1);
         ELSE
            RET_VAL := CHR (5);
      END CASE;
   ELSIF ATTR = 'Nokia-Service-Name'
   THEN
      IF BYPASS
      THEN
         RET_VAL := '*POSTPAID';
      ELSE
         CASE
            WHEN     V_VAL = '_PREPAID_BUNDLE'
                 AND LOC_MCCMNC IN ('40004', '40002')
            THEN
               RET_VAL := '*POSTPAID';
            WHEN V_VAL = 'OPERA_BUNDLE' AND LOC_MCCMNC = '40004'
            THEN
               RET_VAL := '*OPERA_BUNDLE';
            WHEN LOC_MCCMNC IN ('23450', '23455')
            THEN
               RET_VAL := '*' || 'ZONE4' || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90115'
            THEN
               RET_VAL := '*' || 'ZONE5' || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90136' AND UPPER (V_VAL) LIKE '%BUNDLE%'
            THEN
               RET_VAL :=
                  '*PREPAID_ONAIR' || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90136'
            THEN
               RET_VAL :=
                     '*'
                  || V_VAL
                  || '_'
                  || 'ONAIR'
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN (SUBSTR (LOC_MCCMNC, 0, 3) != '400')
            THEN
               RET_VAL :=
                     '*'
                  || GET_IP_REGION (SUBSTR (LOC_MCCMNC, 0, 3), IPADDR)
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            ELSE
               RET_VAL := '*' || V_VAL;
         END CASE;
      END IF;
   ELSIF ATTR = 'HW-Charging-Rule-Base-Name'
   THEN
      IF BYPASS
      THEN
         RET_VAL := 'POSTPAID';
      ELSE
         CASE
            WHEN     V_VAL = '_PREPAID_BUNDLE'
                 AND LOC_MCCMNC IN ('40004', '40002')
            THEN
               RET_VAL := 'POSTPAID';
            WHEN V_VAL = 'OPERA_BUNDLE' AND LOC_MCCMNC = '40004'
            THEN
               RET_VAL := 'OPERA_BUNDLE';
            WHEN LOC_MCCMNC IN ('23450', '23455')
            THEN
               RET_VAL := 'ZONE4' || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90115'
            THEN
               RET_VAL := 'ZONE5' || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90136' AND UPPER (V_VAL) LIKE '%BUNDLE%'
            THEN
               RET_VAL := 'PREPAID_ONAIR' || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90136'
            THEN
               RET_VAL :=
                     V_VAL
                  || '_'
                  || 'ONAIR'
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN (SUBSTR (LOC_MCCMNC, 0, 3) != '400')
            THEN
               RET_VAL :=
                     V_VAL
                  || '_'
                  || GET_IP_REGION (SUBSTR (LOC_MCCMNC, 0, 3), IPADDR)
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            ELSE
               RET_VAL := V_VAL;
         END CASE;
      END IF;
   ELSIF ATTR = 'SN-Rulebase'
   THEN
      IF BYPASS
      THEN
         RET_VAL := 'POSTPAID';
      ELSE
         CASE
            WHEN     V_VAL = '_PREPAID_BUNDLE'
                 AND LOC_MCCMNC IN ('40004', '40002')
            THEN
               RET_VAL := 'POSTPAID';
            WHEN V_VAL = 'OPERA_BUNDLE' AND LOC_MCCMNC = '40004'
            THEN
               RET_VAL := 'OPERA_BUNDLE';
            WHEN LOC_MCCMNC IN ('23450', '23455')
            THEN
               RET_VAL :=
                     V_VAL
                  || '_'
                  || 'ZONE4'
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90115'
            THEN
               RET_VAL :=
                     V_VAL
                  || '_'
                  || 'ZONE5'
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90136' AND UPPER (V_VAL) LIKE '%BUNDLE%'
            THEN
               RET_VAL := 'PREPAID_ONAIR' || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN LOC_MCCMNC = '90136'
            THEN
               RET_VAL :=
                     V_VAL
                  || '_'
                  || 'ONAIR'
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN (    (SUBSTR (LOC_MCCMNC, 0, 3) != '400')
                  AND UPPER (V_VAL) LIKE '%BUNDLE%')
            THEN
               RET_VAL :=
                     'PREPAID'
                  || '_'
                  || GET_IP_REGION (SUBSTR (LOC_MCCMNC, 0, 3), IPADDR)
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            WHEN (SUBSTR (LOC_MCCMNC, 0, 3) != '400')
            THEN
               RET_VAL :=
                     V_VAL
                  || '_'
                  || GET_IP_REGION (SUBSTR (LOC_MCCMNC, 0, 3), IPADDR)
                  || AFON_IP.IS_AVAILABLE (CALLING_ID);
            ELSE
               RET_VAL := V_VAL;
         END CASE;
      END IF;
   ELSE
      RET_VAL := V_VAL;
   END IF;


   RETURN RET_VAL;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN NULL;
END CHECK_VAL_PRETOPOST;
/
