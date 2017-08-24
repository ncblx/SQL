/* Formatted on 01.05.2013 16:43:31 (QP5 v5.149.1003.31008) */
DECLARE
   l_res        NUMBER;
   l_err        VARCHAR2 (4000);
   l_sdp_srvk   NUMBER;
   l_lang       NUMBER;
   l_class      NUMBER;
   AppExist     BOOLEAN;
   tempOne      NUMBER;
BEGIN
   k_err.spclearall;
   k_err.sppush;

   l_class := NULL;

   BEGIN
      AppExist := TRUE;

      SELECT 1
        INTO tempOne
        FROM in_app
       WHERE id = :I_1 AND id_typ = 256 AND SYSDATE BETWEEN fd AND td;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         AppExist := FALSE;
   END;
   
      DBMS_OUTPUT.PUT_LINE ( ':O_0 = ' || :O_1 );

   IF :I_3 = 0
   THEN                                    /* При 0-м языке берем язык с ПО */
      IF AppExist
      THEN
         SELECT lang
           INTO l_lang
           FROM in_app
          WHERE id = :I_1 AND id_typ = 256 AND SYSDATE BETWEEN fd AND td;

         :I_3 := NVL (l_lang, 10);
      ELSE
         :I_3 := 10;
      END IF;
   END IF;

   
      DBMS_OUTPUT.PUT_LINE ( ':O_11 = ' || :O_1 );
   IF :I_2 = 256
   THEN /* Если SK=256, это MissedCall, то определяем класс взависимости от языка и NDC*/
      IF SUBSTR (:I_1, 1, 2) = '77'
      THEN
         IF :I_3 = 1
         THEN
            l_class := 13;
         ELSE
            IF :I_3 = 2
            THEN
               l_class := 14;
            ELSE
               l_class := 15;
            END IF;
         END IF;
      ELSE
         IF :I_3 = 1
         THEN
            l_class := 1;
         ELSE
            IF :I_3 = 2
            THEN
               l_class := 8;
            ELSE
               l_class := 11;
            END IF;
         END IF;
      END IF;
   END IF;

   
      DBMS_OUTPUT.PUT_LINE ( ':O_2 = ' || :O_1 );
   l_res :=
      kk_in_srv.create_srvExt (:I_1,                      /* номер абонента */
                               256,                           /* тип номера */
                               :I_2,                   /* EMS - ServiceKey  */
                               l_class,       /* Класс услуги (818 Словарь) */
                               SYSDATE,
                               :I_3,                                /* язык */
                               l_err,                    /* ???????? ?????? */
                               l_sdp_srvk,                 /* SDP serviceKey*/
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL);

DBMS_OUTPUT.PUT_LINE ( 'l_res = ' || l_res );  

 IF (l_res <= 0)
   THEN
      :O_1 := 'Error!!! ' || l_res;
      k_err.sppop;
   ELSE
      IF NOT AppExist
      THEN
         l_res :=
            kk_in_app.set_appextparam (:I_1,                             -- id
                                       256,                          -- id_typ
                                       SYSDATE,
                                       NULL,
                                       NULL,
                                       :I_3,                       -- new_lang
                                       NULL,
                                       NULL,
                                       l_err);
      END IF;

      :O_1 :=
         'Result: ' || l_res || ' err desc=' || l_err || ' SK=' || l_sdp_srvk;
      k_err.spclear;
   END IF;
   DBMS_OUTPUT.PUT_LINE ( ':O_6 = ' || :O_1 );
EXCEPTION
   WHEN OTHERS
   THEN
      :O_1 := 'Error!!!';
      DBMS_OUTPUT.PUT_LINE ( ':O_1 = ' || :O_1 );
      k_err.sppop;
END;
