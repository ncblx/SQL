select * from cardaccounts where firstusedate is null and usedfordirect=1 and DirectCustomerID is null

update cardaccounts
set allowdirect=1,usedfordirect=0
where firstusedate is null and usedfordirect=1 and DirectCustomerID is null

--monthly traffic calculating
select at.accounttype,c.username,sum(c.AcctOutputOctets)/1024/1024/1024 as download 
from calls c,subaccounts sa,accounttypes at
where c.calldate between '1/jul/2010' and '31/jul/2010'
and sa.login=c.username
and sa.accounttypeid=at.accounttypeid
and at.servicegroupid=1
group by c.username,at.accounttype