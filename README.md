# 💾 Modelo de Dados Relacional - financial_core

Este repositório contém o script SQL para a criação de um modelo de dados relacional simples de sistema bancário, desenvolvido como parte do bootcamp de Análise de Dados.

O projeto demonstra a aplicação de comandos **DDL (Data Definition Language)** para estruturar o banco de dados e **DML (Data Manipulation Language)** para a inserção de dados.

---

## 📌 Objetivo do Projeto

O objetivo principal foi praticar a criação de um modelo de dados que garanta a **integridade referencial** entre as entidades:
1. **Contas (`bank_accounts`)**
2. **Clientes (`bank_client`)**
3. **Transações (`bank_transactions`)**

### Tecnologias Utilizadas

* **Dialeto SQL:** MySQL
* **Editor:** VS Code
* **Versionamento:** Git / GitHub

---

## 🏗 Estrutura do Modelo

O modelo é baseado na seguinte relação:
* Cada Conta pode ser referenciada por várias transações de origem e destino (Chaves estrangeiras).
* Cada Cliente está ligado a uma Conta (relação 1:1, garantida pela chave estrangeira `account_id`).

### Principais Conceitos DDL Demonstrados:

* **Criação de Banco de Dados e Tabelas:** `CREATE DATABASE` e `CREATE TABLE`.
* **Chaves e Restrições:** Uso de `PRIMARY KEY`, `AUTO_INCREMENT` e a restrição de unicidade `UNIQUE (agency_number, account_number)`.
* **Integridade Referencial:** Definição de `FOREIGN KEY` com a regra `ON UPDATE CASCADE` para garantir a consistência dos dados.
* **Modificação de Estrutura:** Uso do `ALTER TABLE` para adicionar a coluna `credit_limit` e para corrigir tipos de dados (mudando `VARCHAR` para `CHAR` em CPF/RG).

---

## ⚙ Como Executar o Script

O script completo (`financial_core_ddl_dml.sql`) pode ser executado em qualquer ambiente MySQL para recriar o banco de dados e popular as tabelas com os dados iniciais.

1.  Conecte-se ao seu servidor MySQL.
2.  Execute o arquivo `financial_core_ddl_dml.sql` na íntegra.

**O script contém:**
* Criação das 3 tabelas.
* Comandos `ALTER TABLE` para ajustes na estrutura.
* Inserção de 5 contas e 6 clientes (`INSERT INTO ...`).
