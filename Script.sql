create table funcionarios (
id_funcionario serial primary key,
nome varchar(100) not null,
salario decimal not null,
id_departamento int,
foreign key (id_departamento) references departamentos(id_departamento)
);

alter table 

create table departamentos (
id_departamento int not null primary key,
nome_departamento varchar(100) not null
);

-- Inserindo valores

insert into funcionarios(nome, salario, id_departamento) values
('João', 5000, 1),
('Maria', 6000, 2),
('Carlos', 5500, 1),
('Ana', 4500, 2),
('Paulo', 7000, 3),
('Lucia', 6500, 2);

insert into departamentos(id_departamento, nome_departamento) values
(1, 'Vendas'),
(2, 'Marketing'),
(3, 'TI');

INSERT INTO public.departamentos
(id_departamento, nome_departamento)
VALUES(4, 'RH');

INSERT INTO public.departamentos
(id_departamento, nome_departamento)
VALUES(5, 'Financeiro');

-- Copiando definição de tabela

create table departamento2 as
select *
from departamentos d
where 1 = 0;

create table departamento3 as
select id_departamento as id, nome_departamento as nome
from departamentos d
where 1 = 0;

create table funcionario2 as
select id_funcionario as id, nome as nome_funcionario
from funcionarios f
where 1 = 0;

-- Esse não retorna vazio

create table funcionario3 as
select id_funcionario as id, nome as nome_funcionario
from funcionarios f
where f.id_departamento = 1;

-- Aumentando salário do pessoal de marketing em 10%

UPDATE public.funcionarios
set salario = (salario + (salario * 0.10))
WHERE id_departamento=2;

UPDATE funcionarios
set salario = salario * 1.10
WHERE id_departamento=2;

UPDATE funcionarios 
set salario = salario * 1.10
WHERE id_departamento in 
	(select d.id_departamento
	from departamentos d
	where d.nome_departamento ilike '%marketing');

-- Criar tabela funcionario bônus com alguns funcionários nelas e esse funcionarios
-- vão ter bônus

create table funcionario_bonus (
id_funcionario int primary key,
foreign key (id_funcionario) references funcionarios(id_funcionario)
);

insert into funcionario_bonus (id_funcionario) values 
(1), 
(2);

update funcionarios
set salario = salario * 1.10
where id_funcionario in (select id_funcionario from funcionario_bonus);

create view funcionario_sem_salario as
select id_funcionario, nome, id_departamento
from funcionarios;

insert into funcionario_sem_salario
values
(7,'Roberto',4);

select table_name
from information_schema.tables
where table_schema='public';

select table_name
from information_schema.tables;

select *
from information_schema.tables
where table_schema='public';

select *
from information_schema.tables;

select *
from information_schema.columns
where table_schema='public'
and table_name='departamentos';

select a.table_name, a.constraint_name, b.column_name, a.constraint_type 
from information_schema.table_constraints a, information_schema.key_column_usage b
where a.table_name='funcionario'
and a.table_schema ='public'
and a.table_name = b.table_name 
and a.table_schema = b.table_schema 
and a.constraint_name = b.constraint_name ;

-- query inteligente para me dar queries de count das linhas das tabelas --

select 'select count(*) from ' || table_name|| ';' cnts
from information_schema.tables
where table_schema='public';

alter table <table> disable constraint <constraint_name>;


select 'alter table' || a.table_name ||
	'disable constraint' || a.constraint_name|| ';' cons
from information_schema.table_constraints a
where a.table_schema='public'
and a.constraint_type = 'FOREIGN KEY';
