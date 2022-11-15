-- ===================== CONSTRAINTS - KISITLAMALAR ======================================
/*           
    NOT NULL	- Bir Sütunun  NULL içermemesini yani boş olmamasını sağlar.
    UNIQUE		- Bir sütundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar.  
    PRIMARY KEY	- Bir sütünün NULL içermemesini ve sütundaki verilerin
                  BENZERSİZ olmasını sağlar. (NOT NULL ve UNIQUE)
    FOREIGN KEY	- Başka bir tablodaki Primary Key’i referans göstermek için kullanılır.
				  Böylelikle, tablolar arasında ilişki kurulmuş olur.
                  foreign ve primary ile tablolar birbirine bağlamadan da, id leri ayni olan 
                  satirlarda işlem yap diyebiliriz, böylelikle
                  ayni field verilebilir, parent child ilişkisi olmamiş olur
​
-- ========================================================================================*/

use batch59;
 
 create table calisanlar
(
id char(5) PRIMARY key, -- not null + unique
isim varchar(50) UNIQUE,
maas int not null,
ise_baslama date
);

insert into calisanlar values('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
insert into calisanlar values('10008', null, 5000, '2018-04-14');
insert into calisanlar values('10010', null, 5000, '2018-04-14'); 
insert into calisanlar values('10020', null, 5000, '2018-04-14');   -- unique icin 2. ve daha fazla null engel degil
insert into calisanlar values('10005', 'Mustafa Ali', 5000, '2018-04-14');
insert into calisanlar values('10006', 'Canan Yaş', null, '2019-04-12');   -- maas null olamaz
insert into calisanlar values('10003', 'CAN', 5000, '2018-04-14');
insert into calisanlar values('10007', 'CAN', 5000, '2018-04-14');   -- isim unique olmali
insert into calisanlar values('10009', 'cem', '', '2018-04-14');   -- int tanimlanan veri '' olamaz
insert into calisanlar values('', 'osman', 2000, '2018-04-14');
insert into calisanlar values('', 'osman can', 2000, '2018-04-14');   -- bosluk ('') olan id zaten var
insert into calisanlar values('', 'veli can', 6000, '2018-04-14');   -- bosluk ('') olan id zaten var
insert into calisanlar values( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');   -- id= 10002 zaten mevcut
insert into calisanlar values( null, 'filiz ' ,12000, '2018-04-14');   -- id null olamaz
     
select * from calisanlar;


-- KISITLAMALAR ( FOREIGN KEY )
     
create table adresler
(
adres_id char(5),    
sokak varchar(50),
cadde varchar(30),
sehir varchar(15),
constraint id_clsnlr foreign key(adres_id) references calisanlar(id) 
-- adresler tablosundaki 'adres_id' ile calisanlar tablosundaki 'id', 'id_clsnlr' foreign key ile birbirine baglandi.
-- (solda tablo seçiliyken üstteki info dan ismi kontrol edilebilir)
);
   
insert into adresler values('10003','Mutlu Sok', '40.Cad.','IST');
insert into adresler values('10003','Can Sok', '50.Cad.','Ankara');
insert into adresler values('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;

-- parent tabloda olmayan id ile child a ekleme yapamayiz
insert into adresler values('10012','Ağa Sok', '30.Cad.','Antep');
   
-- FK'ye null değeri atanabilir.
insert into adresler values(null,'Ağa Sok', '30.Cad.','Antep');
insert into adresler values(null,'Ağa Sok', '30.Cad.','Maraş');

select * from adresler;

select * from calisanlar;

-- Iki tabloda ortak olan verileri getririr
select * from calisanlar, adresler where calisanlar.id = adresler.adres_id;

drop table calisalar;
-- calisanlar tablosunu silmeyecek çünkü
-- CONSTRAINT id_clsnlr FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
-- komutu ile calişanların idleri ile adres id leri birbirine bağladık.
-- bağlanti tablolarda child silinmeden parent silinmez

drop table calisanlar;
-- adreler table'ini silebiliyoruz

-- child table silindikten sonra parent table de silinebilir

delete from calisanlar where id='10002';   -- parent
-- baglantili oldugu icin silemeyiz

delete from adresler where adres_id='10002';   -- child


/*============================== ON DELETE CASCADE =============================
  Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme özelliğini aktif hale getirebiliriz.
 
  Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmak yeterli
 
==============================================================================*/

create table talebeler
(
id CHAR(3) primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
   
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

select * from talebeler;

CREATE TABLE notlar
( talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade);

-- on delete cascade sayesinde
-- parent taki silinen bir kayıt ile ilişkili olan tüm child kayıtlarını siler.  
-- cascade yoksa önce child'in temizlenmesi lazim sonra parent'in temizlenmesi lazim

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90); 
   
select * from notlar;

-- FK ile birleştirilen tablolardaki tüm verileri çekmek için
-- JOIN İşlemi yapmak gerekir.
select * from talebeler, notlar where talebeler_id = notlar.talebe_id;

delete from notlar where talebe_id='123';   -- child
-- child tablodaki veriyi sildigimiz zaman sadece child'daki veri silinir, parent'taki silinmez

delete from talebeler where id='126';   -- parent
-- parent tablodakiveriyi sildigimiz zaman child'daki veri de silinir..
