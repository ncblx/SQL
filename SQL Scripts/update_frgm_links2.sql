
declare
       type T_T_ROWID is table of rowid index by binary_integer;
       
       l_T_Td    DBMS_SQL.DATE_TABLE;
       l_T_RowId T_T_ROWID;
       
       l_sysdate DATE;
       l_Link_Up NUMBER := 5758;
       
       cursor c_frgm is
              select /*+ full(f) index(l LINKS2$N2) use_nl(f, l)*/
                     f.Td frgm_td, l.rowid row_id
              from IN_FRAGMENT f, LINKS2 l
              where f.Up > 0
                and f.Final_Time > l_sysdate
                and l_sysdate between f.Fd and f.Td
                and l.Up = l_Link_Up
                and l.N2 = f.n
                and l.Td = (select max(Td) from LINKS2
                            where Up = l.Up and N1 = l.N1 and N2 = l.N2 and Spec = l.Spec)
                and l.Td < l_sysdate;
begin
     l_sysdate := k_Std.Sys_Date;

     open c_frgm;
     fetch c_frgm bulk collect into l_T_Td, l_T_RowId;
     close c_frgm;
     
     forall i in nvl(l_T_Td.first, 0)..nvl(l_T_Td.last, -1)
            update /*+ rowid(l2)*/ LINKS2 l2 set Td = l_T_Td(i) where rowid = l_T_RowId(i);
     
     commit;
end;

