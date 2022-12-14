--  ============================= SUBQUERIES ====================================
--  SORGU içinde çalişan SORGUYA SUBQUERY (ALT SORGU) denilir.

use batch59;

CREATE TABLE calisanlar 
(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
    
CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);
    
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
    
select * from calisanlar;
select * from markalar;
    

-- SORU1: calisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
-- select isim, maas, isyeri from calisanlar;
-- select marka_isim from markalar where calisan_sayisi>15000;

select isim, maas, isyeri from calisanlar 
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);


-- SORU2: marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
-- select isim, maas, sehir from calisanlar;
-- select marka_isim from  markalar where marka_id>101;

select isim, maas, sehir from calisanlar 
where isyeri in (select marka_isim from  markalar where marka_id>101);


-- SORU3: Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
-- select marka_id, calisan_sayisi from markalar;
-- select isyeri from calisanlar where sehir='Ankara'; 

select marka_id, calisan_sayisi from markalar where marka_isim in (select isyeri from calisanlar where sehir='Ankara');


  
/* ===================== AGGREGATE METOT KULLANIMI ===========================
    Aggregate Metotlari (SUM,COUNT, MIN, MAX, AVG) Subquery içinde kullanilabilir.
    Ancak, Sorgu tek bir değer döndürüyor olmalidir.
    SYNTAX: sum() şeklinde olmalı sum ile () arasında boşluk olmammalı
    
    SUM		: toplama yapar
    COUNT	: sayar
    MIN		: min degeri verir
    MAX		: max degeri verir
    AVG		: ortalama degeri verir
==============================================================================*/   
      
-- SORU4: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyen bir Sorgu yaziniz.
-- select marka_isim, calisan_sayisi, (toplam maas) from markalar;
-- select sum(maas) from calisanlar where marka_isim = isyeri;   -- toplam maas

select marka_isim, calisan_sayisi, (select sum(maas) from calisanlar where marka_isim = isyeri) as toplam_maas from markalar;

-- as toplam_maas --> bu satiri ekledigimizde sorgudan sonra cikan result icin isimlendirme yapmis oluruz


-- SORU5: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin ortalama maaşini listeleyen bir Sorgu yaziniz.
-- select marka_isim, calisan_sayisi, (ortalama maas) from markalar;
-- select avg(maas) from calisanlar where marka_isim = isyeri;   -- ortalama maas

select marka_isim, calisan_sayisi, (select avg(maas) from calisanlar where marka_isim = isyeri) as ortalama_maas from markalar;select marka_isim, calisan_sayisi, (select avg(maas) from calisanlar where marka_isim = isyeri) as ortalama_maas from markalar;

-- sayilari virgulden kurtarip yuvarlamak icin round() kullanilabilir
select marka_isim, calisan_sayisi, (select round(avg(maas)) from calisanlar where marka_isim = isyeri) as ortalama_maas from markalar;select marka_isim, calisan_sayisi, (select avg(maas) from calisanlar where marka_isim = isyeri) as ortalama_maas from markalar;

-- sayilarin virgulden sonra istenen kadar basamaklarini almak icin;
select marka_isim, calisan_sayisi, (select round(avg(maas),2) from calisanlar where marka_isim = isyeri) as ortalama_maas from markalar;select marka_isim, calisan_sayisi, (select avg(maas) from calisanlar where marka_isim = isyeri) as ortalama_maas from markalar;


-- SORU6: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
-- select marka_isim, calisan_sayisi, (max/min maas) from markalar;
-- select max(maas) from calisanlar where marka_isim = isyeri;   -- max maas
-- select min(maas) from calisanlar where marka_isim = isyeri;   -- min maas

select marka_isim, calisan_sayisi, (select max(maas) from calisanlar where marka_isim = isyeri) as max_maas from markalar;
select marka_isim, calisan_sayisi, (select min(maas) from calisanlar where marka_isim = isyeri) as min_maas from markalar;


-- SORU6.A: max ve min maas bir arada olsun
select marka_isim, calisan_sayisi, (select max(maas) from calisanlar where marka_isim = isyeri) as max_maas from markalar;


-- SORU7: Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
-- select marka_id, marka_isim, (sehir sayisi) from markalar;
-- select count(sehir) from calisanlar where marka_isim = isyeri;   -- sehir sayisi

select marka_id, marka_isim, (select count(sehir) from calisanlar where marka_isim = isyeri) as sehir_sayisi from markalar;
