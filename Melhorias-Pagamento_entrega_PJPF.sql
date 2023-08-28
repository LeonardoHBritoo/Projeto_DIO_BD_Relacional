-- Incluir coluna de tipo de cliente
alter table clients
    add clientType enum('PJ', 'PF') not null after Lname;

-- Criar tabela de formas de pagamento
create table paymentMethods(
    idPaymentMethod int auto_increment primary key,
    idClient int,
    paymentType enum('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable float,
    constraint fk_payment_client foreign key (idClient) references clients(idClient)
        on update cascade
);

-- Criar tabela de entregas
create table deliveries(
    idDelivery int auto_increment primary key,
    idOrder int,
    deliveryStatus enum('Em trânsito', 'Entregue', 'Pendente') not null,
    trackingCode varchar(20) not null,
    constraint fk_delivery_order foreign key (idOrder) references orders(idOrder)
        on update cascade
);

-- Adicionar coluna de forma de pagamento à tabela de pedidos
alter table orders
    add idPaymentMethod int,
    add constraint fk_order_payment foreign key (idPaymentMethod) references paymentMethods(idPaymentMethod);

-- Atualizar coluna de envio na tabela de pedidos
alter table orders
    change sendValue shippingCost float default 0;

-- Adicionar colunas de status e rastreio à tabela de pedidos
alter table orders
    add deliveryStatus enum('Em trânsito', 'Entregue', 'Pendente') not null default 'Pendente',
    add trackingCode varchar(20) after deliveryStatus;

-- Atualizar tabela de produtos em estoque
alter table productStorage
    change storageLocation storageLocation varchar(255) not null,
    add quantityAvailable int default 0;