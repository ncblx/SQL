DROP VIEW AFON_IP.RAD_AUTH_RPL;

/* Formatted on 17/03/2017 17:18:39 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW AFON_IP.RAD_AUTH_RPL
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
          radattribute rd
    WHERE     u.n = s.UP
          AND u.td > SYSDATE
          AND s.td > SYSDATE
          AND S.n = at.UP
          AND at.attr IN ('5201', '1406', '2780')
          AND at.attr = rd.n
          --AND at.attr IN ('1999')
          --AND at.val NOT IN ('NOT_USED', 'YES')
          --and u.id='994773770005'
          AND SYSDATE BETWEEN at.fd AND at.td;
