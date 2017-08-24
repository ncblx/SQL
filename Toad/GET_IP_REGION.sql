CREATE OR REPLACE FUNCTION AFON_IP.get_ip_region (IMCC   IN VARCHAR2,
                                                   p_ip   IN VARCHAR2)
   RETURN VARCHAR2
AS
   PRAGMA AUTONOMOUS_TRANSACTION;
   req        UTL_HTTP.req;
   resp       UTL_HTTP.resp;
   VALUE      VARCHAR2 (9999);
   p_return   VARCHAR2 (50);
   p_zone     VARCHAR2 (50);
   p_count    INTEGER;
BEGIN
   IF IMCC!='000'
   THEN
      --DBMS_OUTPUT.PUT_LINE ( 'NOT NULL ' );

      SELECT bplan
        INTO p_return
        FROM AFON_IP.RADZONES
       WHERE MCC = IMCC AND ROWNUM = 1;
   ELSE
      BEGIN
         req :=
            UTL_HTTP.begin_request (
               'http://10.13.44.233/whois.php?domain=' || p_ip);
         UTL_HTTP.set_header (req, 'User-Agent', 'Mozilla/4.0');
         UTL_HTTP.set_transfer_timeout (20);
         resp := UTL_HTTP.get_response (req);

         LOOP
            UTL_HTTP.read_line (resp, VALUE, TRUE);

            IF REGEXP_INSTR (UPPER (VALUE), 'COUNTRY:') > 0
            THEN
               p_zone :=
                  TRIM (REGEXP_REPLACE (UPPER (VALUE), 'COUNTRY:*', ''));
            END IF;
         END LOOP;

         

         UTL_HTTP.end_response (resp);
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (resp);

            SELECT COUNT (BPLAN)
              INTO p_count
              FROM afon_ip.RADZONES
             WHERE DOMAIN = p_zone;

            IF (p_count > 0)
            THEN
               SELECT BPLAN
                 INTO p_return
                 FROM afon_ip.RADZONES
                WHERE DOMAIN = p_zone;
            ELSE
--               INSERT INTO AFON_IP.RADZONES
--                    VALUES (NULL,
--                            'ZONE0',
--                            p_zone,
--                            SYSDATE,
--                            p_ip);

               COMMIT;

               p_return := 'ZONE0';
            END IF;
         WHEN OTHERS
         THEN
            RETURN 'ZONE0';
      END;
   END IF;

   RETURN p_return;
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN 'ZONE0';
END;
/
