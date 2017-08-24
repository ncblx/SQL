select * from imsi_to_del

select * from usr

select * from srv_attr where up in (select N from srv where login in (select login from imsi_to_del))


select * from srv where login in (select login from imsi_to_del)


delete from usr
where id in (select mob_num from imsi_to_del )

delete from srv_attr
where UP in
(
select UP from srv_attr where up in (select N from srv where login in (select login from imsi_to_del))
)


delete from srv
where login in
(
select login from imsi_to_del
)