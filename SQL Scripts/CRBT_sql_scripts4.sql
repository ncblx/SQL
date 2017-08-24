declare
  --*******************************************************************************************************************

  -- Обязательные для заполнения входные параметры:
  in_id     string(256) := '10672368'; -- Номер телефона
  in_switch boolean := false; -- выводить или нет имя контент провайдера при селекте фрагментов из in_fragment (true/false)

  --*******************************************************************************************************************

  -- Необязательные для заполнения входные параметры
  in_idf_number varchar2(20) := 201384; -- IDF проблемного фрагмента (null - отвключено).
  -- Если задан, то будет выведена информация по системным фрагментам с данным IDF.

  --*******************************************************************************************************************

  -- Параметры, используемые в скрипте.
  in_n            varchar2(20);
  in_up           varchar2(20);
  in_sk           varchar2(20);
  in_srv          varchar2(20);
  in_lang         varchar2(20);
  in_td           date;
  in_fd           date;
  in_final_time   date;
  in_dsc          string(256) := 'Unknown';
  in_active       varchar2(20);
  in_def_action   varchar2(20);
  in_source       varchar2(20);
  in_source_dsc   string(256) := 'Unknown';
  in_idf          varchar2(20);
  in_replicated   varchar2(20);
  in_n1           varchar2(20);
  in_n2           varchar2(20);
  in_spec         varchar2(20);
  in_id_length    number;
  in_result       number := 0;
  in_r_in_storage varchar2(20);
  in_term         string(256) := 'Unknown';
  in_code         varchar2(20);

  -- курсор для in_app
  Cursor c_in_app is
    select n, lang, fd, td from in_app where id = in_id; -- номер телефона из IN_APP

  -- курсор для in_service
  Cursor c_in_service is
    select in_service.n, in_service.servicekey, in_srv_type.dsc, in_service.fd, in_service.td
      from in_service, in_srv_type
     where in_service.up = (select n
                              from in_app
                             where id = in_id
                               and td > sysdate)
       and in_service.servicekey = in_srv_type.servicekey;

  -- курсор для in_cs_srv
  Cursor c_in_cs_srv is
    select n, up, active, def_action, fd, td
      from in_cs_srv
     where up = (select n
                   from in_service
                  where up = (select n
                                from in_app
                               where id = in_id -- номер телефона из IN_APP
                                 and td > sysdate)
                    and td > sysdate
                    and servicekey = 1024);

  -- Курсор для in_fragment 
  Cursor c_in_fragment is
    select in_fragment.n,
           in_fragment.idf,
           in_fragment.replicated,
           in_fragment.fd,
           in_fragment.td,
           in_fragment.final_time,
           in_fragment.source,
           dic_data.term,
           in_fragment.dsc
      from in_fragment, dic_data
     where in_fragment.up =
           (select in_cs_srv.n
              from in_cs_srv
             where in_cs_srv.up =
                   (select in_service.n
                      from in_service
                     where in_service.up = (select in_app.n
                                              from in_app
                                             where in_app.id = in_id -- номер телефона из IN_APP
                                               and in_app.td > sysdate)
                       and in_service.td > sysdate
                       and in_service.servicekey = 1024) --  SK=1024 --> CRBT
               and in_cs_srv.td > sysdate)
       and dic_data.up = 1836
       and dic_data.lang = 1
       and dic_data.td > sysdate
       and dic_data.code = in_fragment.source;

  -- Курсор для in_fragment 2 (без названия провайдера) 
  Cursor c_in_fragment_2 is
    select n, idf, replicated, fd, td, final_time, source, dsc
      from in_fragment
     where up = (select n
                   from in_cs_srv
                  where up = (select n
                                from in_service
                               where up = (select n
                                             from in_app
                                            where id = in_id -- номер телефона из IN_APP
                                              and td > sysdate)
                                 and td > sysdate
                                 and servicekey = 1024) --  SK=1024 --> CRBT
                    and td > sysdate);

  --курсор для links2
  Cursor c_links2 is
    select n1, n2, spec, fd, td
      from links2
     where up = 5758 -- up=5758 ---> только для услуги CRBT (не менять!!!)
       and n1 = (select distinct up -- cмотрим услугу в in_fragment
                   from in_fragment
                  where up = (select n
                                from in_cs_srv
                               where up = (select n
                                             from in_service
                                            where up = (select n
                                                          from in_app
                                                         where id = in_id -- номер телефона из IN_APP
                                                           and td > sysdate)
                                              and td > sysdate
                                              and servicekey = 1024) --  SK=1024 --> CRBT
                                 and td > sysdate)
                 --and final_time > sysdate
                 )
       and n2 in (select n -- cмотрим фрагменты в in_fragment
                    from in_fragment
                   where up = (select n
                                 from in_cs_srv
                                where up = (select n
                                              from in_service
                                             where up = (select n
                                                           from in_app
                                                          where id = in_id -- номер телефона из IN_APP
                                                            and td > sysdate)
                                               and td > sysdate
                                               and servicekey = 1024) --  SK=1024 --> CRBT
                                  and td > sysdate)
                  --and final_time > sysdate
                  );

  -- Курсор для информации по фрагменту
  Cursor c_in_fragment_3 is
    select n, idf, replicated, fd, td, final_time, source, r_in_storage
      from in_fragment
     where up = 0
       and idf = in_idf_number;

  -- Курсор по провайдерам
  cursor c_dic_data1836 is
    select code, term, fd, td
      from dic_data
     where up = 1836
       and lang = 1;

