/* Formatted on 01/11/2014 0:04:30 (QP5 v5.227.12220.39754) */
  SELECT MSISDN,
         PORTING_TIME,
         UPDATE_TIME,
         DECODE (RECIPIENT_OPERATOR_ID,
                 1, 'BAKCELL',
                 2, 'AZERFON',
                 3, 'AZERCELL')
            AS RECIPIENT_NAME,
         DECODE (RECIPIENT_OPERATOR_ID,  1, 'D200',  2, 'D300',  3, 'D100')
            AS RECIPIENT_PERFEX,
         DECODE (DONOR_OPERATOR_ID,
                 1, 'BAKCELL',
                 2, 'AZERFON',
                 3, 'AZERCELL')
            AS DONOR_NAME,
         DECODE (DONOR_OPERATOR_ID,  1, 'D200',  2, 'D300',  3, 'D100')
            AS DONOR_PERFEX,
            DECODE (RECIPIENT_OPERATOR_ID,  1, 'D200',  2, 'D300',  3, 'D100')
         || '+'
         || MSISDN
            AS RESULT
    FROM SMSRELAY.ROUTING_INFO
    where MSISDN IN ('994502954090', '994550102339', '994516808316', '994550102380', '994516808301')
ORDER BY 2 DESC

/* Formatted on 01/11/2014 0:04:30 (QP5 v5.227.12220.39754) */
  SELECT 
         DECODE (RECIPIENT_OPERATOR_ID,  1, 'D200',  2, 'D300',  3, 'D100')
            AS RECIPIENT_PERFEX
    FROM SMSRELAY.ROUTING_INFO
    where MSISDN like '%994516808301';


SELECT 
         DECODE (RECIPIENT_OPERATOR_ID,  1, 'D200',  2, 'D300',  3, 'D100')
            AS RECIPIENT_PERFEX
    FROM SMSRELAY.ROUTING_INFO
    where MSISDN like '%994516808301' 
