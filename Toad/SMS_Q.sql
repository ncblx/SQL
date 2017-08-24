/* Formatted on 08.03.2013 23:33:32 (QP5 v5.227.12220.39754) */
  SELECT a.n n,
         (SELECT b.pc
            FROM afon_sms40.in_estatistics_point b
           WHERE a.UP = b.n)
            point,
         DECODE (a.typ,  1, 'GSM',  2, 'CDMA',  3, 'SMPP') port_desc,
         (SELECT b.fd
            FROM afon_sms40.in_estatistics_point b
           WHERE a.UP = b.n)
            fd,
         (SELECT b.td
            FROM afon_sms40.in_estatistics_point b
           WHERE a.UP = b.n)
            td,
         a.sent_net sent_net,
         a.recv_net recv_net,
         a.sent_net_unc sent_net_unc,
         ROUND (a.hlr_resp, 2) hlr_resp,
         ROUND (a.msc_resp, 2) msc_resp,
         a.hlr_req hlr_req,
         a.msc_req msc_req,
         a.clients clients,
         a.smpp_trans smpp_trans,
         a.sent_app_unc sent_app_unc,
         (SELECT c.active
            FROM afon_sms40.in_estatistics_queue c
           WHERE a.UP = c.UP)
            active,
         (SELECT c.messages
            FROM afon_sms40.in_estatistics_queue c
           WHERE a.UP = c.UP)
            queue,
         ROUND ( (SELECT b.alive
                    FROM afon_sms40.in_estatistics_point b
                   WHERE a.UP = b.n),
                2)
            alive,
         (SELECT b.memory
            FROM afon_sms40.in_estatistics_point b
           WHERE a.UP = b.n)
            memory,
         (SELECT b.cpu_load
            FROM afon_sms40.in_estatistics_point b
           WHERE a.UP = b.n)
            cpu_load
    FROM afon_sms40.in_estatistics_port a
-- where a.up in (select b.n from in_estatistics_point b where b.pc in ('501'))
ORDER BY n DESC



select reciver, count (*) as say from AFON_SMS40.IN_SMS_MESSAGE_SMPP group by reciver order by say desc;

Select * from AFON_SMS40.IN_SMS_MESSAGE_SMPP where sender like '%994703529167'

DELETE FROM  AFON_SMS40.IN_SMS_MESSAGE_SMPP WHERE reciver like '%5.0.NAR'

select *  from AFON_SMS40.IN_SMS_MESSAGE_SMPP where RECIVER like '%994703612425%'

select reciver, count (*) as say from AFON_SMS40.IN_SMS_MESSAGE_01 group by reciver order by say desc;

select sender, count (*) as say from AFON_SMS40.IN_SMS_MESSAGE_00 group by sender order by say desc;

DELETE FROM  AFON_SMS40.IN_SMS_MESSAGE_00 WHERE sender like '%0.1.717'



