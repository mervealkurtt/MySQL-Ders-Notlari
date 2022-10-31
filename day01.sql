create database batch59;
-- database olustururuz

use batch59;
-- birden fazla database varsa "use" komutu ile calisacagimiz database'i seceriz

-- TABLO OLUSTURMA
create table student
(
id varchar(4),
name varchar(30),
age int
);

-- VERI GIRISI
insert into student value('1000','Ali Can',25);
insert into student value('1001','Veli Yanan',25);
insert into student value('1002','Ayse Tan',25);
insert into student value('1003','Derya Canan',25);

select * from student;
-- student tablosundaki her seyi getirir

select name from student;
-- student tablosundaki adı "name" olan sutunu getirir

select id from student;
-- student tablosundaki adı "id" olan sutunu getirir

select id,name from student;
-- student tablosundaki adı "id" ve "name" olan sutunlari getirir

drop table student;
-- student tablosunu siler