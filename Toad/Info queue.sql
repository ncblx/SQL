select * from AFON.INFO_QUEUE
where dsc like '%TURBO' and prty = 20
order by fd desc

select * from afon.info_queue
where phone in ('709911129', '708306077', '708422842', '707353625', '705838182', '705577001', '702020614', '703063240', '706376924', '708687674', '707979307')
and dsc like '%TURBO'

select * from afon.info_queue
where phone = '706603982'