create database CINETECA;
use CINETECA;

create table ATTORE(
codattore char(5) not null unique primary key,
nome varchar(20) not null,
cognome varchar(20) not null,
datanascita date
);

create table REGISTA(
codregista char(5) not null primary key unique,
nome varchar(20) not null,
cognome varchar(20) not null,
datanascita date
);

create table FILM(
cod char(5) not null unique primary key,
titolo varchar(20) not null,
regista char(5) not null,
anno int not null,
foreign key(regista) references regista(codregista)
);

create table FILM_ATTORE(
codfilm char(5) not null,
codattore char(5) not null,
primary key(codfilm,codattore),
foreign key(codfilm) references film(cod),
foreign key(codattore) references attore(codattore)
);

create table FILM_PRODUTTORE(
codfilm char(5) not null,
nomeproduttore varchar(20) not null,
cognomeproduttore varchar(20) not null,
primary key(codfilm, nomeproduttore, cognomeproduttore),
foreign key(codfilm) references film(cod)
);

load data local infile "C:/Users/pc/Desktop/Uni/Basi di dati/Esercizi sql/cineteca/ATTORI.txt" into table ATTORE fields terminated by '\t' lines terminated by '\r\n';
load data local infile "C:/Users/pc/Desktop/Uni/Basi di dati/Esercizi sql/cineteca//REGISTI.txt" into table REGISTA fields terminated by '\t' lines terminated by '\r\n';
load data local infile "C:/Users/pc/Desktop/Uni/Basi di dati/Esercizi sql/cineteca//FILM.txt" into table FILM fields terminated by '\t' lines terminated by '\r\n';
load data local infile "C:/Users/pc/Desktop/Uni/Basi di dati/Esercizi sql/cineteca//FILM_ATTORI.txt" into table FILM_ATTORE fields terminated by '\t' lines terminated by '\r\n';
load data local infile "C:/Users/pc/Desktop/Uni/Basi di dati/Esercizi sql/cineteca//FILM_REGISTI.txt" into table FILM_PRODUTTORE fields terminated by '\t' lines terminated by '\r\n';

select f.titolo, a.codattore 
from film as f, attore as a, film_attore as t, regista as r
where f.cod=t.codfilm and a.codattore=t.codattore
group by r.codregista;

select a.nome, a.cognome
from attore as a, regista as r, film_produttore as fp
where a.codattore=r.codregista and a.nome=fp.nomeproduttore and a.cognome=fp.cognomeproduttore;



delete from film_produttore;
drop table film_produttore;
alter table film add produttore char(5) not null;
alter table film add nomeproduttore varchar(20) not null;
alter table film add cognomeproduttore varchar(20) not null;