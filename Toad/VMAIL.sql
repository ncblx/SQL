select * from in_tmpl_dsc 

select * from in_tmpl_body


/* Formatted on 27.11.2013 2:22:58 (QP5 v5.227.12220.39754) */
SELECT DSC.N, DSC.TMPL_ID,
       DSC.DSC,
       DSC.LANG,
       BODY.BODY
  FROM in_tmpl_dsc DSC
       JOIN in_tmpl_body BODY ON DSC.N = BODY.N 
        WHERE DSC.tmpl_id NOT IN
          ('vMailConfFaxSend',
           'vMailHelloScript',
           'vMailMsgInfo',
           'vMailNotifInterval')

select * from  in_tmpl_dsc DSC join in_tmpl_body BODY on DSC.N=BODY.N and BODY.TD>sysdate