select * from usr where sysdate between fd and td and  N in
(
(select DISTINCT N from AFON_IP.USR where id like '9947%' and sysdate between fd and td)
minus
(select DISTINCT UP from afon_ip.srv where sysdate between fd and td)
)



select * from srv where sysdate between fd and td and N in
(
(select DISTINCT N from afon_ip.srv where sysdate between fd and td)
minus
(select UP from AFON_IP.SRV_ATTR where  sysdate between fd and td)
)



select * from srv where sysdate between fd and td and  UP in
(
(select DISTINCT UP from afon_ip.srv where name like '%@GPRS' and sysdate between fd and td)
minus
(select DISTINCT N from AFON_IP.USR where id like '9947%' and sysdate between fd and td)
)



select * from srv where sysdate between fd and td and UP in
(
(select DISTINCT UP from AFON_IP.SRV_ATTR where  sysdate between fd and td)
minus
(select DISTINCT N from afon_ip.srv where sysdate between fd and td)
)



SELECT UP, ATTR, count(val) FROM srv_attr
 WHERE sysdate between fd and td
 GROUP BY UP, ATTR
HAVING COUNT(val)>1


SELECT login, count(login) FROM srv
 WHERE sysdate between fd and td
 GROUP BY login
HAVING COUNT(login)>1


SELECT UP, count(UP) FROM srv
 WHERE sysdate between fd and td
 GROUP BY UP
HAVING COUNT(UP)>1


SELECT ID, count(ID) FROM usr
 WHERE sysdate between fd and td
 GROUP BY ID
HAVING COUNT(ID)>1


SELECT N, count(N) FROM usr
 WHERE sysdate between fd and td
 GROUP BY N
HAVING COUNT(N)>1