begin
  -- Проверка корректности введенных входных данных
  select count(*) into in_result from in_app where id = in_id;
  if in_result <> 0 then
    -- выводим номер телефона
    in_id_length := length(in_id) + 14;
    dbms_output.put_line(rpad('-', in_id_length, '-'));
    dbms_output.put_line('| Абонент:  ' || in_id || ' |');
    dbms_output.put_line(rpad('-', in_id_length, '-'));
  
    -- выводим информацию из in_app
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Записи из in_app:');
    dbms_output.put_line(rpad('-', 73, '-'));
    dbms_output.put_line(rpad('|' || 'N', 11) || '|' || rpad('Lang', 15) || '|' || rpad('FD', 22) || '|' ||
                         rpad('TD', 22) || '|');
    dbms_output.put_line(rpad('-', 73, '-'));
    open c_in_app;
    loop
      fetch c_in_app
        into in_n, in_lang, in_fd, in_td;
      exit when c_in_app%NOTFOUND;
      -- данный IF нужен для подсветки активной записи.  
      if in_td > sysdate then
        dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_lang, 15) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad('<---- Активная версия', 50));
        dbms_output.put_line(rpad('-', 73, '-'));
      
      else
        dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_lang, 15) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|');
        dbms_output.put_line(rpad('-', 73, '-'));
      
      end if;
    end loop;
    close c_in_app;
  
    --выводим услуги абонента из in_service
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Услуги абонента в in_service:');
    dbms_output.put_line(rpad('-', 104, '-'));
    dbms_output.put_line('|' || rpad('N', 10) || '|' || rpad('ServiceKey', 15) || '|' ||
                         rpad('DSC', 30) || '|' || rpad('FD', 22) || '|' || rpad('TD', 22) || '|');
    dbms_output.put_line(rpad('-', 104, '-'));
    open c_in_service;
    loop
      fetch c_in_service
        into in_n, in_sk, in_dsc, in_fd, in_td;
      exit when c_in_service%NOTFOUND;
      if in_td > sysdate then
        dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_sk, 15) || '|' ||
                             rpad(in_dsc, 30) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad('<---- Активная версия', 50));
        dbms_output.put_line(rpad('-', 104, '-'));
      
      else
        dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_sk, 15) || '|' ||
                             rpad(in_dsc, 30) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|');
        dbms_output.put_line(rpad('-', 104, '-'));
      
      end if;
    
    end loop;
    close c_in_service;
  
    -- выводим услуги из in_cs_srv
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Услуги из in_cs_srv:');
    dbms_output.put_line(rpad('-', 95, '-'));
    dbms_output.put_line(rpad('|' || 'N', 11) || '|' || rpad('UP', 15) || '|' || rpad('Active', 8) || '|' ||
                         rpad('Def_Action', 11) || '|' || rpad('FD', 22) || '|' || rpad('TD', 22) || '|');
    dbms_output.put_line(rpad('-', 95, '-'));
    open c_in_cs_srv;
    loop
      fetch c_in_cs_srv
        into in_n, in_up, in_active, in_def_action, in_fd, in_td;
      exit when c_in_cs_srv%NOTFOUND;
      -- данный IF нужен для подсветки активной записи.
      if in_td > sysdate then
        dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_up, 15) || '|' ||
                             rpad(in_active, 8) || '|' || rpad(in_def_action, 11) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad('<---- Активная версия', 50));
        dbms_output.put_line(rpad('-', 95, '-'));
      else
        dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_up, 15) || '|' ||
                             rpad(in_active, 8) || '|' || rpad(in_def_action, 11) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|');
        dbms_output.put_line(rpad('-', 95, '-'));
      
      end if;
    end loop;
    close c_in_cs_srv;
  
    -- выводим фрагменты абонента из in_fragment
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Фрагменты абонента из in_fragment:');
    -- Нужно или не нужно выводить имя провайдера
    if in_switch = true then
    
      dbms_output.put_line(rpad('-', 168, '-'));
      dbms_output.put_line('|' || rpad('N', 10) || '|' || rpad('IDF', 10) || '|' ||
                           rpad('REPL', 4) || '|' || rpad(' FD', 22) || '|' || rpad('TD', 22) || '|' ||
                           rpad('FINAL TIME', 22) || '|' || rpad('Source', 8) || '|' ||
                           rpad('Provider', 30) || '|' || rpad('DSC', 30) || '|');
      dbms_output.put_line(rpad('-', 168, '-'));
      open c_in_fragment;
      loop
        fetch c_in_fragment
          into in_n, in_idf, in_replicated, in_fd, in_td, in_final_time, in_source, in_source_dsc, in_dsc;
        exit when c_in_fragment%NOTFOUND;
        -- данный IF нужен для подсветки активной записи.
        if in_td > sysdate and in_final_time > sysdate then
          if in_dsc is null then
            in_dsc := rpad('Empty', 30);
          end if;
          if in_source_dsc is null then
            in_source_dsc := rpad('Not found in dict', 30);
          end if;
          if in_idf is null then
            in_idf := rpad('Not found', 10);
          end if;
          dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_idf, 10) || '|' ||
                               rpad(in_replicated, 4) || '|' ||
                               rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(to_char(in_final_time, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(in_source, 8) || '|' || rpad(in_source_dsc, 30) || '|' ||
                               rpad(in_dsc, 30) || '|' ||
                               rpad('<---- Активная версия', 50));
          dbms_output.put_line(rpad('-', 168, '-'));
        
        else
          if in_dsc is null then
            in_dsc := rpad('Empty', 30);
          end if;
          if in_source_dsc is null then
            in_source_dsc := rpad('Not found in dict', 30);
          end if;
          if in_idf is null then
            in_idf := rpad('Not found', 10);
          end if;
          dbms_output.put_line(rpad('|' || rpad(in_n, 10) || '|' || in_idf, 10) || '|' ||
                               rpad(in_replicated, 4) || '|' ||
                               rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(to_char(in_final_time, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(in_source, 8) || '|' || rpad(in_source_dsc, 30) || '|' ||
                               rpad(in_dsc, 30) || '|');
          dbms_output.put_line(rpad('-', 168, '-'));
        
        end if;
      end loop;
      close c_in_fragment;
    else
      -- без имени провайдера
      dbms_output.put_line(rpad('-', 137, '-'));
      dbms_output.put_line('|' || rpad('N', 10) || '|' || rpad('IDF', 10) || '|' ||
                           rpad('REPL', 4) || '|' || rpad(' FD', 22) || '|' || rpad('TD', 22) || '|' ||
                           rpad('FINAL TIME', 22) || '|' || rpad('Source', 8) || '|' ||
                           rpad('DSC', 30) || '|');
      dbms_output.put_line(rpad('-', 137, '-'));
      open c_in_fragment_2;
      loop
        in_idf := 0;
        fetch c_in_fragment_2
          into in_n, in_idf, in_replicated, in_fd, in_td, in_final_time, in_source, in_dsc;
        exit when c_in_fragment_2%NOTFOUND;
        -- данный IF нужен для подсветки активной записи.
        if in_td > sysdate and in_final_time > sysdate then
          if in_dsc is null then
            in_dsc := rpad('Empty', 30);
          end if;
          if in_source_dsc is null then
            in_source_dsc := rpad('Not found in dict', 30);
          end if;
          if in_idf is null then
            in_idf := rpad('Not found', 10);
          end if;
        
          dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_idf, 10) || '|' ||
                               rpad(in_replicated, 4) || '|' ||
                               rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(to_char(in_final_time, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(in_source, 8) || '|' || rpad(in_dsc, 30) || '|' ||
                               rpad('<---- Активная версия', 50));
          dbms_output.put_line(rpad('-', 137, '-'));
        
        else
          if in_dsc is null then
            in_dsc := rpad('Empty', 30);
          end if;
          if in_source_dsc is null then
            in_source_dsc := rpad('Not found in dict', 30);
          end if;
          if in_idf is null then
            in_idf := rpad('Not found', 10);
          end if;
        
          dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_idf, 10) || '|' ||
                               rpad(in_replicated, 4) || '|' ||
                               rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(to_char(in_final_time, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                               rpad(in_source, 8) || '|' || rpad(in_dsc, 30) || '|');
          dbms_output.put_line(rpad('-', 137, '-'));
        
        end if;
      end loop;
      close c_in_fragment_2;
    
    end if;
  
    -- Выводим информацию из links2
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Привязка фрагментов к услуге в таблице links2, где');
    dbms_output.put_line('- N1 - ссылка in_cs_srv.N');
    dbms_output.put_line('- N2 - ссылка на in_fragment.N');
    dbms_output.put_line('- SPEC=2 - означает событие "входящий вызов"');
  
    dbms_output.put_line(rpad('-', 75, '-'));
    dbms_output.put_line('|' || rpad('N1', 10) || '|' || rpad('N2', 10) || '|' || rpad('SPEC', 6) || '|' ||
                         rpad(' FD', 22) || '|' || rpad('TD', 22) || '|');
    dbms_output.put_line(rpad('-', 75, '-'));
    open c_links2;
    loop
      fetch c_links2
        into in_n1, in_n2, in_spec, in_fd, in_td;
      exit when c_links2%NOTFOUND;
      -- данный IF нужен для подсветки активной записи.
      if in_td > sysdate then
        dbms_output.put_line('|' || rpad(in_n1, 10) || '|' || rpad(in_n2, 10) || '|' ||
                             rpad(in_spec, 6) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad('<---- Активная версия', 50));
        dbms_output.put_line(rpad('-', 75, '-'));
      else
        dbms_output.put_line('|' || rpad(in_n1, 10) || '|' || rpad(in_n2, 10) || '|' ||
                             rpad(in_spec, 6) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|');
        dbms_output.put_line(rpad('-', 75, '-'));
      end if;
    end loop;
    close c_links2;
  else
    dbms_output.put_line('В БД отсутствует Приложение Обслуживания для введенного номера телефона!!!');
  end if;

  -- Вывод информации по фрагменту, если задан его IDF
  if in_idf_number is not null then
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Информация по системному фрагменту с IDF = ' || in_idf_number);
    dbms_output.put_line(rpad('-', 127, '-'));
    dbms_output.put_line('|' || rpad('N', 10) || '|' || rpad('IDF', 10) || '|' || rpad('REPL', 4) || '|' ||
                         rpad('FD', 22) || '|' || rpad('TD', 22) || '|' || rpad('FINAL TIME', 22) || '|' ||
                         rpad('SOURCE', 8) || '|' || rpad('R_IN_STORAGE', 20) || '|');
    dbms_output.put_line(rpad('-', 127, '-'));
    open c_in_fragment_3;
    loop
      fetch c_in_fragment_3
        into in_n, in_idf, in_replicated, in_fd, in_td, in_final_time, in_source, in_r_in_storage;
      exit when c_in_fragment_3%NOTFOUND;
      -- данный IF нужен для подсветки активной записи.
      if in_td > sysdate then
        if in_dsc is null then
          in_dsc := rpad('Empty', 30);
        end if;
        if in_source_dsc is null then
          in_source_dsc := rpad('Not found in dict', 30);
        end if;
        if in_idf is null then
          in_idf := rpad('Not found', 10);
        end if;
        dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_idf, 10) || '|' ||
                             rpad(in_replicated, 4) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_final_time, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(in_source, 8) || '|' || rpad(in_r_in_storage, 20) || '|' ||
                             rpad('<---- Активная версия', 50));
        dbms_output.put_line(rpad('-', 127, '-'));
      
      else
        if in_dsc is null then
          in_dsc := rpad('Empty', 30);
        end if;
        if in_source_dsc is null then
          in_source_dsc := rpad('Not found in dict', 30);
        end if;
        if in_idf is null then
          in_idf := rpad('Not found', 10);
        end if;
        dbms_output.put_line('|' || rpad(in_n, 10) || '|' || rpad(in_idf, 10) || '|' ||
                             rpad(in_replicated, 4) || '|' ||
                             rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(to_char(in_final_time, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                             rpad(in_source, 8) || '|' || rpad(in_r_in_storage, 20));
        dbms_output.put_line(rpad('-', 127, '-'));
      
      end if;
    end loop;
    close c_in_fragment_3;
  else
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Номер IDF не был задан, поэтому инфомация по системным фрагментам не выводится');
  end if;

  -- Выводим информацию по контент провайдерам
  dbms_output.put_line(' ');
  dbms_output.put_line(' ');
  dbms_output.put_line('Контент-провайдеры:');
  dbms_output.put_line(rpad('-', 79, '-'));
  dbms_output.put_line('|' || rpad('Code', 10) || '|' || rpad('Provider', 20) || '|' ||
                       rpad('FD', 22) || '|' || rpad('TD', 22) || '|');
  dbms_output.put_line(rpad('-', 79, '-'));
  open c_dic_data1836;
  loop
    fetch c_dic_data1836
      into in_code, in_term, in_fd, in_td;
    exit when c_dic_data1836%NOTFOUND;
    dbms_output.put_line('|' || rpad(in_code, 10) || '|' || rpad(in_term, 20) || '|' ||
                         rpad(to_char(in_fd, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|' ||
                         rpad(to_char(in_td, 'dd.mm.yyyy hh24:mi:ss'), 22) || '|');
    dbms_output.put_line(rpad('-', 79, '-'));
  
  end loop;
  close c_dic_data1836;

end;