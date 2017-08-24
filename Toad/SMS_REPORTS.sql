/* Top-up notification(AZ) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%3-u 1-de tarifi ile gunde cemi 40 qepiye bol zeng, SMS ve internet elde et! Tarife qosulmaq ucun 3 yazib%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'huawei_cbs'
ORDER BY insert_date DESC



/* Top-up notification(RU) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%Poluchay mnogo zvonkov, SMS i interneta vsego za 40 kopeek v den s tarifom 3 v 1. Dlya podklyucheniya, otprav 3 na 777. Info: 777-2-1-4%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'huawei_cbs'
ORDER BY insert_date DESC



/* Top-up notification(EN) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%Get lots of calls, SMS and Internet for just 40 kopecks a day with 3 in 1 tariff%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'huawei_cbs'
ORDER BY insert_date DESC



/* Account info notification(AZ) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%AZN. 3-u 1-de tarifi ile zeng, SMS ve data gunde cemi 40 qepiye! 3 yaz 777-ye gonder. Info:777-2-1-4%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'huawei_cbs'
ORDER BY insert_date DESC



/* Account info notification(RU) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%AZN. Zvonki, SMS i data vseqo za 40 kopeek v den v tarife 3 v 1. Otprav 3 na 777. Info:777-2-1-4%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'huawei_cbs'
ORDER BY insert_date DESC



/* Account info notification(EN) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%AZN. Calls, SMS and data for 40 kopecks a day with 3 in 1 tariff. Text 3 to 777. Info:777-2-1-4%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'huawei_cbs'
ORDER BY insert_date DESC



/* Missed Call notification(AZ) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%Dostlarin zeng etsin ve eylensin, kodu yaz 5553 e gonder: Uzeyir Canim-7693%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'ar_mc'
ORDER BY insert_date DESC



/* Missed Call notification(RU) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%Razvleki Druzey otprav 7693 na 5553 4tobi pomenat gudok na Uzeyir "Canim"%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'ar_mc'
ORDER BY insert_date DESC



/* Missed Call notification(EN) */
  SELECT COUNT (*)
    FROM SRF_USER.V_SMSC_A2P_P2A
   WHERE     insert_date BETWEEN TO_DATE ('23.07.2015 00:00:00',
                                          'dd.mm.yyyy HH24:MI:SS')
                             AND TO_DATE ('23.07.2015 23:59:59',
                                          'dd.mm.yyyy HH24:MI:SS')
         AND MESSAGE_TEXT LIKE
                '%Let your friends enjoy calling you,send code to 5553: Uzeyir Canim-7693%'
         AND TRANSACTION_TYPE = 1
         AND ESME_ID = 'ar_mc'
ORDER BY insert_date DESC