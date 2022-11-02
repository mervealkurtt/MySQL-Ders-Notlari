use batch59;

create table ogrenciler
(
id int,
isim varchar(40),
adres varchar(100),
sinav_notu int
);

insert into ogrenciler values('120','Ali Can','Ankara','75');
insert into ogrenciler values('121','Veli Mert','Trabzon','85');
insert into ogrenciler values('122','Ayse Tan','Bursa','65');
insert into ogrenciler values('123','Derya Soylu','Istanbul','95');
insert into ogrenciler values('124','Yavuz Bal','Ankara','80');

select * from ogrenciler;

-- SELECT - WHERE
/*
Verileri SELECT komutu ile veritabanından cekerken filtreleme yapmak icin
SELECT ile brlikte WHERE komutu kullanilir.
SELECT sutun1, sutun2 ...
FROM tablo adi WHERE kosul
*/

-- SORU 01 : Sinav sonucu 80'den buyuk olan ogrencilerin bilgilerini listeleyin
select  * from ogrenciler where sinav_notu>80;

-- SORU 02 : Adresi Ankara olan ogrencilerin isim ve adres bilgilerini listeleyin
select isim, adres from ogrenciler where adres='Ankara';

-- SORU 03 : id'si 124 olan ogrencilerin tum bilgilerini listeleyin
select * from ogrenciler where id='124';

-- SORU 04 : id'si 121 olan ogrencilerin adres ve sinav notunu listeleyin
select adres, sinav_notu from ogrenciler where id='121';


create table personel
(
id char(4),
isim varchar(40),
maas int
);

insert into personel values('1001','Ali Can','70000');
insert into personel values('1002','Veli Mert','85000');
insert into personel values('1003','Ayse Tan','65000');
insert into personel values('1004','Derya Soylu','95000');
insert into personel values('1005','Yavuz Bal','80000');
insert into personel values('1006','Sena Beyaz','100000');

select * from personel;

-- BETWEEN
/*
Belirttigimiz iki veri arasindaki bilgileri listeler
SELECT sutun1, sutun2 ...
FROM tablo adi WHERE (kosul) BETWEEN id1 and id2
Between'de kullanilan sinir degerler dahildir
*/

-- SORU 05 : id'si 1002 ile 1005 arasinda olan personel bilgilerini listeleyin
select * from personel where id between 1002 and 1005;
select * from personel where id>=1002 and id<=1005;

-- SORU 06 : Derya Soylu ile Yavuz Bal arasindaki olan personel bilgilerini listeleyin
select * from personel where isim between 'Derya Soylu' and 'Yavuz Bal';


-- in
/*
Birden fazla ifade ile tanimlayabilecek durumlarda kullanilir.
Parantez icinde yazilan verileri getirir
*/

-- SORU 07 : id'si 1001, 1002 ve 1004 olan personel bilgilerini listeleyin
select * from personel where id='1001' or id='1002' or id='1004';
select * from personel where id in(1001,1002,1004);


-- SORU 08 : Maasi sadece 70000 ve 100000 olan personel listeleyin
select * from personel where maas in(70000,100000);


-- SELECT - LIKE
/*
LIKE : Sorgulama yaparken belirli patternleri kullanabilmemizi saglar.

SELECT sutun1, sutun2, ...
FROM tablo_adi WHERE sutun LIKE pattern

PATTERN içim ;
%  : 0 veya daha fazla karakteri belirtir
_  : Tek bir karakteri belirtir.
*/

-- SORU 09 : Ismi A harfi ile baslayan personeli listele
select * from personel where isim like 'A%';

-- SORU 10 : Ismi N harfi ile biten personeli listele
select * from personel where isim like '%N';

-- SORU 11 : Isminin 2. harfi E olan personeli listele
select * from personel where isim like '_E%';

-- SORU 12 : Isminin 2. harfi E olup diger harflerinde Y olan personeli listele
select * from personel where isim like '_E%Y%';

-- SORU 13 : Isminde A harfi olmayan personeli listele
select * from personel where isim not like '%A%';

-- SORU 14 : Isminde A harfi olan personeli listele
select * from personel where isim like '%A%';

-- SORU 15 : Maasi 6 haneli olan personeli listele
select * from personel where maas like '______';

-- SORU 16 : 1.harfi A ve 7.harfi A olan personeli listele
select * from personel where isim like 'A_____A%';



