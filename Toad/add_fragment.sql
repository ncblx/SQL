declare
  l_final_time  date;
  l_name    varchar2(1000);
  l_n            number;
  l_r_in_storage number;
  l_pr number;
  l_res number;
  l_bank_fr_sn number;
  l_bank_idf number;
  l_sys_idf number;
   lo_final_time date;
  lo_max_final_time date;
  fragment_sn number;
  o_RetVal number;
  o_ContentError varchar2(2000);
  i_AddrOwner_type number := 256;
  i_AddrOwner_value varchar2(256);
  i_ServiceKey number := 1024;
  i_FragmentID number;
begin
 i_AddrOwner_value:='705494399';
 i_FragmentID :=   27562;  
 select n into fragment_sn from in_fragment where up=0 and sysdate between fd and td and idf=i_FragmentID;  
 o_ContentError := NULL;
 -- проверяем есть ли у абонента какой-нибудь фрагмент
 begin
    select /*+ ordered
           use_nl (s c f)
           index(a in_app$id_typ$id$td)
           index(s in_service$up)
           index(c in_cs_srv$up$td)
           index(f in_fragment$up)
           */
           f.n,
           decode(sign(sysdate - f.final_time), 1, 0, decode(sign(f.final_time - sysdate - k_Varx.GetCN('CRBT.FrgmLiveRestForShift')), 1, 0, 1)),
           f.idf 
           into l_bank_fr_sn, l_pr, l_bank_idf
    from in_app a, in_service s, in_cs_srv c, in_fragment f
    where a.id = i_AddrOwner_value
          and a.id_typ = i_AddrOwner_type
          and sysdate between a.fd and a.td
          and s.up = a.n
          and s.servicekey = i_ServiceKey
          and sysdate between s.fd and s.td
          and c.up = s.n
          and sysdate between c.fd and c.td
          and f.up = c.n
          and f.data_typ = decode(sign(-1),-1,f.data_typ,null)
          and sysdate between f.fd and f.td
          and (select /*+ index(l LINKS2$N2)*/ count(1) from LINKS2 l
              where up = 5858 and n2 = f.n and spec = 1 and sysdate between fd and td) = 0;
  exception when
   NO_DATA_FOUND then l_pr:=null;
  end;   
  
  if l_pr is not null then  
     -- получим idf системного фрагмента. 
     -- предполагаем, что фрагмент есть по-любому, т.к. сервис бы не вызвал этот UF

     select /*+ index(in_fragment IN_FRAGMENT$N)*/ idf into l_sys_idf from in_fragment where n=fragment_sn and sysdate between fd and td;
     
     -- если пролонгировать можно и idf системного фрагмента = idf имеющегося, то продляем         
     if l_bank_idf=l_sys_idf then
        -- продляем
        l_res := kk_in_cs_frgm.set_fragment_nch(l_bank_fr_sn, 
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    1,
                                                    null,
                                                    null,
                                                    o_ContentError,
                                                    lo_final_time,
                                                    lo_max_final_time);
        if l_res>0 then 
            o_RetVal:=l_bank_fr_sn;
        else
            o_RetVal:=l_res;
        end if;                                                              
     else 
        -- иначе замещаем фрагмент
        -- Найдем и удалим старый фрагмент
        /* 
        Существует вероятность того что старый фрагмент найти не получается.
        Это ошибка, так как ранее проверили что у абонента есть услуга и фрагмент в банке у него только 1
        */
        select /*+ ordered
                   use_nl (s c f)
                   index(a in_app$id_typ$id$td)
                   index(s in_service$up)
                   index(c in_cs_srv$up$td)
                   index(f in_fragment$up)
               */
               f.n, f.r_in_storage
               into l_n, l_r_in_storage
         from in_app a, in_service s, in_cs_srv c, in_fragment f
         where a.id = i_AddrOwner_value
               and a.id_typ = i_AddrOwner_type
               and sysdate between a.fd and a.td
               and s.up = a.n
               and s.servicekey = i_ServiceKey
               and sysdate between s.fd and s.td
               and c.up = s.n
               and sysdate between c.fd and c.td
               and f.up = c.n
               and sysdate between f.fd and f.td;
        
         o_RetVal := kk_in_cs_frgm.term_fragment(i_AddrOwner_value,
                                                l_n,
                                                l_r_in_storage,
                                                o_ContentError); 
         if o_RetVal > 0 then
                    o_RetVal := kk_in_cs_frgm.copy_fragment(i_AddrOwner_value,
                                                 i_AddrOwner_type,
                                                 i_ServiceKey,
                                                 fragment_sn,
                                                 null,
                                                 null,
                                                 null,
                                                 l_name,
                                                 l_final_time,
                                                 o_ContentError,
                                                 null);
                    if o_RetVal>0 then
                           -- линкуем фрагмент
                           l_res := kk_in_cs_frgm.Link_Frgm_Srv(i_AddrOwner_value,
                                                                i_AddrOwner_type,
                                                                i_ServiceKey,
                                                                o_RetVal,
                                                                null,
                                                                2,
                                                                o_ContentError);
                                                
                           if l_res<>1 then
                              o_RetVal:=l_res;
                           end if;                                                     
                    end if;                             
         end if;                                                                                     
     end if;         
  else
      -- добавляем фрагмент
     o_RetVal := kk_in_cs_frgm.Copy_Fragment(i_AddrOwner_value,
                                              i_AddrOwner_type,
                                              i_ServiceKey,
                                              fragment_sn,
                                              null,
                                              null,
                                              null,
                                              l_name,
                                              l_final_time,
                                              o_ContentError, null);
                                                 
     if o_RetVal>0 then
       -- линкуем фрагмент
       l_res := kk_in_cs_frgm.Link_Frgm_Srv(i_AddrOwner_value,
                                                i_AddrOwner_type,
                                                i_ServiceKey,
                                                o_RetVal,
                                                null,
                                                2,
                                                o_ContentError);
                                                
       if l_res<>1 then
              o_RetVal:=l_res;
       end if;                                                     
     end if;     
  end if;
  if o_RetVal>0 then
    dbms_output.put_line('Fragment successfully aded with sn = '||o_RetVal); 
    update in_fragment set replicated=0 where n=o_RetVal;                                                
  else 
    dbms_output.put_line('Error'); 
    dbms_output.put_line('Code: '||o_ContentError);
  end if;  
exception
        when others then
        o_RetVal := cb_api.eh(o_ContentError);
        o_ContentError := 'CSCopyFragment.others'||chr(13)||o_ContentError;
        dbms_output.put_line('Error'); 
        dbms_output.put_line('Code: '||o_ContentError);
end;
