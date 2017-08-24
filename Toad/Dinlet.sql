select * from afon_in40.in_app where id='704385828' and td > sysdate;

select * from afon_in40.in_service where n='4883355' and td > sysdate;

select * from afon_in40.in_cs_srv where n='4096897' and td > sysdate;

select * from afon_in40.in_fragment where up='4096897' and td > sysdate;

update afon_in40.in_fragment set td = sysdate where up = '4117199'

select * from afon_in40.IN_STORAGE where n='223920' --znaceniye

select * from afon_in40.in_fragment where idf ='679462' and td > sysdate and up = 0

select DISTINCT IDF from afon_in40.in_fragment where td > sysdate and UP > '0'

select DISTINCT IDF from afon_in40.in_fragment where td < sysdate and UP = '0' 

update afon_in40.in_cs_srv set active='1'  where up='8994649' and td > sysdate; 

UPDATE afon_in40.in_fragment SET REPLICATED = '0'  WHERE idf ='2241' and td > sysdate and final_time > sysdate

select count(*) from afon_in40.in_service where SERVICEKEY='1024'
and fd between sysdate-15/1440 and sysdate


update afon_in40.in_fragment set td = sysdate where up='4488638' and n='5793660'and td > sysdate;