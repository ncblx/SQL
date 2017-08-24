select  d.term,r.N N,r.START_DATE,r.Fd,round((r.Fd-r.START_DATE)*24) raznica_hours,round((r.Fd-r.START_DATE)) raznica_days
-- r.Td,l.fd,l.td,r.STATUS
  -- min(l.fd) fd,min(l.td) td 
from tt_request_v r,
(select l1.* from links l1,(select * from links l3
where 
-- l.n1=48760
-- and 
td='01-jan-2018'
and l3.up=4244) l2
where 
l1.up=4244
and l1.n1=l2.n1
 and l1.td=l2.fd-1/86400) l,
tt_persgroup p,dic_data d where 
 sysdate between d.fd and d.td 
 and sysdate between p.fd  and p.td 
 and sysdate between r.Fd and r.Td
 and d.up=1642 
 and d.lang=10 
-- and d.code=6
 and d.code=p.name
and l.up=4244 
and l.n1=r.n 
and l.n2=p.n 
and r.STATUS in (6,7,8,9,11,12,13)
and r.Fd>'01-jan-2010'
-- and r.N=42362
-- group by d.term,r.N
