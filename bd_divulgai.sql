USE master 
IF EXISTS(select * from sys.databases where name='bd_divulgai')

DROP DATABASE bd_divulgai

GO

-- CRIAR UM BANCO DE DADOS

CREATE DATABASE bd_divulgai

GO

-- ACESSAR O BANCO DE DADOS

USE bd_divulgai

GO


-----------------------------------------------------------------------------------

-- TABELA USUARIO

CREATE TABLE Usuario

(
   id            INT			IDENTITY,
   nome          VARCHAR(100)	NOT NULL,
   email         VARCHAR(100)	UNIQUE NOT NULL,
   senha         VARCHAR(100)	NOT NULL,
   nivelAcesso   VARCHAR(10)    NULL, -- ADMIN, PRESTADOR ou CLIENTE
   foto			 VARBINARY(MAX) NULL,
   dataCadastro	 SMALLDATETIME	NOT NULL,
   statusUsuario VARCHAR(20)    NOT NULL, -- ATIVO ou INATIVO ou TROCAR_SENHA

   PRIMARY KEY (id)
)

GO

INSERT Usuario (nome, email, senha, nivelAcesso, foto, dataCadastro, statusUsuario)
VALUES ('Fulano da Silva', 'fulano@email.com.br', 'MTIzNDU2Nzg=', 'ADMIN', NULL, GETDATE(), 'ATIVO')
INSERT Usuario (nome, email, senha, nivelAcesso, foto, dataCadastro, statusUsuario)
VALUES ('Beltrana de S�', 'beltrana@email.com.br', 'MTIzNDU2Nzg=', 'USER', NULL, GETDATE(), 'INATIVO')
INSERT Usuario (nome, email, senha, nivelAcesso, foto, dataCadastro, statusUsuario)
VALUES ('Sicrana de Oliveira', 'sicrana@email.com.br', 'MTIzNDU2Nzg=', 'PRESTADOR', NULL, GETDATE(), 'ATIVO')
INSERT Usuario (nome, email, senha, nivelAcesso, foto, dataCadastro, statusUsuario)
VALUES ('Ordnael Zurc', 'ordnael@email.com.br', 'MTIzNDU2Nzg=', 'USER', NULL, GETDATE(), 'TROCAR_SENHA')
GO

-- As tabelas s�o baseadas nos 4 usu�rios do sistema, sendo eles: 2 clientes (users), 1 administrador (admin) e 1 prestador

----------------------------------------------------------------------------------------------------------------------------------------------


-- TABELA REGIAO

CREATE TABLE Regiao
(   
   id             INT IDENTITY,
   cidade         VARCHAR(50)         NOT NULL,
   uf			  CHAR(2)			  NOT NULL,
   zona           VARCHAR(20)             NULL, -- SUL, NORTE, LESTE, OESTE, CENTRO
   descricao      VARCHAR(200)        NOT NULL,
   statusRegiao   VARCHAR(20)         NOT NULL, -- ATIVO ou INATIVO

   PRIMARY KEY(id)
   )

GO


INSERT Regiao (cidade, uf, zona, descricao, statusRegiao)
VALUES ('Barueri', 'SP', 'ZONA LESTE', 'Atende toda a regi�o do Engenho Novo e proximidades', 'ATIVO')
INSERT Regiao (cidade, uf, zona, descricao, statusRegiao)
VALUES ('Osasco', 'SP', 'ZONA LESTE', 'Atende toda a regi�o central de Osasco e bairros adjacentes', 'ATIVO');
INSERT Regiao (cidade, uf, zona, descricao, statusRegiao)
VALUES ('Carapicu�ba', 'SP', 'ZONA LESTE',  'Atende bairros como Vila Dirce, Ariston e Centro', 'ATIVO')
INSERT Regiao (cidade, uf, zona, descricao, statusRegiao)
VALUES ('Santana de Parna�ba', 'SP', 'ZONA LESTE',  'Atende bairros hist�ricos e condom�nios residenciais', 'ATIVO')

SELECT * FROM Regiao


-----------------------------------------------------------------------------------------------------------------------------------------



-- TABELA PRESTADOR

CREATE TABLE Prestador

