CREATE DATABASE financial_core;

USE financial_core;

SELECT NOW() AS Timestamp;

CREATE TABLE bank_accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    agency_number INT NOT NULL,
    account_number INT NOT NULL,
    current_balance FLOAT,
    
    CONSTRAINT uq_agency_account UNIQUE (agency_number, account_number)
);

ALTER TABLE bank_accounts 
	ADD credit_limit FLOAT NOT NULL DEFAULT 500.0;
    
DESC bank_accounts;

INSERT INTO bank_accounts (agency_number, account_number, current_balance) VALUES 
(1001, 350198, 7500.00),
(3003, 998877, 450300.75),
(1001, 101010, 85.32),
(2002, 554433, 12500.00),
(3003, 112233, 2.15);

SELECT * FROM bank_accounts;

CREATE TABLE bank_client (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL, 
    cpf_number VARCHAR(11) NOT NULL,
    rg_number VARCHAR(9) NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    monthly_income FLOAT,
    
    CONSTRAINT fk_account_client 
        FOREIGN KEY (account_id) REFERENCES bank_accounts(account_id) 
        ON UPDATE CASCADE
);

ALTER TABLE bank_client
MODIFY COLUMN cpf_number CHAR(11) NOT NULL;

ALTER TABLE bank_client
MODIFY COLUMN rg_number CHAR(9) NOT NULL;

DESC bank_client;

-- 1. Cliente: Ana Clara Silva (Ligada à account_id 1)
INSERT INTO bank_client (account_id, cpf_number, rg_number, full_name, address, monthly_income)
VALUES (1, '11122233344', '123456789', 'Ana Clara Silva', 'Rua das Flores, 100, Sao Paulo, SP', 5500.00);

-- 2. Cliente: Bruno Almeida Costa (Ligado à account_id 2 - Cliente de alta renda)
INSERT INTO bank_client (account_id, cpf_number, rg_number, full_name, address, monthly_income)
VALUES (2, '99988877766', '987654321', 'Bruno Almeida Costa', 'Av. Central, 555, Rio de Janeiro, RJ', 18500.75);

-- 3. Cliente: Carla Eduarda Santos (Ligada à account_id 3)
INSERT INTO bank_client (account_id, cpf_number, rg_number, full_name, address, monthly_income)
VALUES (3, '44455566677', '543210987', 'Carla Eduarda Santos', 'Travessa X, Bloco 2, Curitiba, PR', 3200.00);

-- 4. Cliente: Daniel Rocha Oliveira (Ligado à account_id 4)
INSERT INTO bank_client (account_id, cpf_number, rg_number, full_name, address, monthly_income)
VALUES (4, '77766655544', '678901234', 'Daniel Rocha Oliveira', 'Rua dos Eucaliptos, 21, Belo Horizonte, MG', 9100.50);

-- 5. Cliente: Elisa Ferreira Lima (Ligada à account_id 5)
INSERT INTO bank_client (account_id, cpf_number, rg_number, full_name, address, monthly_income)
VALUES (5, '33322211100', '345678901', 'Elisa Ferreira Lima', 'Praca Principal, 7, Salvador, BA', 21000.00);

-- 6. Cliente: Fábio Gomes Pereira (Ligado à nova account_id 6)
INSERT INTO bank_client (account_id, cpf_number, rg_number, full_name, address, monthly_income)
VALUES (6, '22233344455', '456789012', 'Fábio Gomes Pereira', 'Rua Beco Diagonal, 33, Porto Alegre, RS', 7800.00);

SELECT * FROM bank_client;

CREATE TABLE bank_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_time DATETIME,
    transaction_status VARCHAR(20),
    transfer_amount FLOAT,
    source_account_id INT NOT NULL,
    destination_account_id INT NOT NULL,
    
    -- Constraint 1: SENT the money
    CONSTRAINT fk_source_account 
        FOREIGN KEY (source_account_id) REFERENCES bank_accounts(account_id), 
        
    -- Constraint 2: RECEIVED the money
    CONSTRAINT fk_destination_account 
        FOREIGN KEY (destination_account_id) REFERENCES bank_accounts(account_id) 
);



