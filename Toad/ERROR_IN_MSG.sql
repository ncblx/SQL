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
 from AFON_SMS40.IN_MSG_INCOMING_ERROR
--   where errorcode = 1
--   where sender not in ('0.1.1191', '0.4.1123', '0.1.772')
  --       and receiver = '1.1.994705855285'
--         and sender not like '1.1.9947%'
--         and sender = '1.1.994776479131'
--         and sender = '1.1.994702000848'
--         and sender = '1.1.994702302033'
--         and sender like '1.1.%'
--         and errorcode = 12
where dt between sysdate - 1 and sysdate
         --AND sender like '5.0.%'
         --AND receiver LIKE '1.1.7%'
         --AND receiver = '1.1.2302501979'
         --AND LENGTH (receiver) = 15
         --AND sender like '%773708720'
         and errorcode=10
--and errorcode=14
--and sender like '1.1.9947%'
order by n desc