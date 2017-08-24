select a.msisdn,ap.partition_id,ap.balance_peak,ap.balance_off_peak,ap.balance_service_rate,ap.balance_promotional,
ap.promotion_expiry_date from pms_account_partition ap,pms_account a
where a.account_id=ap.account_id
and a.msisdn='702000639'
