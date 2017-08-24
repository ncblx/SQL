/* Formatted on 06.11.2012 15:05:39 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM AFON_SMS40.IN_SMS_COPM_INTRANET /*partition (IN_SMS_COPM_INTRANET_10_2015)*/
   WHERE trunc_sms_fd BETWEEN TO_DATE ('10.10.2015', 'dd.mm.yyyy') 
         AND SYSDATE
         --AND TO_DATE ('17.03.2015', 'dd.mm.yyyy')
         --AND source_address = '994702011777'
         --AND destination_address='994703700273'
         --AND destination_address IN ('994702131415', '757')
         --AND source_address IN ('994708677249', '757')
         --OR sorce_address='994703586693'
         --AND destination_address = '994702011360'
         --AND destination_address like '99450%'
         --AND source_address = '717'
         --AND text like '% en azi 2 AZN artirin, hemin meblegin 50%-ni bonus olaraq sebekedaxili deqiqeler seklinde elde edin. Info: 777%'
         --AND status = 5
         --AND text like '%nezerinize chatdirmaq isterdim ki%'
ORDER BY trunc_sms_fd desc


/* Formatted on 08.10.2012 10:53:15 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM afon_sms40.IN_SMS_COPM_INTRANET
   WHERE trunc_sms_fd BETWEEN TO_DATE ('01.08.2013', 'dd.mm.yyyy') 
         --AND TO_DATE ('30.04.2013', 'dd.mm.yyyy')
         AND SYSDATE
         AND destination_address IN  ('994773889393', '757')
         AND source_address IN ('994773889393', '757')
         --AND destination_address = '994705792902'
         --AND source_address='0.1.705'
         --AND text like '%f52e436d-6d4a-46b7-a475-dc581c41a6fa%'
         --AND text like '%Credit%'
ORDER BY sms_fd DESC

/* Formatted on 06.11.2012 15:05:39 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM AFON_SMS40.IN_SMS_COPM_INTRANET partition(in_sms_copm_intranet_11_2013) 
   WHERE trunc_sms_fd BETWEEN TO_DATE ('01.11.2012', 'dd.mm.yyyy') 
         AND SYSDATE
         --AND TO_DATE ('07.12.2012', 'dd.mm.yyyy')
         AND source_address IN ('994773889393', '777')
         AND destination_address IN ('994773889393', '777')
         --AND destination_address = '994702011360'
ORDER BY trunc_sms_fd



  SELECT *
    FROM AFON_SMS40.IN_SMS_COPM_INTRANET
    
    
/* Formatted on 08.10.2012 10:53:15 (QP5 v5.163.1008.3004) */
  SELECT *
    FROM afon_sms40.IN_SMS_COPM_INTRANET
   WHERE trunc_sms_fd BETWEEN TO_DATE ('29.03.2013', 'dd.mm.yyyy') 
         --AND TO_DATE ('29.03.2013', 'dd.mm.yyyy')
         AND SYSDATE
         --AND destination_address IN  ('994705070477', '757')
         AND source_address IN ('994773708720', '994709404953', '994705284889', '994702223510', '994705584921', '994705746361', '994705645787')
         --AND destination_address = '0.1.705'
         --AND source_address='0.1.705'
         --AND text like '%552009292%'
         --AND text like '%Credit%'
ORDER BY sms_fd DESC



/* Formatted on 08/07/2013 18:00:34 (QP5 v5.227.12220.39754) */
SELECT /*+full(a)*/
      DISTINCT a.destination_address, a.text
  FROM afon_sms40.in_sms_copm_intranet
       PARTITION (IN_SMS_COPM_INTRANET_06_2013) a
 WHERE     a.trunc_sms_fd BETWEEN TO_DATE ('06.06.2013', 'dd.mm.yyyy')
                              AND TO_DATE ('12.06.2013', 'dd.mm.yyyy')
       AND a.source_address = '777'
       --AND a.status = '5'
       --AND
       --AND (   a.text LIKE '%Balansinizi 09.06.2013 23:59:59 -dek%'
            --OR a.text LIKE '%Top up your balance till 09.06.2013 23:59:59%'
            --OR a.text LIKE '%Popolnite balans do 09.06.2013 23:59:59%');