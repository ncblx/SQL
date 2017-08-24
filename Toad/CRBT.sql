SELECT *
    FROM SRF_USER.MESSAGE_LOG
        WHERE insert_date BETWEEN TO_DATE ('18.11.2015', 'dd.mm.yyyy') 
        AND SYSDATE
        AND MESSAGE_TEXT like '%Bagislayin sorgunuz qebul olunmadi. Sorgunu yeniden tekrar edin.%'
        AND TRANSACTION_TYPE = 1
        ORDER BY insert_date DESC
        
        
SELECT *
    FROM SRF_USER.MESSAGE_LOG
        WHERE insert_date BETWEEN TO_DATE ('22.09.2015', 'dd.mm.yyyy') 
        AND SYSDATE
        AND esme_id = 'ar_rbt'
        ORDER BY insert_date DESC
        
        
        
SELECT *
    FROM SRF_USER.MESSAGE_LOG
        WHERE insert_date BETWEEN TO_DATE ('22.09.2015', 'dd.mm.yyyy') 
        AND SYSDATE
        AND DESTINATION_ADDRESS like '%.757'
        --AND DESTINATION_ADDRESS IN ('1.1.994708048064', '0.1.757')
        --AND SOURCE_ADDRESS IN ('1.1.994708048064', '0.1.757')
        ORDER BY insert_date DESC