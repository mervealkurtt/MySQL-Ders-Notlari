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



