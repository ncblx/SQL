select * from AFON_IP.SRV_ATTR where up= (select N from afon_ip.srv where up= (select N from AFON_IP.USR where id='994776479029' and td > sysdate) and td > sysdate) and td > sysdate;

select * from AFON_IP.RAD_LOGIC where mob_num = '994706340411' and td > sysdate

update afon_ip.rad_logic set td = to_date('04/09/2014', 'dd/mm/yyyy') where mob_num = '994706060400' and td > sysdate;

update AFON_IP.SRV_ATTR set td =to_date('17/12/2014', 'dd/mm/yyyy') where n = '650094310' and up = '3000556';

update AFON_IP.SRV_ATTR set fd =to_date('17/12/2014 0:00:01', 'dd/mm/yyyy HH24:MI:SS') where n = '648935908' and up = '3000556';

update afon_ip.srv_attr set val = 'WHITE' where n = '753890054' and up = '9969371' and attr = '5201'






INSERT INTO srv_attr VALUES (SQ$INET_SRV_ATTR.NEXTVAL, 6196326, 5201, 'PREPAID_BUNDLE', TO_DATE ('26/02/2014 0:00:01', 'dd/mm/yyyy HH24:MI:SS'), TO_DATE ('23/02/2014 0:00:58', 'dd/mm/yyyy HH24:MI:SS'));

INSERT INTO srv_attr VALUES (SQ$INET_SRV_ATTR.NEXTVAL, 6196326, 5201, 'PREPAID', TO_DATE ('26/02/2014 0:00:01', 'dd/mm/yyyy HH24:MI:SS'), TO_DATE ('01/01/2018', 'dd/mm/yyyy'));