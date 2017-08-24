sql-ex


/* Formatted on 07.01.2013 11:23:15 (QP5 v5.227.12220.39754) */
SELECT model, speed, hd
  FROM PC
 WHERE price < '500.0000'

/* Formatted on 07.01.2013 11:23:05 (QP5 v5.227.12220.39754) */
SELECT DISTINCT maker
  FROM Product
 WHERE TYPE = 'Printer'

/* Formatted on 07.01.2013 11:21:19 (QP5 v5.227.12220.39754) */
SELECT model, ram, screen
  FROM Laptop
 WHERE price > '1000.0000'

/* Formatted on 07.01.2013 11:21:08 (QP5 v5.227.12220.39754) */
SELECT *
  FROM Printer
 WHERE color = 'y'

/* Formatted on 07.01.2013 11:20:56 (QP5 v5.227.12220.39754) */
SELECT model, speed, hd
  FROM PC
 WHERE cd IN ('12x', '24x') AND price < 600

/* Formatted on 07.01.2013 11:20:37 (QP5 v5.227.12220.39754) */
SELECT DISTINCT pr.maker, lt.speed
  FROM product pr JOIN laptop lt ON pr.model = lt.model
 WHERE lt.hd >= 10

/* Formatted on 07.01.2013 11:21:41 (QP5 v5.227.12220.39754) */
SELECT model, price
  FROM PC
 WHERE model = (SELECT model
                  FROM Product
                 WHERE maker = 'B' AND TYPE = 'PC')
UNION
SELECT model, price
  FROM Laptop
 WHERE model = (SELECT model
                  FROM Product
                 WHERE maker = 'B' AND TYPE = 'Laptop')
UNION
SELECT model, price
  FROM printer
 WHERE model = (SELECT model
                  FROM Product
                 WHERE maker = 'B' AND TYPE = 'Printer')
				 
