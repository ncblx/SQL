/*  
 *   ������ ��� ��������� ���������� ��� ��� ������� ���������� �����
 *   �������� ��������� ��� �� �������� ������
 *   ���������� SMS �� �������� ������� �� NUM_CALLS 3330
 *    757 
 *   3300 3311 3322 3330 3331 3333
 *   3334 3335 3336 3344 3355 3377 
 *   8550 8553
 */
  select num, count(num) 
    from afon.num_calls 
   where num in ('757',  
                 '3300', '3311', '3322', '3330', '3331', '3333',
                 '3334', '3335', '3336', '3344', '3355', '3377', 
                 '8550', '8553')
     and dir like 'O' 
     and (strt  between TO_DATE('01.03.2008 0:0:1','DD.MM.YYYY HH24:Mi:SS') 
                    and TO_DATE('31.03.2008 23:59:59','DD.MM.YYYY HH24:Mi:SS')) 
     and transac between
                 (select min(t_from)from afon.cdr_transac_dates 
                   where TO_DATE('01.03.2008 0:0:1','DD.MM.YYYY HH24:Mi:SS') 
                    between dt_from and dt_to)
               and
                 (select max(t_to)from afon.cdr_transac_dates 
                   where TO_DATE('31.03.2008 23:59:59','DD.MM.YYYY HH24:Mi:SS') 
                    between dt_from and dt_to)
group by num
--order by num
/*��� ����� ������ �������� � 1 �� 17 ������ ������������ � � 18 �� 30 ��������
3334
3311
3322
3335
3333
3336
*/
 
/*
 *  ������ ��� ��������� ���������� ��� ��� ������� ���������� ��������
 *  �������� ��������� ��� �� �������� ������
 *  ���������� SMS �� �������� ������� �� NUM_CALLS
 */
  select num, count(num) 
    from afon.num_calls 
   where num like '30%' 
     and length(num) = 4 
     and dir like 'O' 
     and (strt  between TO_DATE('01.03.2008 0:0:1','DD.MM.YYYY HH24:Mi:SS') 
                    and TO_DATE('31.03.2008 23:59:59','DD.MM.YYYY HH24:Mi:SS')) 
     and transac between
                 (select min(t_from)from afon.cdr_transac_dates 
                   where TO_DATE('01.03.2008 0:0:1','DD.MM.YYYY HH24:Mi:SS') 
                    between dt_from and dt_to)
               and
                 (select max(t_to)from afon.cdr_transac_dates 
                   where TO_DATE('31.03.2008 23:59:59','DD.MM.YYYY HH24:Mi:SS') 
                    between dt_from and dt_to)
group by num 
--order by num desc

/*
 *  ������ ��� ��������� ���������� ��� ��� ������� ���������� DMW.
 *  �������� ��������� ��� �� �������� ������
 *  ���������� SMS �� �������� ������� �� NUM_CALLS
 */
  select num, count(num) 
    from afon.num_calls 
   where num like '31%' 
     and length(num) = 4 
     and dir like 'O' 
     and (strt  between TO_DATE('01.03.2008 0:0:1','DD.MM.YYYY HH24:Mi:SS') 
                    and TO_DATE('31.03.2008 23:59:59','DD.MM.YYYY HH24:Mi:SS')) 
     and transac between
                 (select min(t_from)from afon.cdr_transac_dates 
                   where TO_DATE('01.03.2008 0:0:1','DD.MM.YYYY HH24:Mi:SS') 
                    between dt_from and dt_to)
               and
                 (select max(t_to)from afon.cdr_transac_dates 
                   where TO_DATE('31.03.2008 23:59:59','DD.MM.YYYY HH24:Mi:SS') 
                    between dt_from and dt_to)
group by num 
--order by num desc