/* *************** SELECT - REGEXP_LIKE ***************
   Daha karmasik pattern ile sorgulama islemi icin REGEXP_LIKE kullanilabilir.
   c  : case-sensitive demektir
   i  : case-insensitive demektir ve default incase-sensitive aktiftir.
   
   Syntax:
   REGEXP_LIKE(sutun_adi, 'pattern[]', 'c')
*/

create table kelimeler
(
id int unique,
kelime varchar(50) not null,
harf_sayisi int
);

insert into kelimeler values (1001, 'hot', 3);
insert into kelimeler values (1002, 'hat', 3);
insert into kelimeler values (1003, 'hit', 3);
insert into kelimeler values (1004, 'hbt', 3);
insert into kelimeler values (1005, 'hct', 3);
insert into kelimeler values (1006, 'adem', 4);
insert into kelimeler values (1007, 'selim', 5);
insert into kelimeler values (1008, 'yusuf', 5);
insert into kelimeler values (1009, 'hip', 3);
insert into kelimeler values (1010, 'HOT', 3);
insert into kelimeler values (1011, 'h0t', 3);
insert into kelimeler values (1012, 'h9t', 3);
insert into kelimeler values (1013, 'hoot', 4);
insert into kelimeler values (1014, 'haaat', 5);
insert into kelimeler values (1015, 'hooooot', 5);

select * from kelimeler;

-- SORU 16: Icerisinde 'ot' veya 'at' bulunan kelimeleri kucuk harfe dikkat ederek listeleyiniz
-- VEYA islemi için | karakteri kullanılır.
select * from kelimeler where regexp_like (kelime, 'ot|at', 'c');


-- SORU 17: Icerisinde 'ot' veya 'at' bulunan kelimeleri buyuk-kucuk harfe dikkat etmeksizin listeleyeniz
select * from kelimeler where regexp_like (kelime, 'ot|at', 'i');
-- i kullanmaya gerek yok, default deger i 
select * from kelimeler where regexp_like (kelime, 'ot|at');

-- SORU 18: 'ho' veya 'hi' ile baslayan kelimeleri buyuk-kucuk harfe dikkat etmeksizin listeleyeniz
-- Başlangıcı göstermek için ^ karakteri kullanilir.
select * from kelimeler where regexp_like (kelime, '^ho|hi');
select * from kelimeler where regexp_like (kelime, '^ho|^hi');

-- SORU 19: Sonu 't' veya 'm' ile bitenleri buyuk-kucuk harfe dikkat etmeksizin listeleyeniz.
-- Bitisi göstermek icin $ karakteri kullanilir.
select * from kelimeler where regexp_like (kelime, 't$|m');
select * from kelimeler where regexp_like (kelime, 't$|m$');

-- SORU 20: h ile başlayıp t ile biten 3 harfli kelimeleri (h ile t kucuk harfli olanlari) listeleyeniz
select * from kelimeler where regexp_like (kelime, 'h[a-zA-Z0-9]t', 'c');
select * from kelimeler where regexp_like (kelime, 'h[a-z0-9]t', 'c');
-- [] işareti bir karekter içindekilerde bu karekterin hangi ozellikleri taşıyabileceğini belirtiyor
-- 3 HARF 'h[]t'
-- h  : 1.harf
-- [] : 2.harf
-- t  : 3.harf

-- SORU 20.A: h ile başlayıp t ile biten 4 harfli kelimeleri (h ile t kucuk harfli olanlari) listeleyeniz
select * from kelimeler where regexp_like (kelime, 'h[a-zA-Z0-9][a-zA-Z0-9]t', 'c');
select * from kelimeler where regexp_like (kelime, 'h[a-z0-9][a-z0-9]t', 'c');

-- SORU 21: Ilk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalim.
select * from kelimeler where regexp_like (kelime, 'h[a|i]t');

-- SORU 22: Icinde m veya i veya e olan kelimelerin tüm bilgilerini listeleyiniz.
select * from kelimeler where regexp_like (kelime, 'i|m|e');
select * from kelimeler where regexp_like (kelime, '[ime]');

-- SORU 22: a veya s ile başlayan kelimelerin tüm bilgilerini listeleyiniz.
select * from kelimeler where regexp_like (kelia|s);

-- SORU 23: Icerisinde en az 2 adet oo barindiran kelimelerin tüm bilgilerini listeleyiniz.


-- SORU 24: Icerisinde en az 4 adet oooo barıdıran kelimelerin tüm bilgilerini listeleyiniz.

-- SORU 25: Ilk harfi s veya b , 3. harfi l olan ve 5 harfli olan kelimelerin kucuk harfe dikkat ederek listeleyiniz.

