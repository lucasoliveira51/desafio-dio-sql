-- Criação do banco de dados para o cnário de E-commerce

create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        constraint unique_cpf_client unique(CPF),
        Address varchar(30)
);

alter table clients auto_increment =1;

desc clients;
-- criar tabela produto

create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10),
        classification_kids bool,
        category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        avaliação float default 0,
        size varchar(10)
        
);


create table payments(
	idclient int,
    id_payment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key(idClient, id_payment)
);
desc payments;

-- criar tabela pedido
alter table orders;
desc orders;
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int ,
        orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        sendValue float default 10,
		paymentCash boolean default false,
        constraint fk_order_client foreign key (idOrderClient) references clients(idClient)
); 
desc orders;

-- criar tabela estoque

create table productStorage(
		idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
        
); 

-- criar fornecedor

create table supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
        
); 


-- criar vendedor
create table seller(
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15) not null,
        CPF char(9),
        location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
        
); 

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
    
);

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum ('Dísponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storeLocation(
	idLproduct int,
    idLstorage int,
    location varchar (255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
desc productSupplier;
--------------

desc storeLocation;
show tables;

show databases;
use information_schema;
show tables;
desc table_constraints;


-- inserindo os dados
desc clients;
insert into clients (Fname,Minit,Lname,CPF,Address)
		values('Maria','M','Silva','12346789','rua silva 29, Carangola'),
			  ('Matheus','O','Pimentel','12346312','rua alameda 289, Centro'),
              ('Ricardo','F','Silva','12346745','rua prata 24, Carangola'),
              ('Julia','S','França','45346789','rua prata 58, Carangola'),
              ('Roberta','G','Assis','76346789','rua silva 25, Centro'),
              ('Isabela','M','Cruz','18646789','rua silva 84, Carangola');

desc product;
insert into product (Pname, classification_kids, category, avaliação, size)
		values('Fon',false,'Eletrônico','4',null),
			  ('Barbie',true,'Brinquedos','3',null),
              ('Body Cart',true,'Vestimenta','5',null),
              ('Sofá',false,'Movéis','4','3x57x80'),
              ('Farinha',false,'Alimentos','2',null),
              ('Teclado',false,'Eletrônico','3',null);

desc orders;
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
		values  (1, default, 'compra via aplicativo', 100.50, 1),
				(2, 'Confirmado', 'compra via aplicativo', 50.25, 0),
				(3, default, 'compra online', 75.00, 1),
				(4, default, 'compra via aplicativo', 200.75, 0);
select*from orders;
desc productOrder;                
insert into productOrder (idPOproduct, idPOorder, poQuantity,PoStatus)
		values(1,1,2,null),
			  (2,1,1,null),
              (3,2,2,null);
              
desc productStorage;
insert into productStorage(storageLocation,quantity)
		values  ('Rio de janeiro',1000),
				('Rio de janeiro',500),
                ('São Paulo',10),
                ('São Paulo',100),
                ('São Paulo',10),
                ('Brasília',60);
	
desc storeLocation;
insert into storeLocation(idLproduct, idLstorage,location)
		values  (1,2,'RJ'),
				(2,6,'GO');
                
desc sUPPLIER;
insert into supplier(SocialName, CNPJ,contact)
		values  ('Almeida e filhos','123451234512345','12345678'),
				('Eletrônicos Silva','321543215432154','87654321'),
                ('Eletrônicos Velma','421354213542135','14735984');
                
insert into productSupplier(idPsSupplier,idPsProduct,quantity)
		values(1,1,500),
			  (1,2,400),
              (2,4,633),
              (3,3,5),
              (2,5,10);

insert into seller (SocialName, AbstName,CNPJ,CPF,location,contact)
		values('Tech eletronics',null,125478546575425,null,'Rio de Janeiro',915487653),
			  ('Botique Durgas',null,225478546575425,null,'Rio de Janeiro',915487234),
              ('Kids Word',null,425478546575425,null,'São Paulo',805487653);

select*from seller;
insert into productSeller(idPseller,idPproduct,prodQuantity)
		values(4,4,80),
			  (5,5,10);


-- algumas consultas 

select count(*) from clients;
select *from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname,' ',Lname) as nome_completo ,idOrder from clients c, orders o where c.idClient = idOrderClient;

select count(*) from clients c, orders o
		where c.idClient = idOrderClient;

                    
select*from clients
INNER JOIN orders ON clients.idClient = orders.idOrderClient
INNER JOIN productOrder ON orders.idOrder = productOrder.idPOorder
INNER JOIN product ON productOrder.idPOproduct = product.idProduct;

select* from orders
where orderStatus = 'Em processamento'
order by idOrder asc;

select* from orders
where orderStatus = 'Em processamento' and paymentCash > 0
order by sendValue asc;










        

