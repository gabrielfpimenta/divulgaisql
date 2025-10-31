-- USE master 
-- IF EXISTS(select * from sys.databases where name='bd_divulgai')
-- DROP DATABASE bd_divulgai
-- GO

-- CREATE DATABASE bd_divulgai
-- GO

-- USE bd_divulgai
-- GO


USE divulgaibanco;

-----------------------------------------------------------------------------------

-- TABELA USUARIO

CREATE TABLE Usuario
(
   id            INT IDENTITY PRIMARY KEY,
   nome          VARCHAR(100) NOT NULL,
   email         VARCHAR(100) UNIQUE NOT NULL,
   senha         VARCHAR(100) NOT NULL,
   nivel_acesso  VARCHAR(10) NULL, -- ADMIN, PRESTADOR ou CLIENTE
   foto          VARBINARY(MAX) NULL,
   data_cadastro SMALLDATETIME NOT NULL,
   status_usuario BIT NOT NULL -- 1 = Ativo, 0 = Inativo

 )
GO

-- Ajustando inserts para status_usuario como BIT (0 ou 1)
INSERT Usuario (nome, email, senha, nivel_acesso, foto, data_cadastro, status_usuario)
VALUES ('Fulano da Silva', 'fulano@email.com.br', 'MTIzNDU2Nzg=', 'ADMIN', NULL, GETDATE(), 1)

INSERT Usuario (nome, email, senha, nivel_acesso, foto, data_cadastro, status_usuario)
VALUES ('Beltrana de Sá', 'beltrana@email.com.br', 'MTIzNDU2Nzg=', 'CLIENTE', NULL, GETDATE(), 0)

INSERT Usuario (nome, email, senha, nivel_acesso, foto, data_cadastro, status_usuario)
VALUES ('Sicrana de Oliveira', 'sicrana@email.com.br', 'MTIzNDU2Nzg=', 'PRESTADOR', NULL, GETDATE(), 1)

INSERT Usuario (nome, email, senha, nivel_acesso, foto, data_cadastro, status_usuario)
VALUES ('Ordnael Zurc', 'ordnael@email.com.br', 'MTIzNDU2Nzg=', 'CLIENTE', NULL, GETDATE(), 1)
GO

SELECT * FROM Usuario


-- As tabelas são baseadas nos 4 usuários do sistema, sendo eles: 2 clientes, 1 administrador (admin) e 1 prestador

----------------------------------------------------------------------------------------------------------------------------------------------


-- TABELA REGIAO

CREATE TABLE Regiao
(   
   id             INT IDENTITY,
   cidade         VARCHAR(50)         NOT NULL,
   uf			  CHAR(2)			  NOT NULL,
   zona           VARCHAR(20)             NULL, -- SUL, NORTE, LESTE, OESTE, CENTRO
   descricao      VARCHAR(200)        NOT NULL,
   status_regiao   VARCHAR(20)         NOT NULL, -- ATIVO ou INATIVO

   PRIMARY KEY(id)
   )

GO


INSERT Regiao (cidade, uf, zona, descricao, status_regiao)
VALUES ('Barueri', 'SP', 'ZONA LESTE', 'Atende toda a região do Engenho Novo e proximidades', 'ATIVO')
INSERT Regiao (cidade, uf, zona, descricao, status_regiao)
VALUES ('Osasco', 'SP', 'ZONA LESTE', 'Atende toda a região central de Osasco e bairros adjacentes', 'ATIVO');
INSERT Regiao (cidade, uf, zona, descricao, status_regiao)
VALUES ('Carapicuíba', 'SP', 'ZONA LESTE',  'Atende bairros como Vila Dirce, Ariston e Centro', 'ATIVO')
INSERT Regiao (cidade, uf, zona, descricao, status_regiao)
VALUES ('Santana de Parnaíba', 'SP', 'ZONA LESTE',  'Atende bairros históricos e condomínios residenciais', 'ATIVO')

SELECT * FROM Regiao


-----------------------------------------------------------------------------------------------------------------------------------------



-- TABELA PRESTADOR

CREATE TABLE Prestador

(
   id                    INT IDENTITY,
   usuario_id            INT,
   regiao_id             INT,
   nome                  VARCHAR(100)       NOT NULL,
   data_nascimento        DATE,
   cpf                   VARCHAR(11)        NOT NULL,
   genero                VARCHAR(20)        NOT NULL,
   telefone              VARCHAR(11)        NOT NULL,
   logradouro 	 	     VARCHAR(100)       NOT NULL, -- nome da rua, avenida e etc
   numero_residencial 	 VARCHAR(10)        NOT NULL,
   complemento  	     VARCHAR(100)       NULL,
   cep 	 	             CHAR(8)            NOT NULL,
   bairro  	 	         VARCHAR(100)       NOT NULL,
   cidade 	 	         VARCHAR(100)       NOT NULL,
   uf 		 	         CHAR(2)            NOT NULL,
   status_prestador       VARCHAR(20)        NOT NULL, -- ATIVO, INATIVO, SUSPENSO


   PRIMARY KEY(id),
   FOREIGN KEY (usuario_id) REFERENCES Usuario(id),
   FOREIGN KEY (regiao_id) REFERENCES Regiao(id)

)

