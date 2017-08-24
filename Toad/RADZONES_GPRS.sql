select * from AFON_IP.RADZONES where mcc='901'

INSERT INTO AFON_IP.RADZONES (MCC, BPLAN, DOMAIN) VALUES ('627', 'ZONE5', 'GQ');


--UPDATE AFON_IP.RADZONES SET MCC ='440', DOMAIN = 'JP' WHERE BPLAN = 'ZONE3';  


UPDATE AFON_IP.RADZONES SET BPLAN = 'ZONE3' WHERE MCC ='230' AND DOMAIN = 'CZ'


select * from radzones where domain='GQ'

select * from radzones where bplan = 'ZONE4'


select * from radzones where BPLAN = 'ONAIR'

delete from radzones where bplan= 'ZONE0'