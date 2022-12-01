/*================================ ORDER BY  ===================================
   ORDER BY cümleciği bir SORGU deyimi içerisinde belli bir SUTUN’a göre 
   SIRALAMA yapmak için kullanılır.
   
   Syntax
   -------
	ORDER BY sutun_adı ASC (ASCENDING)   -- ARTAN, DEFAULT
	ORDER BY sutun_adı DESC (DESCENDING)  -- AZALAN
==============================================================================*/   

    
use batch59;

CREATE TABLE kisiler 
(
id int PRIMARY KEY,
ssn CHAR(9) ,
isim VARCHAR(50), 
soyisim VARCHAR(50), 
maas int,
adres VARCHAR(50) 
);
    
INSERT INTO kisiler VALUES(1, 123456789, 'Ali','Can', 3000,'Istanbul');
INSERT INTO kisiler VALUES(2, 234567890, 'Veli','Cem', 2890,'Ankara');
INSERT INTO kisiler VALUES(3, 345678901, 'Mine','Bulut',4200,'Adiyaman');
INSERT INTO kisiler VALUES(4, 256789012, 'Mahmut','Bulut',3150,'Adana');
INSERT INTO kisiler VALUES (5, 344678901, 'Mine','Yasa', 5000,'Ankara');
INSERT INTO kisiler VALUES (6, 345458901, 'Veli','Yilmaz',7000,'Istanbul');
INSERT INTO kisiler VALUES(7, 113456789, 'Ali','Candan', 3500,'Trabzon');
INSERT INTO kisiler VALUES(8, 224567890, 'Veli','Nar', 4890,'Samsun');
INSERT INTO kisiler VALUES(9, 335678901, 'Mine','Sezgin',5200,'Gaziantep');
INSERT INTO kisiler VALUES(10, 446789012, 'Mahmut','Bal', 4150,'Istanbul');
INSERT INTO kisiler VALUES (11, 554678901, 'Mine','Yasar', 8000,'Ankara');
INSERT INTO kisiler VALUES (12, 665458901, 'Veli','Yildiz',8000,'Istanbul');

select * from kisiler;
    
-- SORU1: kisiler tablosunu adres'e göre sıralayarak sorgulayınız.
-- asc kullanilmasina gerek yok, default kucukten buyuge siralar
select * from kisiler order by adres;
 
 
-- SORU2: kisiler tablosunu maaşı büyükten küçüğe göre sırala.
select * from kisiler order by maas desc;


-- SORU3: ismi Mine olanları, maas a göre AZALAN sırada sorgulayınız.
select * from kisiler where isim= 'Mine' order by maas desc;


-- SORU4: soyismi 'i Bulut olanları maas sıralı olarak sorgulayınız.
select * from kisiler where soyisim= 'Bulut' order by maas;





-- ***************************** LİMİT **********************************


select * from kisiler;

-- listeden ilk 10 veriyi getir
select * from kisiler limit 10;


-- 10. veriden sonraki 2 veriyi al (11 ve 12)
select * from kisiler where id>10;
select * from kisiler limit 10,2;   -- 10. dan sonra 2 tanesini al


-- MAAŞ'ı en yüksek 3 kişinin bilgilerini listeleyen sorguyu yazınız.
select * from kisiler order by maas desc limit 3;


/*   -- Oracle SQL cozumu
	select * from kisiler order by maas desc fetch next 3 only;
*/


-- MAAŞ'a göre sıralamada(buyukten kucuge) 4., 5. ve 6. kişilerin bilgilerini listeleyen sorguyu yazınız.

select * from kisiler order by maas desc;
-- siralandiginda 4., 5. ve 6. kisiler söyle;
-- 335678901	Mine	Sezgin	5200	Gaziantep
-- 344678901	Mine	Yasa	5000	Ankara
-- 224567890	Veli	Nar		4890	Samsun


/*   -- Oracle SQL cozumu
	select * from kisiler order by maas desc
    OFFSET 3 ROWS     				--> ilk 3 kaydi atlar
    FETCH NEXT 3 ROWS ONLY;  		--> sonraki 3 kisiyi getirir
*/


select * from kisiler order by maas desc limit 3,3;   -- 3.den sonra 3 tanesini al


-- MAAŞ'a göre sıralamada(buyukten kucuge) 7., 8. ve 9. kişilerin bilgilerini listeleyen sorguyu yazınız.
select * from kisiler order by maas desc limit 6,3; 

