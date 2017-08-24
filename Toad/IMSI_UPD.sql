select * from AFON_IP.USR where id='994708312670' and td > sysdate;

select * from afon_ip.srv where up= '5902136'  and td > sysdate

update srv set login = '400041036863130' where n = '5685994' and up = '5902136';

update srv set name = '400041036863130@GRPS' where n = '5685994' and up = '5902136';

update AFON_IP.SRV_ATTR  set td = sysdate+10000 where up = '758334' and attr = '5216' and n = '201663525'

select * from afon_ip.srv_attr where up='3154795' and td > sysdate;

INSERT INTO srv_attr VALUES (SQ$INET_SRV_ATTR.NEXTVAL,  6803686 ,  2780, '10.120.196.28', SYSDATE, TO_DATE ('01/01/2018', 'dd/mm/yyyy'));

select * from AFON_IP.SRV_ATTR where up='95861' and td > sysdate --and ATTR = '5201';

select * from AFON_IP.SRV_ATTR where up= (select N from afon_ip.srv where up= (select N from AFON_IP.USR where id='994702000245' and td > sysdate) and td > sysdate) and td > sysdate --and ATTR = '5201';

select * from AFON_IP.SRV_ATTR where up in ('5471233', '651169') and td > sysdate;

update AFON_IP.SRV_ATTR set td=sysdate  where up in ('5240469', '651169') and td > sysdate;

update AFON_IP.SRV_ATTR set VAL='POSTPAID_TEST' where UP='7711325' and ATTR='5201';

update AFON_IP.SRV_ATTR set td = '16/02/2014' where up = '552320' and n = '220418485' and td > sysdate;

update AFON_IP.SRV set td=sysdate where n='204086767' and td > sysdate;

update AFON_IP.USR set td=sysdate where id='994702113100' and td > sysdate;

update afon_ip.srv_attr set fd=sysdate where n='116582863'



select * from afon_ip.usr where id in (select mob_num from imsi_to_del)

select * from afon_ip.srv where up in (select N from afon_ip.usr where id in (select mob_num from imsi_to_del)) and td > sysdate;

select * from AFON_IP.SRV_ATTR where up in (select N from afon_ip.srv where up in (select N from afon_ip.usr where id in (select mob_num from imsi_to_del)) and td > sysdate) and td > sysdate;

select * from imsi_to_del;

TRUNCATE TABLE  imsi_to_del;

INSERT INTO imsi_to_del (LOGIN, MOB_NUM) VALUES ('400041033188026' ,'994777170030');

INSERT INTO srv_attr VALUES (SQ$INET_SRV_ATTR.NEXTVAL, 5471233,  5216, chr(5), SYSDATE, TO_DATE ('01/01/2018', 'dd/mm/yyyy'))


update AFON_IP.SRV_ATTR set VAL='ZONE3' where N='115931015' and UP='5299944' and ATTR='5201';

update AFON_IP.SRV_ATTR set VAL=chr(1) where N='199473838' and UP='70760' and ATTR='5216';