GO

INSERT Prestador (usuario_id, regiao_id, nome, data_nascimento, cpf, genero, telefone, logradouro, numero_residencial, complemento, cep, bairro, cidade, uf, status_prestador)
VALUES (3, 1, 'Sicrana de Oliveira', GETDATE(), '12345678910', 'Feminino', '11940028922', 'Rua Lorena', '13', 'Casa 1', '01234567', 'Engenho Novo', 'Barueri', 'SP', 'ATIVO')

SELECT * FROM Prestador



--------------------------------------------------------------------------------------------------------------------------------



-- TABELA CONTATO

CREATE TABLE Contato

(
   id                    INT IDENTITY,
   prestador_id          INT,
   tipo_contato          VARCHAR(50)         NOT NULL,
   link                  VARCHAR(255)        NOT NULL,
   status_contato        VARCHAR(20)         NOT NULL, -- ATIVO ou INATIVO

 
   PRIMARY KEY(id),
   FOREIGN KEY(prestador_id) REFERENCES Prestador(id)
)

GO

INSERT Contato (prestador_id, tipo_contato, link, status_contato)
VALUES (1, 'Instagram', 'https://instagram.com/sicranaestetica', 'ATIVO')

SELECT * FROM Contato


----------------------------------------------------------------------------------------------------------------------


-- TABELA CATEGORIA

CREATE TABLE Categoria

(
   id                    INT IDENTITY,
   nome                  VARCHAR(100)        NOT NULL,
   status_categoria      BIT                 NOT NULL -- 1 = Ativo, 0 = Inativo

   PRIMARY KEY(id)
)

GO


INSERT Categoria (nome, status_categoria)
VALUES ('Comidas prontas', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Lanches e Fast Food', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Doces e Sobremesas', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Padaria e Confeitaria', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Sucos naturais', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Drinks artesanais', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Cafés e chás especiais', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Saudável e fitness', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Comida italiana', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Comida japonesa', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Comida nordestina', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Comida árabe', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Comida mexicana', 1)


INSERT Categoria (nome, status_categoria)
VALUES ('Buffet para festas', 1)

SELECT * FROM Categoria





---------------------------------------------------------------------------------------------------------------------------------------


-- TABELA SERVICO 

CREATE TABLE Servico

(
   id                   INT IDENTITY,
   categoria_id         INT,
   prestador_id         INT,
   nome                 VARCHAR(100)        NOT NULL,
   descricao            VARCHAR(200)        NOT NULL,
   status_servico		VARCHAR(20)			NOT NULL, --ATIVO OU INATIVO
   foto		         	VARBINARY(MAX)          NULL,

   PRIMARY KEY (id),
   FOREIGN KEY (categoria_id) REFERENCES Categoria(id),
   FOREIGN KEY (prestador_id) REFERENCES Prestador(id)

)

GO

INSERT Servico (categoria_id, prestador_id, nome, descricao, status_servico, foto)
VALUES (3, 1, 'Sicrana Bolos', 'O Sicrana Bolos vende bolos variados.', 'ATIVO', NULL)


SELECT * FROM Servico




------------------------------------------------------------------------------------------------------

-- TABELA FEEDBACK 

CREATE TABLE Feedback

(
   id                   INT IDENTITY,
   usuario_id           INT,
   prestador_id         INT,
   titulo               VARCHAR(200)        NOT NULL,
   descricao            VARCHAR(200)        NOT NULL,
   tipo                 VARCHAR(50)         NOT NULL, --DENÚNCIA ou FEEDBACK
   data_cadastro	    SMALLDATETIME	NOT NULL,
   status_feedback		VARCHAR(20), --ATIVO OU INATIVO


   PRIMARY KEY (id),
   FOREIGN KEY (usuario_id)  REFERENCES Usuario(id),
   FOREIGN KEY (prestador_id) REFERENCES Prestador(id)
)

INSERT Feedback (usuario_id, prestador_id, titulo, descricao, tipo, data_cadastro, status_feedback)
VALUES (4, 1, 'Um serviço excelente!' , 'O serviço Sicrana Bolos é muito bom e acolhedor, parabéns.', 'FEEDBACK', GETDATE(), 'ATIVO')

 SELECT * FROM Feedback

 -- SELECTS
 SELECT * FROM Usuario
 SELECT * FROM Regiao 
 SELECT * FROM Prestador
 SELECT * FROM Contato
 SELECT * FROM Categoria
 SELECT * FROM Servico
 SELECT * FROM Feedback




-- DROPS
/*
DROP TABLE Usuario
DROP TABLE Regiao
DROP TABLE Prestador
DROP TABLE Contato
DROP TABLE Categoria
DROP TABLE Servico
DROP TABLE Feedback
*/


