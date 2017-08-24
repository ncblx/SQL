select r.n,r.Mob_Num,r.START_DATE,r.Fd,round((r.Fd - r.START_DATE)*24) raznica_hours,round(r.Fd - r.START_DATE) raznica_days,
   d3.term Group_Name,r.Responsible,r.SUBJ,d2.term STATUS,d.term CLASS 
from tt_request_v r,
dic_data d,dic_data d2,links l,tt_persgroup p,dic_data d3
where sysdate between r.fd and r.td 
and sysdate between D.fd and d.td
and sysdate between D2.fd and d2.td
and sysdate between l.fd and l.td
and sysdate between d3.fd and d3.td 
and sysdate between p.fd and p.td
and d3.up=1642 and d3.lang=10 
-- and d3.code=6 
and d3.code=p.name
and l.up=4244 and l.n1=r.n and l.n2=p.n
and r.STATUS  in (1,2,3,4,5,10,14)
-- and r.N not in (select distinct n from ali_temp2)
-- and at.n=r.N
and r.STATUS=d2.code
and r.TT_CLASS=d.code
and d.up=1617
and d3.term='Billing VAS group'
and d.lang=10
and d2.up=1635
and d2.lang=10
order by n desc


select group_name,count(group_name) from (
select r.n,r.Mob_Num,r.START_DATE,r.Fd,round((r.Fd - r.START_DATE)*24) raznica_hours,round(r.Fd - r.START_DATE) raznica_days,
   d3.term Group_Name,r.Responsible,r.SUBJ,d2.term STATUS,d.term CLASS 
from tt_request_v r,
dic_data d,dic_data d2,links l,tt_persgroup p,dic_data d3
where sysdate between r.fd and r.td 
and sysdate between D.fd and d.td
and sysdate between D2.fd and d2.td
and sysdate between l.fd and l.td
and sysdate between d3.fd and d3.td 
and sysdate between p.fd and p.td
and d3.up=1642 and d3.lang=10 
--and r.n in (126933,126864,126549,126473,126279,126259,124656,120911)
-- and d3.code=6 
and d3.code=p.name
and l.up=4244 and l.n1=r.n and l.n2=p.n
and r.STATUS  in (1,2,3,4,5,10,14)
-- and r.N not in (select distinct n from ali_temp2)
-- and at.n=r.N
and r.STATUS=d2.code
and r.TT_CLASS=d.code
and d.up=1617
--and d3.term='Billing VAS group'
and d3.term in ('Billing IN/Prepaid group',
'Billing Postpaid/CRM group',
'Billing VAS group')
and d.lang=10
and d2.up=1635
and d2.lang=10)
--order by n desc
group by group_name


select group_name,Responsible,count(Responsible) from (
select r.n,r.Mob_Num,r.START_DATE,r.Fd,round((r.Fd - r.START_DATE)*24) raznica_hours,round(r.Fd - r.START_DATE) raznica_days,
   d3.term Group_Name,r.Responsible as Responsible,r.SUBJ,d2.term STATUS,d.term CLASS 
from tt_request_v r,
dic_data d,dic_data d2,links l,tt_persgroup p,dic_data d3
where sysdate between r.fd and r.td 
and sysdate between D.fd and d.td
and sysdate between D2.fd and d2.td
and sysdate between l.fd and l.td
and sysdate between d3.fd and d3.td 
and sysdate between p.fd and p.td
and d3.up=1642 and d3.lang=10 
--and r.n in (126933,126864,126549,126473,126279,126259,124656,120911)
-- and d3.code=6 
and d3.code=p.name
and l.up=4244 and l.n1=r.n and l.n2=p.n
and r.STATUS  in (1,2,3,4,5,10,14)
-- and r.N not in (select distinct n from ali_temp2)
-- and at.n=r.N
and r.STATUS=d2.code
and r.TT_CLASS=d.code
and d.up=1617
--and d3.term='Billing VAS group'
and d3.term in ('Billing IN/Prepaid group',
'Billing Postpaid/CRM group',
'Billing VAS group')
and d.lang=10
and d2.up=1635
and d2.lang=10)
--order by n desc
group by Responsible,group_name