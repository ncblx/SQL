select trunc(creation_time, 'dd') day,
       '00:00:00-23:59:59' Period,
       'From AZERCELL to AZERFON' Direction,
       count(src) COUNT_MMS,
       count(src) * 0.02 MONEY from mms_stat
where CREATION_TIME between TO_DATE ('01.10.2015', 'dd.mm.yyyy')
                               AND TO_DATE ('31.10.2015', 'dd.mm.yyyy')
   and src_port IS NOT NULL
   and (src like '+99450%' or src like '+99451%')
and CREATION_TIME between TO_DATE ('01.10.2015', 'dd.mm.yyyy')
                               AND TO_DATE ('31.10.2015', 'dd.mm.yyyy')
group by trunc(creation_time, 'dd')
union
select trunc(creation_time, 'dd') day,
       '00:00:00-23:59:59' Period,
       'From AZERFON to AZERCELL' Direction,
       count(src) COUNT_MMS,
       count(src) * 0.02 MONEY
  from mms_stat
where CREATION_TIME between TO_DATE ('01.10.2015', 'dd.mm.yyyy')
                               AND TO_DATE ('31.10.2015', 'dd.mm.yyyy')
   and dst_port Like 'Azercell%'
group by trunc(creation_time, 'dd')
