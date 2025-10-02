-- #################################################################
-- SCRIPT: financial_core_ddl_dml.sql
-- DESCRIÇÃO: Criação e preenchimento inicial do banco de dados relacional
--            'financial_core' para projeto de bootcamp de Análise de Dados.
-- MODELO: Contas (1:N) Clientes, Transações (N:M) Contas.
-- DIALETO: MySQL
-- #################################################################

-- 1. DEFINIÇÃO DO BANCO DE DADOS (DATABASE DEFINITION)
----------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS financial_core; -- Adicionado IF NOT EXISTS para evitar erro se o BD já existir.
USE financial_core;

SELECT NOW() AS Execution_Timestamp; -- Mudado o alias para refletir a execução

-- 2. CRIAÇÃO DAS TABELAS (TABLE CREATION - DDL)
----------------------------------------------------------------------

-- Tabela de Contas Bancárias
CREATE TABLE bank_accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    agency_number INT NOT NULL,
    account_number INT NOT NULL,
    current_balance FLOAT,
    
    CONSTRAINT uq_agency_account UNIQUE (agency_number, account_number)
);

-- Tabela de Clientes
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

-- Tabela de Transações
CREATE TABLE bank_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_time DATETIME,
    transaction_status VARCHAR(20),
    transfer_amount FLOAT,
    source_account_id INT NOT NULL,
    destination_account_id INT NOT NULL,
    
    -- Constraint 1: Conta de origem (quem envia)
    CONSTRAINT fk_source_account
        FOREIGN KEY (source_account_id) REFERENCES bank_accounts(account_id),
        
    -- Constraint 2: Conta de destino (quem recebe)
    CONSTRAINT fk_destination_account
        FOREIGN KEY (destination_account_id) REFERENCES bank_accounts(account_id)
);

-- 3. ALTERAÇÕES E REFINAMENTOS (DDL ALTERATIONS)
----------------------------------------------------------------------

-- Adiciona a coluna 'credit_limit' (Limite de Crédito) à tabela bank_accounts
ALTER TABLE bank_accounts
    ADD credit_limit FLOAT NOT NULL DEFAULT 500.0;
    
-- Correções de tipo de dados para CPF e RG na tabela bank_client (Tamanho fixo = CHAR)
ALTER TABLE bank_client
    MODIFY COLUMN cpf_number CHAR(11) NOT NULL;

ALTER TABLE bank_client
    MODIFY COLUMN rg_number CHAR(9) NOT NULL;

-- Visualizar a estrutura final das tabelas (Comandos DESC)
DESC bank_accounts;
DESC bank_client;
DESC bank_transactions;


-- 4. INSERÇÃO DE DADOS (DATA INSERTION - DML)
----------------------------------------------------------------------

-- Inserindo 5 Contas Bancárias (ID's de 1 a 5)
INSERT INTO bank_accounts (agency_number, account_number, current_balance) VALUES 
(1001, 350198, 7500.00),
(3003, 998877, 450300.75),
(1001, 101010, 85.32),
(2002, 554433, 12500.00),
(3003, 112233, 2.15);

-- Inserindo 6 Clientes (Ligados às contas ID 1 a 6)
INSERT INTO bank_client (account_id, cpf_number, rg_number, full_name, address, monthly_income) VALUES
(1, '11122233344', '123456789', 'Ana Clara Silva', 'Rua das Flores, 100, Sao Paulo, SP', 5500.00),
(2, '99988877766', '987654321', 'Bruno Almeida Costa', 'Av. Central, 555, Rio de Janeiro, RJ', 18500.75),
(3, '44455566677', '543210987', 'Carla Eduarda Santos', 'Travessa X, Bloco 2, Curitiba, PR', 3200.00),
(4, '77766655544', '678901234', 'Daniel Rocha Oliveira', 'Rua dos Eucaliptos, 21, Belo Horizonte, MG', 9100.50),
(5, '33322211100', '345678901', 'Elisa Ferreira Lima', 'Praca Principal, 7, Salvador, BA', 21000.00),
(6, '22233344455', '456789012', 'Fábio Gomes Pereira', 'Rua Beco Diagonal, 33, Porto Alegre, RS', 7800.00);

-- 5. VALIDAÇÃO DOS DADOS (DATA VALIDATION)
----------------------------------------------------------------------
SELECT * FROM bank_accounts;
SELECT * FROM bank_client;
SELECT * FROM bank_transactions; -- Esta tabela estará vazia, mas valida a estrutura.
