DROP VIEW AFON_IP.T_RAD_AUTH_RPL_NSN;

/* Formatted on 17/03/2017 17:18:59 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW AFON_IP.T_RAD_AUTH_RPL_NSN
(
   ID,
   USERNAME,
   ATTRIBUTE,
   VAL,
   OP,
   TD
)
AS
   SELECT u.id AS id,
          S.LOGIN AS UserName,
          rd.name AS Attribute,
          AT.VAL val,
          ':=' AS op,
          AT.TD AS td
     FROM afon_ip.usr u,
          afon_ip.srv s,
          SRV_ATTR at,
          TMP_RADAT rd
    WHERE     u.n = s.UP
          AND u.td > SYSDATE
          AND s.td > SYSDATE
          AND S.n = at.UP
          AND at.attr IN ('5201', '1406', '5216', '2780')
          AND at.attr = rd.n
          AND SYSDATE BETWEEN at.fd AND at.td;
