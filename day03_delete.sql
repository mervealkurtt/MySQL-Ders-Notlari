-- DATA TYPE - VARCHAR

/*
char(size)		: Sabit sayida karakterleri (harf, numara ve ozel karakterler) saklar.
				  size --> saklanacak karakter sayisidir. 0 - 255 arasinda deger alabilir.
						   char(11), char(255)	
				  char --> default olarak 1'dir.
                  SSN, ISBN, Zip Code, Eyalet kisaltmalari (FL, CA, ...)  gibi uzunlugun sabit oldugu durumlarda kullanilir.

varchar(size)	: Farkli uzunluklardaki karakterleri (harf, numara ve ozel karakterler) saklar.
				  size --> saklanacak karakter sayisidir. 0 - 65.535 arasinda deger alabilir.	
*/

use batch59;

create table degisken
(
isim char(25),
adres varchar(655)
);


-- =============================== DELETE ======================================
/*
DELETE FROM tablo_adi;   -- Tablonun tum icerigini siler
DELETE FROM tablo_adi WHERE sutun_adi= veri;   -- Tabloda istedigimiz veriyi siler.
*/

-- Secerek silmek icin WHERE anahtar kelimesi kullanilabilir


create table ogrenciler(
id char(3),
isim varchar(50),
veli_isim varchar(50),
yazili_notu int
);

insert into ogrenciler values('123', 'Ali Can', 'Hasan', '75');
insert into ogrenciler values('124', 'Merve Gul', 'Ayse', '85');
insert into ogrenciler values('125', 'Kemal Yasa', 'Hasan', '85');
insert into ogrenciler values('126', 'Nesibe Yilmaz', 'Ayse', '95');
insert into ogrenciler values('127', 'Mustafa Bak', 'Can', '99');
insert into ogrenciler values('127', 'Mustafa Bak', 'Ali', '99');

select * from ogrenciler;

-- SORU 1 : id'si 124 olan ogrenciyi siliniz
delete from ogrenciler where id='124';

-- SORU 2 : Ismi Kemal Yasa olan satiri siliniz
delete from ogrenciler where isim='Kemal Yasa';

-- SORU 3 : Ismi Nesibe Yilmaz veya Mustafa Bak olan kayitlari siliniz
delete from ogrenciler where isim='Nesibe Yilmaz' or isim='Mustafa Bak';

-- SORU 4 : Ismi Ali Can ve id'si 123 olan kaydi siliniz
delete from ogrenciler where isim='Ali Can' and id='123';

-- SORU 5 : id'si 126'dan buyuk olan kayitlari siliniz
delete from ogrenciler where id>'126';

-- SORU 6 : id'si 123, 125 veya 126 olan kayitlari siliniz
delete from ogrenciler where id in('123','125','126');
delete from ogrenciler where id='123' or id='125' or id='126';

-- SORU 7 : Tablodaki tum kayitlari siliniz
delete from ogrenciler;

drop table ogrenciler;
-- tabloyu siler

-- --------------------

create table ogrenciler(
id char(3),
isim varchar(50),
veli_isim varchar(50),
yazili_notu int
);

insert into ogrenciler values('123', 'Ali Can', 'Hasan', '75');
insert into ogrenciler values('124', 'Merve Gul', 'Ayse', '85');
insert into ogrenciler values('125', 'Kemal Yasa', 'Hasan', '85');
insert into ogrenciler values('126', 'Nesibe Yilmaz', 'Ayse', '95');
insert into ogrenciler values('127', 'Mustafa Bak', 'Can', '99');
insert into ogrenciler values('127', 'Mustafa Bak', 'Ali', '99');
savepoint abc;
SET autocommit=0;

-- savepoint komutuyla tablolari yanlislikla silinmeye karsi korumaya almis oluyoruz.

-- savepoint sikintisi varsa --> SET autocommit=0;
-- Ayarlar -> SQL Execution auto commit unselected yap.

select * from ogrenciler;

delete from ogrenciler;

rollback to abc;
-- rollback komutu, silinen verileri geri getirir


-- =========================== DELETE - TRUNCATE - DROP =================================
/*
1) TRUNCATE komutu, DELETE komutu gibi bir tablodaki verilerin tamamini siler.
   Ancak, secmeli silme yapamaz.
   
   TRUNCATE TABLE WHERE ....  --> bu sekilde kullanilamaz.
*/

truncate table ogrenciler;
-- tablodaki verileri siler

/*
2) DELETE komutu,beraberinde WHERE cumlecigi ile kullanilabilir. TRUNCATE ile kullanilamaz.
   Ancak, secmeli silme yapamaz.
   
   TRUNCATE komutu;
   Tablo yapisini degistirmeden, tablo icinde yer alan tum verileri tek komutla siler.
   
3) DELETE komutu ile silinen veriler ROLLBACK komutu ile kolaylikla geri alinabilir.

4) TRUNCATE ile silinen verilerin geri alinmasi daha zordur.
   Ancak Transaction yontemi ile geri alinmasi mumkun olabilir.

5) DROP komutu da DDL komutudur. Ancak DROP veriler ile taloyu da beraberinde siler.
*/
