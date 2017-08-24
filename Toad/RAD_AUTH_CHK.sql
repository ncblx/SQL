DROP VIEW AFON_IP.RAD_AUTH_CHK;

/* Formatted on 17/03/2017 17:18:18 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW AFON_IP.RAD_AUTH_CHK
(
   ID,
   USERNAME,
   ATTRIBUTE,
   VALUE,
   OP
)
AS
   SELECT u.id AS id,
          S.LOGIN AS UserName,
          'Cleartext-Password' AS Attribute,
          'YES' AS VALUE,
          ':=' AS op
     FROM afon_ip.usr u, afon_ip.srv s
    WHERE u.n = s.UP AND u.td > SYSDATE AND s.td > SYSDATE;
