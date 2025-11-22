DROP DATABASE IF EXISTS gestao;
CREATE DATABASE IF NOT EXISTS gestao DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE gestao;

DROP TABLE IF EXISTS tipo_usuario;
CREATE TABLE tipo_usuario (
  id INT NOT NULL AUTO_INCREMENT,
  nome_tipo VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tipo_usuario (id, nome_tipo) VALUES (1,'admin'), (2,'usuario');


DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  id INT NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(50) NOT NULL,
  senha VARCHAR(255) NOT NULL,
  salt VARCHAR(255) DEFAULT '',
  tipo_id INT DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_tipo_id (tipo_id),
  CONSTRAINT usuarios_ibfk_1 FOREIGN KEY (tipo_id) REFERENCES tipo_usuario(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO usuarios (usuario, senha, salt, tipo_id) VALUES
('nivaldo','12345','',1),
('JoaoSantos','DeD@8689','',1),
('Grazy','grazilimda','',1),
('Junina','Domingo-0','',1),
('Aline','Aline123','',1),
('felipe','FelipeTiffany110623','',1);


DROP TABLE IF EXISTS funcionarios;
CREATE TABLE funcionarios (
  id INT NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(100) NOT NULL,
  senha VARCHAR(255) NOT NULL,
  salt VARCHAR(255) DEFAULT '',
  nome VARCHAR(150) DEFAULT NULL,
  email VARCHAR(150) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO funcionarios (usuario, senha, salt, nome, email) VALUES
('JoaoSantos','DeD@8689','', 'Joao Santos', 'joao.mattos@sou.unifeob.edu.br'),
('nivaldo','12345','', 'Nivaldo Gerente', 'nivaldo@muscleway.com');

DROP TABLE IF EXISTS Produtos;
CREATE TABLE Produtos (
  cod_produto INT PRIMARY KEY,
  nome_produto VARCHAR(255) NOT NULL,
  categoria VARCHAR(100) NOT NULL,
  subcategoria VARCHAR(100),
  preco_real DECIMAL(10,2) NOT NULL DEFAULT 0,
  preco_custo DECIMAL(10,2) NOT NULL DEFAULT 0,
  disponibilidade VARCHAR(50) DEFAULT 'Pronta Entrega',
  estoque INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO Produtos (cod_produto, nome_produto, categoria, subcategoria, preco_real, preco_custo, disponibilidade, estoque) VALUES
(490, 'BCAA Sintex 6:1:1 150g', 'Aminoácidos', 'BCAA', 32.90, 30.00, 'Pronta Entrega', 0),
(523, 'BC235AA Sintex 6:1:1 300g', 'Aminoácidos', 'BCAA', 51.90, 50.00, 'Pronta Entrega', 50),
(17,  'BCAA Giga 1G', 'Aminoácidos', 'BCAA', 17.90, 15.00, 'Pronta Entrega', 20),
(498, 'Creatine Micronized 100% Pure 150g', 'Aminoácidos', 'Creatina', 69.90, 45.90, 'Pronta Entrega', 4),
(499, 'Creatine Micronized 100% Pure 300g', 'Aminoácidos', 'Creatina', 119.90, 69.90, 'Pronta Entrega', 61),
(500, 'Creatine Micronized 100% Pure 90g', 'Aminoácidos', 'Creatina', 39.90, 29.90, 'Indisponível', 47),
(503, 'Glutamine Powder 300g', 'Aminoácidos', 'Glutamina', 66.90, 56.90, 'Pronta Entrega', 54),
(502, 'Glutamine Powder 150g', 'Aminoácidos', 'Glutamina', 36.90, 31.90, 'Pronta Entrega', 14),
(510, 'Thermo Pro Hers (240 Mg)', 'Emagrecedores', 'Termogênico', 19.90, 18.00, 'Pronta Entrega', 35),
(509, 'Thermo Pro Hard (400 Mg)', 'Emagrecedores', 'Termogênico', 24.90, 20.00, 'Pronta Entrega', 26),
(507, 'L-Carnitine Reload', 'Emagrecedores', 'Termogênico', 29.90, 26.90, 'Pronta Entrega', 6),
(508, 'Testo Hard Gh - 60 Tabletes', 'Específicos', 'Pré Hormonais', 30.90, 30.00, 'Pronta Entrega', 12),
(518, 'Zma Up - 90 Cápsulas', 'Específicos', 'Pré Hormonais', 25.90, 22.90, 'Pronta Entrega', 32),
(43,  'Hipercalórico Anabolic Gainer Mass 3kg Muscle Way', 'Específicos', 'Hipercalóricos', 72.90, 64.90, 'Pronta Entrega', 54),
(511, 'Vit-Full - 90 Cápsulas', 'Específicos', 'Multivitamínico', 25.90, 23.90, 'Pronta Entrega', 12),
(47,  'Beta Nos -200 Gramas', 'Pré Treinos', 'Desempenho', 62.90, 59.90, 'Pronta Entrega', 65),
(501, 'Dilaton Pump - 120 Cápsulas', 'Pré Treinos', 'Vasodilatador', 42.90, 40.00, 'Pronta Entrega', 13),
(103, 'Top Whey - Refil 900G', 'Proteínas', 'Whey Protein', 59.90, 55.90, 'Pronta Entrega', 34),
(63,  'Iso Protein Complex - Refil 900g', 'Proteínas', 'Whey Protein', 75.90, 55.90, 'Pronta Entrega', 26),
(51,  'Isolate Whey Mix - Pote 907G', 'Proteínas', 'Whey Protein', 121.90, 78.90, 'Pronta Entrega', 18),
(59,  'Whey 3W Gourmet - Pote 907G', 'Proteínas', 'Whey Protein', 139.90, 125.90, 'Pronta Entrega', 37),
(61,  'Isolate Whey Mix - Refil 900G', 'Proteínas', 'Whey Protein', 105.40, 55.90, 'Pronta Entrega', 61),
(49,  'Whey 100% - Pote 907G', 'Proteínas', 'Whey Protein', 133.90, 69.90, 'Pronta Entrega', 33),
(45,  'Iso Whey - Pote 907G', 'Proteínas', 'Whey Protein', 201.90, 149.90, 'Pronta Entrega', 46),
(80,  'Kit Ganho De Peso', 'Kit Pronto', 'Ganho de Peso', 157.90, 150.00, 'Pronta Entrega', 42),
(84,  'Kit Ganho De Massa', 'Kit Pronto', 'Ganho de Massa', 179.90, 175.00, 'Pronta Entrega', 5),
(89,  'Kit Hipertrofia', 'Kit Pronto', 'Hipertrofia', 216.90, 200.00, 'Pronta Entrega', 13),
(100, 'Kit Emagrecedor', 'Kit Pronto', 'Emagrecimento', 219.90, 200.00, 'Pronta Entrega', 2),
(104, 'Kit Desempenho', 'Kit Pronto', 'Desempenho', 197.90, 195.00, 'Pronta Entrega', 17),
(113, 'Kit Imunidade', 'Kit Pronto', 'Imunidade', 172.90, 170.00, 'Pronta Entrega', 41),
(117, 'Kit Performance', 'Kit Pronto', 'Performance', 260.90, 170.00, 'Pronta Entrega', 34),
(107, 'Camiseta Dry Fit Never Lose Your Way', 'Acessórios', 'Vestuário', 39.90, 35.00, 'Pronta Entrega', 20),
(57,  'Coqueteleira Muscleway - 600 Ml', 'Acessórios', 'Coqueteleira', 15.90, 10.00, 'Pronta Entrega', 44);


DROP TABLE IF EXISTS itens_venda;
DROP TABLE IF EXISTS vendas;

CREATE TABLE vendas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome_cliente VARCHAR(100) NOT NULL,
  email VARCHAR(120),
  telefone VARCHAR(30),
  total DECIMAL(10,2) NOT NULL,
  data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE itens_venda (
  id INT AUTO_INCREMENT PRIMARY KEY,
  venda_id INT NOT NULL,
  produto_id INT NOT NULL,
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE,
  FOREIGN KEY (produto_id) REFERENCES Produtos(cod_produto) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS logs_produtos;
CREATE TABLE logs_produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  operacao VARCHAR(20),
  tabela VARCHAR(50),
  produto_id INT,
  usuario VARCHAR(100),
  ip_usuario VARCHAR(50),
  valores_anteriores TEXT,
  valores_novos TEXT,
  data DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP PROCEDURE IF EXISTS log_produto;
DELIMITER $$
CREATE PROCEDURE log_produto(
    IN p_operacao VARCHAR(20),
    IN p_tabela VARCHAR(50),
    IN p_produto_id INT,
    IN p_valores_ant TEXT,
    IN p_valores_nov TEXT
)
BEGIN
    INSERT INTO logs_produtos (
        operacao, tabela, produto_id, usuario, ip_usuario, valores_anteriores, valores_novos
    ) VALUES (
        p_operacao,
        p_tabela,
        p_produto_id,
        COALESCE(@usuario_logado, CURRENT_USER()),
        (SELECT CONCAT(host, '', '') FROM information_schema.processlist WHERE ID = CONNECTION_ID()),
        p_valores_ant,
        p_valores_nov
    );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_produto_insert;
DROP TRIGGER IF EXISTS trg_produto_update;
DROP TRIGGER IF EXISTS trg_produto_delete;

DELIMITER $$
CREATE TRIGGER trg_produto_insert
AFTER INSERT ON Produtos
FOR EACH ROW
BEGIN
    CALL log_produto(
        'INSERT',
        'Produtos',
        NEW.cod_produto,
        NULL,
        CONCAT('nome=', NEW.nome_produto, ', preco_real=', NEW.preco_real, ', preco_custo=', NEW.preco_custo, ', estoque=', NEW.estoque)
    );
END$$

CREATE TRIGGER trg_produto_update
AFTER UPDATE ON Produtos
FOR EACH ROW
BEGIN
    CALL log_produto(
        'UPDATE',
        'Produtos',
        NEW.cod_produto,
        CONCAT('nome=', OLD.nome_produto, ', preco_real=', OLD.preco_real, ', preco_custo=', OLD.preco_custo, ', estoque=', OLD.estoque),
        CONCAT('nome=', NEW.nome_produto, ', preco_real=', NEW.preco_real, ', preco_custo=', NEW.preco_custo, ', estoque=', NEW.estoque)
    );
END$$

CREATE TRIGGER trg_produto_delete
AFTER DELETE ON Produtos
FOR EACH ROW
BEGIN
    CALL log_produto(
        'DELETE',
        'Produtos',
        OLD.cod_produto,
        CONCAT('nome=', OLD.nome_produto, ', preco_real=', OLD.preco_real, ', preco_custo=', OLD.preco_custo, ', estoque=', OLD.estoque),
        NULL
    );
END$$
DELIMITER ;

DROP TABLE IF EXISTS atendimento;
CREATE TABLE atendimento (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL,
  mensagem TEXT NOT NULL,
  data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS newsletter;
CREATE TABLE newsletter (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(150) NOT NULL UNIQUE,
  data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP VIEW IF EXISTS vw_produtos_mais_vendidos;
CREATE VIEW vw_produtos_mais_vendidos AS
SELECT p.cod_produto, p.nome_produto, SUM(iv.quantidade) AS qtd_vendida,
       SUM(iv.quantidade * iv.preco_unitario) AS receita
FROM itens_venda iv
JOIN Produtos p ON p.cod_produto = iv.produto_id
GROUP BY p.cod_produto, p.nome_produto
ORDER BY qtd_vendida DESC;

DROP VIEW IF EXISTS vw_gasto_cliente;
CREATE VIEW vw_gasto_cliente AS
SELECT nome_cliente, email, SUM(total) AS gasto
FROM vendas
GROUP BY email, nome_cliente
ORDER BY gasto DESC;