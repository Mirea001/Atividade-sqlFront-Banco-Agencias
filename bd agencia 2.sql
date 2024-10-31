CREATE DATABASE Banco_Agencia;

USE Banco_Agencia;

CREATE TABLE Banco (
    ban_codigo                INT PRIMARY KEY AUTO_INCREMENT,
    nome                      VARCHAR(20) UNIQUE
);

CREATE TABLE Agencia (
    age_codigo                INT PRIMARY KEY AUTO_INCREMENT,
    numero_agencia            VARCHAR(45) NOT NULL,
    endereco                  VARCHAR(45) NOT NULL,
    ban_codigo                INT,
    CONSTRAINT fk_ban_codigo FOREIGN KEY (ban_codigo) REFERENCES Banco (ban_codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Conta (
    con_codigo                INT PRIMARY KEY AUTO_INCREMENT,
    numero_conta              CHAR(7) NOT NULL,
    saldo                     DECIMAL(10,2) NOT NULL,
    tipo_conta                SMALLINT NOT NULL,
    age_codigo                INT,
    CONSTRAINT fk_age_codigo FOREIGN KEY (age_codigo) REFERENCES Agencia (age_codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Cliente (
    cli_codigo               INT PRIMARY KEY AUTO_INCREMENT,
    cpf                      CHAR(14) NOT NULL,
    nome                     VARCHAR(20) NOT NULL,
    sexo                     CHAR NOT NULL,
    endereco                 VARCHAR(45),
    email                    VARCHAR(255)
);

CREATE TABLE Historico (
    his_codigo               INT PRIMARY KEY AUTO_INCREMENT,
    cli_codigo               INT,
    con_codigo               INT,
    data_inicio              DATE NOT NULL,
    CONSTRAINT fk_cli_codigo FOREIGN KEY (cli_codigo) REFERENCES Cliente (cli_codigo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_con_codigo FOREIGN KEY (con_codigo) REFERENCES Conta (con_codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TelefoneCliente (
    tel_codigo               INT PRIMARY KEY AUTO_INCREMENT,
    cli_codigo               INT,
    telefone_cli             CHAR(13) NOT NULL,
    CONSTRAINT fk_cli_codigo_telefone FOREIGN KEY (cli_codigo) REFERENCES Cliente (cli_codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Banco (nome) VALUES ('Banco Santander'), ('Banco Bradesco');

INSERT INTO Agencia (numero_agencia, endereco, ban_codigo) VALUES 
       ('0274', 'Av. Paulista, 1200', 1), 
       ('4089', 'Rua 15 de Novembro, 800', 2);

INSERT INTO Cliente (cpf, nome, sexo, endereco, email) VALUES 
       ('222.333.444-55', 'Carlos F Gomes', 'M', 'Rua das Flores, 200', NULL),
       ('888.999.777-66', 'Mariana L Silva', 'F', 'Rua dos Pioneiros, 450', 'marianals@gmail.com'),
       ('333.222.111-00', 'Lucas R Martins', 'M', 'Rua 7 de Setembro, 970', NULL);

INSERT INTO Conta (numero_conta, saldo, tipo_conta, age_codigo) VALUES 
       ('45723-1', 1500.50, 1, 1), 
       ('52931-6', 250.75, 2, 2);

INSERT INTO Historico (cli_codigo, con_codigo, data_inicio) VALUES 
       (1, 1, '2022-08-15'),
       (2, 2, '2021-05-10'),
       (3, 1, '2023-01-01');

INSERT INTO TelefoneCliente (cli_codigo, telefone_cli) VALUES 
       (1, '(11)4567-1234'), 
       (2, '(11)2345-6789'), 
       (3, '(11)9988-7766');

UPDATE Cliente SET email = 'lucasmartins@gmail.com' WHERE nome = 'Lucas R Martins';

DELETE FROM Conta WHERE numero_conta = '45723-1';

UPDATE Conta SET saldo = saldo * 1.05 WHERE numero_conta = '52931-6';
