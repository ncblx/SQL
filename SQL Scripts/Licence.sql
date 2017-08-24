SMSAsap

select fd, license, usage perc, round((usage*limitation)/100,2) usage_abs, limitation lim
from in_estatistics_lic
where fd > sysdate - 3
and license = 'GSM'
order by n desc 