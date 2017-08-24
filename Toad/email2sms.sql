SELECT /*+ index(a IN_SERVICE\$UP) */
      *
  FROM afon_in40.in_service a
 WHERE     UP = (SELECT distinct N
                   FROM afon_in40.in_app
                  WHERE id = '702011360' AND td > SYSDATE AND id_typ = 256)
       AND servicekey IN ('40', '41')
       AND td > SYSDATE