/* Formatted on 03.07.2014 9:26:06 (QP5 v5.227.12220.39754) */
SELECT params
  FROM afon_sms40.in_service
 WHERE UP IN (SELECT n
                FROM afon_sms40.in_app
               WHERE id = '994702011345')