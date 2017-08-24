Например, статистику по лицензионной производительности Вы можете наблюдать в таблице in_estatistics_lic и пользоваться для ее извлечения и анализа запросом вида: 

select fd, license, usage perc, round((usage*limitation)/100,2) usage_abs, limitation lim
from in_estatistics_lic
where fd > sysdate - 3
and license = 'GSM'
order by n desc

Информацию о работе точек и портов вы можете извлекать из БД с помощью запроса вида (используются данные из нескольких таблиц):

select a.n n,
(select b.pc from in_estatistics_point b where a.up = b.n) point,
decode (a.typ, 1, 'GSM', 2, 'CDMA', 3, 'SMPP') port_desc,
(select b.fd from in_estatistics_point b where a.up = b.n) fd,
(select b.td from in_estatistics_point b where a.up = b.n) td,
a.sent_net sent_net,
a.recv_net recv_net,
a.sent_net_unc sent_net_unc,
round(a.hlr_resp, 2) hlr_resp,
round(a.msc_resp, 2) msc_resp,
a.hlr_req hlr_req,
a.msc_req msc_req,
a.clients clients,
a.smpp_trans smpp_trans,
a.sent_app_unc sent_app_unc,
(select c.active from in_estatistics_queue c where a.up = c.up) active,
(select c.messages from in_estatistics_queue c where a.up = c.up) queue,
round((select b.alive from in_estatistics_point b where a.up = b.n), 2) alive,
(select b.memory from in_estatistics_point b where a.up = b.n) memory,
(select b.cpu_load from in_estatistics_point b where a.up = b.n) cpu_load
from in_estatistics_port a
-- where a.up in (select b.n from in_estatistics_point b where b.pc in ('501'))
order by n desc

Назначение полей можно легко понять из их названий.

Статистика по отклоненным сообщениям может быть извлечена запросом вида:

  select pc, port, dt Reject_DT, sender, receiver, cnv_receiver, errorcode err,
         decode (errorcode, -1,   'Undefined error or forwarding', 
                             0,   'OK (former Unknown)', 
                             1,   'Aliasing failed',
                             2,   'Routing failed',
                             3,   'Destination restricted',
                             4,   'Origination restricted',
                             5,   'Bad estimate result',
                             6,   'Message conversion error',
                             7,   'User profile not found',
                             8,   'Unknown anonymous subscriber',
                             9,   'Invalid anonymous subscriber',
                             10,  'Overload',
                             11,  'Screening failed',
                             12,  'There is a lot of undelivered messages for the destination',
                             13,  'DL not found',
                             14,  'MO from fake MSC',
                             15,  'MO without handshake',
                             17,  'Unsupported ACN',
                             18,  'Incorrect destination SCCP address',
                             19,  'No IMSI',
                             100, 'Unknown',
                             '? (new)') description 
 from in_msg_incoming_error
--   where errorcode = 1
--   where sender not in ('0.1.1191', '0.4.1123', '0.1.772')
  --       and receiver = '1.1.994705855285'
--         and sender not like '1.1.9947%'
--         and sender = '1.1.994776479131'
--         and sender = '1.1.994702000848'
--         and sender = '1.1.994702302033'
--         and sender like '1.1.%'
--         and errorcode = 12
where dt between sysdate - 1/24 and sysdate
--and errorcode=14
--and sender like '1.1.9947%'
order by n desc



Прошу сообщить, остались ли у Вас еще вопросы по статистике SMSC. 


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
where a.sms_fd > sysdate - 0.01 
and a.source_address = '1.1.994702777771' 
order by a.sms_fd desc 


SELECT I.SOURCE_ADDRESS,
		S.SOURCE_PORT,
       I.DESTINATION_ADDRESS,
       S.TEXT,
       I.SMS_FD
  FROM in_sms_copm_details i, in_sms_copm s
 WHERE     I.SOURCE_ADDRESS = '1.1.994703239941'
       AND i.sms_fd BETWEEN SYSDATE - 0.01 AND SYSDATE
       AND i.sms_id = s.sms_id
       AND (s.text = 'Sorry, your query could not be processed'
        OR s.text =
              'К сожалению, база данных находится на профилактике.'
        OR s.text LIKE 'K sozhaleniyu, baza danny%')

		
		
		
		SELECT I.SOURCE_ADDRESS,
       I.DESTINATION_ADDRESS,
       S.TEXT,
       I.SMS_FD
  FROM in_sms_copm_details i, in_sms_copm s
 WHERE 
       i.sms_fd BETWEEN SYSDATE - 1/24/12 AND SYSDATE
       AND i.sms_id = s.sms_id
       AND (s.text = 'Sorry, your query could not be processed'
        OR s.text =
              'К сожалению, база данных находится на профилактике.'
        OR s.text LIKE 'K sozhaleniyu, baza danny%')
			  
			  
/* Report for count and attempts */
  SELECT errordecode (last_result_code), SUM (attempt), COUNT (attempt)
    FROM tmp_14102011
GROUP BY last_result_code
ORDER BY SUM (attempt) DESC


SELECT to_char(i.sms_id),
to_char(b.r_ses_n),
b.src_addr,
I.SOURCE_ADDRESS,
       I.DESTINATION_ADDRESS,
       I.SMS_FD,
       b.src_route,
       i.text
  FROM in_sms_copm i, ssc_br b
 WHERE 
       i.sms_fd BETWEEN SYSDATE - 1 AND SYSDATE
       --AND i.sms_id = s.sms_id
       and i.sms_id=b.r_ses_n
       and i.source_address like '1.1.%'
       and (I.DESTINATION_ADDRESS not like '1.1.994%' and i.DESTINATION_ADDRESS not like '0.1.%')
       and b.src_route='4.1.994700040000'
