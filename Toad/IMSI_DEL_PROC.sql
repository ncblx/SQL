select * from imsi_to_del;

TRUNCATE TABLE  imsi_to_del;


select * from afon_ip.usr where id in (select mob_num from imsi_to_del);

select * from afon_ip.srv where up in (select N from afon_ip.usr where id in (select mob_num from imsi_to_del)) and td > sysdate;

select * from AFON_IP.SRV_ATTR where up in (select N from afon_ip.srv where up in (select N from afon_ip.usr where id in (select mob_num from imsi_to_del)) and td > sysdate) and td > sysdate;


UPDATE usr SET td = sysdate WHERE id in (select mob_num from imsi_to_del ) and SYSDATE BETWEEN fd AND td;


delete from usr
where id in (select mob_num from imsi_to_del );


UPDATE srv_attr SET td = sysdate where UP in
(select UP from srv_attr where up in (select N from srv where login in (select login from imsi_to_del)) and SYSDATE BETWEEN fd AND td);

delete from srv_attr
where UP in
(select UP from srv_attr where up in (select N from srv where login in (select login from imsi_to_del)));


UPDATE srv SET td = sysdate where login in
(select login from imsi_to_del) and SYSDATE BETWEEN fd AND td;

delete from srv
where login in
(select login from imsi_to_del);


select * from usr where id in (select mob_num from imsi_to_del) and td > sysdate

select * from srv where login in (select login from imsi_to_del) and td > sysdate

select * from srv_attr where up in (select N from srv where login in (select login from imsi_to_del)) and td > sysdate

select * from imsi_to_del
