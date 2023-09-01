create database ecommerce_2;
use ecommerce_2;
show tables;

-- Criar tabela de clientes
CREATE TABLE clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50),
    middleInitial CHAR(1),
    lastName VARCHAR(50),
    cpf CHAR(11) NOT NULL,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Criar tabela de produtos
CREATE TABLE products (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100),
    isForKids BOOLEAN,
    category ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
    rating FLOAT DEFAULT 0,
    size VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Criar tabela de pagamentos
CREATE TABLE payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    clientId INT,
    paymentType ENUM('Boleto','Cartão','Dois cartões'),
    limitAvailable FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (clientId) REFERENCES clients(idClient)
);

-- Criar tabela de pedidos
CREATE TABLE orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    clientId INT,
    orderStatus ENUM('Cancelado','Confirmado','Em processamento') DEFAULT 'Em processamento',
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    isPaymentCash BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (clientId) REFERENCES clients(idClient)
);

-- Criar tabela de estoque
CREATE TABLE productStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Criar tabela de fornecedores
CREATE TABLE suppliers (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR(255) NOT NULL,
    cnpj CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Criar tabela de vendedores
CREATE TABLE sellers (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR(255) NOT NULL,
    abstractName VARCHAR(255),
    cnpj CHAR(15) NOT NULL,
    cpf CHAR(9),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Criar tabela de relação entre vendedores e produtos
CREATE TABLE productSeller (
    idProductSeller INT AUTO_INCREMENT PRIMARY KEY,
    sellerId INT,
    productId INT,
    productQuantity INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (sellerId) REFERENCES sellers(idSeller),
    FOREIGN KEY (productId) REFERENCES products(idProduct)
);

-- Criar tabela de relação entre produtos e pedidos
CREATE TABLE productOrder (
    idProductOrder INT AUTO_INCREMENT PRIMARY KEY,
    productId INT,
    orderId INT,
    productQuantity INT DEFAULT 1,
    productStatus ENUM('Disponível','Sem estoque') DEFAULT 'Disponível',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (productId) REFERENCES products(idProduct),
    FOREIGN KEY (orderId) REFERENCES orders(idOrder)
);

-- Criar tabela de localização de estoque
CREATE TABLE storeLocation (
    idStoreLocation INT AUTO_INCREMENT PRIMARY KEY,
    productId INT,
    storageId INT,
    location VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (productId) REFERENCES products(idProduct),
    FOREIGN KEY (storageId) REFERENCES productStorage(idProdStorage)
);

SHOW TABLES;

-- Criando dados fictícios para as tabelas

insert into clients (firstName,middleInitial,lastName,cpf,address)
		values('Lucas','C','Oliveira','11111111111','Rua premier - 300 - Brasilia'),
             ('Maria', 'A', 'Silva', '22222222222', 'Avenida Principal - 100 - São Paulo'),
             ('Pedro', 'B', 'Fernandes', '33333333333', 'Rua do Comércio - 50 - Rio de Janeiro'),
             ('Ana', 'D', 'Santos', '44444444444', 'Travessa da Praia - 25 - Salvador'),
             ('Paulo', 'E', 'Ribeiro', '55555555555', 'Rua das Flores - 75 - Belo Horizonte');
             
insert into clients (firstName,middleInitial,lastName,cpf,address)
		value ('Rodi', 'T', 'Mineiro', '66666666666', 'Rua das Arvores - 85 - Belo Horizonte');
 
 
 insert into products(productName,isForKids,category,rating,size)
		values ('Sapato',true,'Vestimenta',5, 27),
               ('Smartphone', false, 'Eletrônico', 4.5, 6),
               ('Boneca', true, 'Brinquedos', 4.0, 12),
               ('Chocolate', true, 'Alimentos', 4.7, 100),
               ('sofá',false,'Móveis',5,500);
               

insert into payments(clientId,paymentType,limitAvailable)
		values(19,'Boleto',5000),
			  (20,'Cartão',7500),
              (21,'Dois cartões',12000),
              (22,'Boleto', 540),
              (23,'Cartão',4000);
              
			
insert into orders(clientId,orderStatus,orderDescription,sendValue,isPaymentCash)
		values(19,'Cancelado', 'para ser entregue',500.50,true),
			  (20,'Confirmado', 'para ser entregue',5000,true),
			  (21,'Em processamento', 'está a ver',580.50,false),
			  (22,'Cancelado', 'para ser entregue',1000,true),
              (23,'Em processamento', 'está em análise',870.50,false);
              
  
insert into productStorage(storageLocation,quantity)
		values('Belo Horizonte', 50),
			  ('São Paulo', 800),
			  ('Rio de Janeiro',540),
			  ('Paraíba', 730);
              

 
 insert into suppliers(socialName,cnpj,contact)
		values('Marcelo ltda','12345678954627','999889898'),
              ('Carcará entregas','52345678954627','999889898'),
              ('Flash point','92345678954624','999889898'),
              ('Mix entregas','40245678954627','999889898');
   
 
 insert into sellers(socialName,abstractName,cnpj,cpf,location,contact)
		values('Tech eletronics',null,125478546575425,null,'Rio de Janeiro',915487653),
			  ('Botique Durgas',null,225478546575425,null,'Rio de Janeiro',915487234),
              ('Kids Word',null,425478546575425,null,'São Paulo',805487653);
              

insert into productSeller(sellerId,productId,productQuantity)
		values(1,1,80),
			  (2,2,10);
              

insert into productOrder(productId,orderId,productQuantity,productStatus)
		values(1,1,2,'Disponível'),
			  (2,1,1,'Sem estoque'),
              (3,2,2,null);
              

insert into storeLocation(productId,storageId,location)
		values  (1,3,'RJ'),
				(2,4,'PB'),
                (4,1,'MG');


-- CRIANDO ALGUMAS CONSULTAS PARA O DESAFIO DIO 

-- Quantos pedidos foram feitos por cada cliente?

SELECT c.idClient, CONCAT(c.firstName, ' ', c.lastName) AS clientName, COUNT(o.idOrder) AS totalOrders
FROM clients c
LEFT JOIN orders o ON c.idClient = o.clientId
GROUP BY c.idClient, clientName
ORDER BY c.idClient;


-- Algum vendedor também é fornecedor?
SELECT DISTINCT s.idSeller
FROM sellers s
INNER JOIN suppliers su ON s.cnpj = su.cnpj;


-- Qual o valor mais alto da compra de um cliente? 
select max(sendValue) as Maior_valor from clients c left join orders o on c.idClient = o.clientId;


-- selecione os clientes que compraram por boleto!
select concat(firstName,' ',middleInitial,' ',lastName) as Nome_completo, paymentType from clients c
inner join payments p on c.idClient = p.clientId 
where p.paymentType= 'Boleto';


-- veja a quantidade vendida de smartphone!
select count(productName) from products
where productName = 'Smartphone';


-- Qual a média de estrelas dos produtos?
select avg(rating) from products;


-- Diga o primeiro nome das pessoas que compraram acima de 500 reais!
SELECT c.firstName, o.sendValue AS valor_da_compra
FROM clients c INNER JOIN orders o ON c.idClient = o.clientId
HAVING valor_da_compra > 500; 


-- . --