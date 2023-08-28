USE ecommerce;
show tables;
-- Relembrando as estruturas
select * from clients;
select * from orders;
SELECT* FROM supplier;
SELECT* FROM seller;
DESC product;
DESC productsupplier;
DESC productstorage;
-- Quantos pedidos foram feitos por cada cliente?
select Fname, count(*) 
from clients inner join orders on idClient =  idOrderClient
group by Fname;
-- Algum vendedor também é fornecedor?
SELECT *
FROM supplier AS su INNER JOIN seller AS se 
ON su.CNPJ =se.CNPJ;
-- Relação de Fornecedores de produtos e estoques
SELECT SocialName AS Fornecedor,CNPJ,storageLocation
FROM productstorage
INNER JOIN productsupplier ON productstorage.idProdStorage = productsupplier.idPsProduct
INNER JOIN supplier ON productsupplier.idPsSupplier = supplier.idSupplier;
-- Relação de nomes dos fornecedores e nomes dos produtos;
SELECT Pname AS Produto, SocialName Fornecedor
FROM productstorage
INNER JOIN productsupplier ON productstorage.idProdStorage = productsupplier.idPsProduct
INNER JOIN supplier ON productsupplier.idPsSupplier = supplier.idSupplier
INNER JOIN product ON idProduct = productsupplier.idPsProduct

