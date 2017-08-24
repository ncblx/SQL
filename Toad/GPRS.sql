select * from afon_ip.inet_usr where n= '3870154' --and td>sysdate

select * from AFON_IP.INET_USR where id='994705123456' and td > sysdate

select * from afon_ip.inet_srv where up='3607572' and td > sysdate

select * from AFON_IP.INET_USR where id='994772011904' and td > sysdate

select * from afon_ip.inet_srv where login='400041032791478' --and td > sysdate--where  up=4729896 and td>sysdate





select * from afon_ip.radzones where bplan = 'ZONE0' and domain='AZ';

select * from afon_ip.radzones where mcc='250'

UPDATE afon_ip.radzones SET BPLAN = 'ZONE2' WHERE MCC = '226';

INSERT INTO afon_ip.radzones (MCC, BPLAN, DOMAIN) VALUES ('722','ZONE4','AR');

400041031957239




select sysdate, sysdate -1/144*3 from dual

