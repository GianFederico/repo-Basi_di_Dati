create database BANCA;
use BANCA;

create table CORRENTISTA(
cf char(10) not null unique primary key,
cogn varchar(20) not null,
nome varchar(20) not null,
datanascita date not null);

create table DIPENDENTE(
cf char(10) not null unique primary key,
nome varchar(20) not null,
cognome varchar(20) not null,
datanascita date not null,
qualifica varchar(15) not null check(qualifica in('impiegato','quadro','dirigente')));

create table FILIALE(
cod char(5) not null unique primary key,
nomefiliale varchar(15) not null,
citta varchar(20) not null,
cfdirettore char(10) not null,
foreign key(cfdirettore) references dipendente(cf));

create table CONTO_CORRENTE(
numcc char(10) not null primary key,
codfiliale char(5) not null,
foreign key(codfiliale) references filiale(cod));

create table TITOLARE_CC(
numcc char(10) not null unique,
cftitolare char(10) not null,
primary key(numcc,cftitolare),
foreign key(numcc) references conto_corrente(numcc),
foreign key(cftitolare) references correntista(cf));

load data local infile "path/CORRENTISTI.txt" into table CORRENTISTA fields terimanted by '\t' lines terminated by '\r\n';
load data local infile "path/DIPENDENTI.txt" into table DIPENDENTE fields terimanted by '\t' lines terminated by '\r\n';
load data local infile "path/CONTI_CORRENTE.txt" into table CONTO_CORRENTE fields terimanted by '\t' lines terminated by '\r\n';
load data local infile "path/TITOLARI.txt" into table TITOLARE_CC fields terimanted by '\t' lines terminated by '\r\n';

select cc.numcc, f.nomefiliale, c.nome, c.cognome
from conto_corrente as cc, filiale as f, titolare_cc as t, correntista as c
where (count(c.cf=t.cftitolare)>1)

select d.nome,d.cognome
from dipendente as d, correntista as c
where d.qualifica='dirigente' and d.cf!=c.cf;

select f.nomefiliale, d.nome, d.cognome, d.datanascita
from filiale a f, dipendete as d
where f.cfdirettore=d.cf and f.citta='bari' and d.datanascita>1970-01-01;

delete from titolare_cc;
drop table titolare_cc;
alter table conto_corrente add cftitolare char(10) not null unique;
set foreign_key_checks=0;
alter table conto_corrente add constraint cftitolare foreign key(cftitolare) references correntista(cf);
set foreign_key_checks=1;
