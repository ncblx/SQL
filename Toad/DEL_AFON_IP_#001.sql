DELETE FROM usr
where id in 


select * from usr_bck;



CREATE TABLE usr_bck AS


DELETE FROM usr
where id in 
(select ID from usr
where id in 
(
'994702011566',
'994702680806',
'994703005553',
'994703768682',
'994703898972',
'994706172702',
'994706173483',
'994706173700',
'994707122333',
'994707167686',
'994707476303',
'994707886707',
'994709950585'
)
--and sysdate between fd and td
)