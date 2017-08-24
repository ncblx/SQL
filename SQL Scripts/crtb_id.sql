select  /*+INDEX(IN_APP$N) INDEX(IN_APP$ID_TYP$ID$TD) USE_HASH(iss ics) USE_HASH(iss app)*/ app.id 
from in_service iss , in_app app 
where iss.up=app.n and 
iss.servicekey='1024'
--and app.id='702011345' -- Mobile Number
and iss.td>sysdate
and app.td>sysdate


select  /*+INDEX(IN_APP$N) INDEX(IN_APP$ID_TYP$ID$TD) USE_HASH(iss ics) USE_HASH(iss app)*/ count(iss.n) as cn,app.id 
from in_service iss , in_app app 
where iss.up=app.n and 
iss.servicekey='1024'
--and app.id='702011345' -- Mobile Number
and iss.td>'1/feb/2011 '
--and app.td>sysdate
group by app.id
order by cn desc

/* Formatted on 5/10/2011 17:05:33 (QP5 v5.149.1003.31008) */
SELECT /*+INDEX(IN_APP$N) INDEX(IN_APP$ID_TYP$ID$TD) INDEX(IN_FRAGMENT$IDF) USE_HASH(iss ics) USE_HASH(iss app)*/
      APP.
        ID,
       INF.IDF
  FROM IN_SERVICE ISS,
       IN_APP APP,
       IN_CS_SRV ICS,
       IN_FRAGMENT INF
 WHERE     ISS.UP = APP.N
       AND APP.ID = '702011345'                               -- Mobile Number
       AND ISS.SERVICEKEY = '1024'
       AND ISS.N = ICS.UP
       AND ICS.N = INF.UP
       AND INF.IDF = '18224'
       AND ISS.TD > SYSDATE
       AND ICS.TD > SYSDATE
       AND INF.TD > SYSDATE
       AND APP.TD > SYSDATE