(
   id                    INT IDENTITY,
   usuario_id            INT,
   regiao_id             INT, -- apagar
   nome                  VARCHAR(100)       NOT NULL,
   dataNascimento        DATE,
   cpf                   VARCHAR(11)        NOT NULL,
   genero                VARCHAR(20)        NOT NULL,
   telefone              VARCHAR(11)        NOT NULL,
   logradouro 	 	     VARCHAR(100)       NOT NULL, -- nome da rua, avenida e etc
   numeroResidencial 	 VARCHAR(10)        NOT NULL,
   complemento  	     VARCHAR(100)       NULL,
   cep 	 	             CHAR(8)            NOT NULL,
   bairro  	 	         VARCHAR(100)       NOT NULL,
   cidade 	 	         VARCHAR(100)       NOT NULL,
   uf 		 	         CHAR(2)            NOT NULL,
   statusPrestador       VARCHAR(20)        NOT NULL, -- ATIVO, INATIVO, SUSPENSO


   PRIMARY KEY(id),
   FOREIGN KEY (usuario_id) REFERENCES Usuario(id),
   FOREIGN KEY (regiao_id)  REFERENCES  Regiao(id),
)

GO

INSERT Prestador (usuario_id, regiao_id, nome, dataNascimento, cpf, genero, telefone, logradouro, numeroResidencial, complemento, cep, bairro, cidade, uf, statusPrestador)
VALUES (3, 1, 'Sicrana Bolos', GETDATE(), '12345678910', 'Feminino', '11940028922', 'Rua Lorena', '13', 'Casa 1', '01234567', 'Engenho Novo', 'Barueri', 'SP', 'ATIVO')

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
   descricao             VARCHAR(200)        NOT NULL,
   status_categoria       VARCHAR(20)        NOT NULL,

   PRIMARY KEY(id)
)

GO

INSERT Categoria (nome, descricao, status_categoria)
VALUES ('Alimenta��o', 'Servi�os relacionados � produ��o, preparo e venda de alimentos, como marmitas, doces, bolos e catering.', 'ATIVO')

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
   status_servico		VARCHAR(20), --ATIVO OU INATIVO
   foto		         	VARBINARY(MAX)          NULL,

   PRIMARY KEY (id),
   FOREIGN KEY (categoria_id) REFERENCES Categoria(id),
   FOREIGN KEY (prestador_id) REFERENCES Prestador(id)

)

GO

INSERT Servico (categoria_id, prestador_id, nome, descricao, status_servico, foto)
VALUES (1, 1, 'Confeitaria', 'Produ��o e venda de bolos, doces e confeitos artesanais', 'ATIVO', NULL)

INSERT Servico (categoria_id, prestador_id, nome, descricao, status_servico, foto)
VALUES (1, 1, 'Marmitaria', 'Prepara��o e entrega de marmitas caseiras e saud�veis', 'INATIVO', NULL)

INSERT Servico (categoria_id, prestador_id, nome, descricao, status_servico, foto)
VALUES (1, 1, 'Buffet', 'Servi�os de alimenta��o para festas e eventos', 'INATIVO', NULL)

INSERT Servico (categoria_id, prestador_id, nome, descricao, status_servico, foto)
VALUES (1, 1, 'Salgados', 'Produ��o de salgadinhos para festas e pronta-entrega', 'INATIVO', NULL)


SELECT * FROM Servico




------------------------------------------------------------------------------------------------------

-- TABELA FEEDBACK 

CREATE TABLE Feedback

(
   id                   INT IDENTITY,
   usuario_id           INT,
   prestador_id         INT,
   descricao            VARCHAR(200)        NOT NULL,
   dataCadastro	        SMALLDATETIME	NOT NULL,
   statusFeedback		VARCHAR(20), --ATIVO OU INATIVO


   PRIMARY KEY (id),
   FOREIGN KEY (usuario_id)  REFERENCES Usuario(id),
   FOREIGN KEY (prestador_id) REFERENCES Prestador(id)
)

INSERT Feedback (usuario_id, prestador_id, descricao, dataCadastro, statusFeedback)
VALUES (4, 1, 'O servi�o Sicrana Bolos � muito bom e acolhedor, parab�ns.', GETDATE(), 'ATIVO')

 -- SELECTS
 SELECT * FROM Usuario
 SELECT * FROM Regiao 
 SELECT * FROM Prestador
 SELECT * FROM Contato
 SELECT * FROM Categoria
 SELECT * FROM Servico
 SELECT * FROM Feedback




-- DROPS
DROP TABLE Usuario
DROP TABLE Regiao
DROP TABLE Prestador
DROP TABLE Contato
DROP TABLE Categoria
DROP TABLE Servico
DROP TABLE Feedback



