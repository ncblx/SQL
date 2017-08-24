select dst,count(dst) as cn,text from (

select a.sms_id, 
(select b.sms_fd from in_sms_copm b where a.sms_id=b.sms_id and rownum = 1) sent, 
a.sms_fd final, 
a.source_address src, 
a.destination_address dst, 
(select b.source_port from in_sms_copm b where a.sms_id=b.sms_id and rownum = 1) src_port, 
(select b.destination_port from in_sms_copm b where a.sms_id=b.sms_id and rownum = 1) dst_port, 
(select b.text from in_sms_copm b where a.sms_id=b.sms_id and rownum = 1) text, 
a.status, 
a.last_result_code result, 
a.attempt, 
(select b.point from in_sms_copm b where a.sms_id=b.sms_id and rownum = 1) pc_recv, 
a.point pc_sent 
from in_sms_copm_details a 
--where a.sms_fd between to_date('02/14/2011 18:00:00','mm/dd/yyyy hh24:mi:ss') and to_date('02/14/2011 23:00:00','mm/dd/yyyy hh24:mi:ss')
where a.sms_fd between sysdate-1 and sysdate
and A.SOURCE_ADDRESS = '0.1.777'
--and a.source_address like  '5.0.0'
--and a.source_address = '0.1.1123'
and A.DESTINATION_ADDRESS = '1.1.994703712405'
and A.STATUS=5
and A.LAST_RESULT_CODE=0
order by a.sms_fd desc;

) group by dst,text order by cn desc