//antes de rodar o banco tem que criar uma procedure chamada log_produto com esse scrpt:
CREATE DEFINER=root@localhost PROCEDURE log_produto(
    IN p_operacao VARCHAR(10),
    IN p_tabela VARCHAR(50),
    IN p_produto_id INT,
    IN p_valores_anteriores TEXT,
    IN p_valores_novos TEXT
)
BEGIN
    DECLARE v_usuario VARCHAR(100);
    DECLARE v_ip_usuario VARCHAR(45);
    SET v_usuario = USER();
    SET v_ip_usuario = (SELECT SUBSTRING_INDEX(USER(), '@', -1));
    INSERT INTO logs_produtos (operacao, tabela, produto_id, usuario, ip_usuario, valores_anteriores, valores_novos)
    VALUES (p_operacao, p_tabela, p_produto_id, v_usuario, v_ip_usuario, p_valores_anteriores, p_valores_novos);
END

//depois cria o banco com esse script:
CREATE DATABASE  IF NOT EXISTS `gestao` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestao`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` VALUES (1,'admin'),(2,'usuario');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES 
(1,'nivaldo','12345',1),
(2,'JoaoSantos','DeD@8689',1),
(3,'Grazy','grazilimda',1),
(4,'Junina','Domingo-0',1),
(5,'Aline','Aline123',1),
(6,'felipe','FelipeTiffany110623',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

ALTER TABLE usuarios 
ADD COLUMN salt VARCHAR(255) AFTER senha;

CREATE TABLE IF NOT EXISTS `funcionarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  `nome` VARCHAR(150) DEFAULT NULL,
  `email` VARCHAR(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE funcionarios
ADD COLUMN salt VARCHAR(255) AFTER senha;

INSERT INTO `funcionarios` (`usuario`, `senha`, `nome`, `email`) VALUES
('JoaoSantos', 'DeD@8689', 'Joao Santos', 'joao.mattos@sou.unifeob.edu.br'),
('nivaldo', '12345', 'Nivaldo Gerente', 'nivaldo@muscleway.com');

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;	
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

CREATE TABLE Produtos (
    cod_produto INT PRIMARY KEY, -- APENAS PRIMARY KEY
    nome_produto VARCHAR(255) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    subcategoria VARCHAR(100),
    preco_real DECIMAL(10, 2) NOT NULL,
    disponibilidade VARCHAR(50)
); 

INSERT INTO Produtos (cod_produto, nome_produto, categoria, subcategoria, preco_real, disponibilidade) VALUES
(490, 'BCAA Sintex 6:1:1 150g', 'Aminoácidos', 'BCAA', 32.90, 'Pronta Entrega'), 
(523, 'BC235AA Sintex 6:1:1 300g', 'Aminoácidos', 'BCAA', 51.90, 'Pronta Entrega'),
(17, 'BCAA Giga 1G', 'Aminoácidos', 'BCAA', 17.90, 'Pronta Entrega'),
(498, 'Creatine Micronized 100% Pure 150g', 'Aminoácidos', 'Creatina', 69.90, 'Pronta Entrega'),
(499, 'Creatine Micronized 100% Pure 300g', 'Aminoácidos', 'Creatina', 119.90, 'Pronta Entrega'),
(500, 'Creatine Micronized 100% Pure 90g', 'Aminoácidos', 'Creatina', 39.90, 'Indisponível'),
(503, 'Glutamine Powder 300g', 'Aminoácidos', 'Glutamina', 66.90, 'Pronta Entrega'),
(502, 'Glutamine Powder 150g', 'Aminoácidos', 'Glutamina', 36.90, 'Pronta Entrega'),
(510, 'Thermo Pro Hers (240 Mg)', 'Emagrecedores', 'Termogênico', 19.90, 'Pronta Entrega'),
(509, 'Thermo Pro Hard (400 Mg)', 'Emagrecedores', 'Termogênico', 24.90, 'Pronta Entrega'),
(507, 'L-Carnitine Reload', 'Emagrecedores', 'Termogênico', 29.90, 'Pronta Entrega'),
(508, 'Testo Hard Gh - 60 Tabletes', 'Específicos', 'Pré Hormonais', 30.90, 'Pronta Entrega'),
(518, 'Zma Up - 90 Cápsulas', 'Específicos', 'Pré Hormonais', 25.90, 'Pronta Entrega'),
(43, 'Hipercalórico Anabolic Gainer Mass 3kg Muscle Way', 'Específicos', 'Hipercalóricos', 72.90, 'Pronta Entrega'),
(511, 'Vit-Full - 90 Cápsulas', 'Específicos', 'Multivitamínico', 25.90, 'Pronta Entrega'),
(47, 'Beta Nos -200 Gramas', 'Pré Treinos', 'Desempenho', 62.90, 'Pronta Entrega'),
(501, 'Dilaton Pump - 120 Cápsulas', 'Pré Treinos', 'Vasodilatador', 42.90, 'Pronta Entrega'),
(103, 'Top Whey - Refil 900G', 'Proteínas', 'Whey Protein', 59.90, 'Pronta Entrega'),
(63, 'Iso Protein Complex - Refil 900g', 'Proteínas', 'Whey Protein', 75.90, 'Pronta Entrega'),
(51, 'Isolate Whey Mix - Pote 907G', 'Proteínas', 'Whey Protein', 121.90, 'Pronta Entrega'),
(59, 'Whey 3W Gourmet - Pote 907G', 'Proteínas', 'Whey Protein', 139.90, 'Pronta Entrega'),
(61, 'Isolate Whey Mix - Refil 900G', 'Proteínas', 'Whey Protein', 105.40, 'Pronta Entrega'),
(49, 'Whey 100% - Pote 907G', 'Proteínas', 'Whey Protein', 133.90, 'Pronta Entrega'),
(45, 'Iso Whey - Pote 907G', 'Proteínas', 'Whey Protein', 201.90, 'Pronta Entrega'),
(80, 'Kit Ganho De Peso', 'Kit Pronto', 'Ganho de Peso', 157.90, 'Pronta Entrega'),
(84, 'Kit Ganho De Massa', 'Kit Pronto', 'Ganho de Massa', 179.90, 'Pronta Entrega'),
(89, 'Kit Hipertrofia', 'Kit Pronto', 'Hipertrofia', 216.90, 'Pronta Entrega'),
(100, 'Kit Emagrecedor', 'Kit Pronto', 'Emagrecimento', 219.90, 'Pronta Entrega'),
(104, 'Kit Desempenho', 'Kit Pronto', 'Desempenho', 197.90, 'Pronta Entrega'),
(113, 'Kit Imunidade', 'Kit Pronto', 'Imunidade', 172.90, 'Pronta Entrega'),
(117, 'Kit Performance', 'Kit Pronto', 'Performance', 260.90, 'Pronta Entrega'),
(107, 'Camiseta Dry Fit Never Lose Your Way', 'Acessórios', 'Vestuário', 39.90, 'Pronta Entrega'),
(57, 'Coqueteleira Muscleway - 600 Ml', 'Acessórios', 'Coqueteleira', 15.90, 'Pronta Entrega');

CREATE USER 'JoaoSantos'@'%' IDENTIFIED BY 'DeD@8689';
GRANT ALL PRIVILEGES ON gestao TO 'JoaoSantos'@'gestao';

CREATE USER 'Grazy'@'%' IDENTIFIED BY 'grazilimda';
GRANT ALL PRIVILEGES ON gestao TO 'Grazy'@'gestao';

CREATE USER 'Queiroz'@'%' IDENTIFIED BY 'Domingo-0';
GRANT SELECT ON gestao TO 'Queiroz'@'gestao';
GRANT UPDATE ON gestao TO 'Queiroz'@'gestao';

CREATE USER 'Aline'@'%' IDENTIFIED BY 'Aline123';
GRANT ALL PRIVILEGES ON gestao TO 'Aline'@'gestao';

CREATE USER 'Felipe'@'%' IDENTIFIED BY 'FelipeTiffany110623';
GRANT SELECT ON gestao TO 'Felipe'@'gestao';

CREATE TABLE logs_produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    operacao VARCHAR(10),
    tabela VARCHAR(50),
    produto_id INT,
    usuario VARCHAR(100),
    ip_usuario VARCHAR(45),
    valores_anteriores TEXT,
    valores_novos TEXT,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_produto_insert
AFTER INSERT ON produtos
FOR EACH ROW
BEGIN
    CALL log_produto(
        'INSERT',
        'produtos',
        NEW.cod_produto,
        NULL,
        CONCAT('nome=', NEW.nome_produto, ', preco=', NEW.preco_real)
    );
END //

CREATE TRIGGER trg_produto_update
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    CALL log_produto(
        'UPDATE',
        'produtos',
        NEW.cod_produto,
        CONCAT('nome=', OLD.nome_produto, ', preco=', OLD.preco_real),
        CONCAT('nome=', NEW.nome_produto, ', preco=', NEW.preco_real)
    );
END //

CREATE TRIGGER trg_produto_delete
AFTER DELETE ON produtos
FOR EACH ROW
BEGIN
    CALL log_produto(
        'DELETE',
        'produtos',
        OLD.cod_produto,
        CONCAT('nome=', OLD.nome_produto, ', preco=', OLD.preco_real),
        NULL
    );
END //

DELIMITER ;

ALTER TABLE Produtos
ADD COLUMN estoque INT NOT NULL DEFAULT 0;

UPDATE Produtos SET estoque = 20 WHERE cod_produto = 17;
UPDATE Produtos SET estoque = 0 WHERE cod_produto = 490;
UPDATE Produtos SET estoque = 50 WHERE cod_produto = 523;
UPDATE Produtos SET estoque = 4 WHERE cod_produto = 498;
UPDATE Produtos SET estoque = 61 WHERE cod_produto = 499;
UPDATE Produtos SET estoque = 47 WHERE cod_produto = 500;
UPDATE Produtos SET estoque = 54 WHERE cod_produto = 503;
UPDATE Produtos SET estoque = 14 WHERE cod_produto = 502;
UPDATE Produtos SET estoque = 35 WHERE cod_produto = 510;
UPDATE Produtos SET estoque = 26 WHERE cod_produto = 509;
UPDATE Produtos SET estoque = 6 WHERE cod_produto = 507;
UPDATE Produtos SET estoque = 12 WHERE cod_produto = 508;
UPDATE Produtos SET estoque = 32 WHERE cod_produto = 518;
UPDATE Produtos SET estoque = 54 WHERE cod_produto = 43;
UPDATE Produtos SET estoque = 12 WHERE cod_produto = 511;
UPDATE Produtos SET estoque = 65 WHERE cod_produto = 47;
UPDATE Produtos SET estoque = 13 WHERE cod_produto = 501;
UPDATE Produtos SET estoque = 34 WHERE cod_produto = 103;
UPDATE Produtos SET estoque = 26 WHERE cod_produto = 63;
UPDATE Produtos SET estoque = 18 WHERE cod_produto = 51;
UPDATE Produtos SET estoque = 37 WHERE cod_produto = 59;
UPDATE Produtos SET estoque = 61 WHERE cod_produto = 61;
UPDATE Produtos SET estoque = 33 WHERE cod_produto = 49;
UPDATE Produtos SET estoque = 46 WHERE cod_produto = 45;
UPDATE Produtos SET estoque = 42 WHERE cod_produto = 80;
UPDATE Produtos SET estoque = 5 WHERE cod_produto = 84;
UPDATE Produtos SET estoque = 13 WHERE cod_produto = 89;
UPDATE Produtos SET estoque = 02 WHERE cod_produto = 100;
UPDATE Produtos SET estoque = 17 WHERE cod_produto = 104;
UPDATE Produtos SET estoque = 41 WHERE cod_produto = 113;
UPDATE Produtos SET estoque = 34 WHERE cod_produto = 117;
UPDATE Produtos SET estoque = 20 WHERE cod_produto = 107;
UPDATE Produtos SET estoque = 44 WHERE cod_produto = 57;


CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    email VARCHAR(120),
    telefone VARCHAR(30),
    total DECIMAL(10,2) NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE itens_venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES vendas(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(cod_produto)
);

SELECT id, usuario, senha, salt FROM usuarios WHERE usuario = 'JoaoSantos';

UPDATE usuarios 
SET senha = 'DeD@8689', salt = NULL
WHERE usuario = 'JoaoSantos';


SELECT id, usuario, senha, salt FROM usuarios;

SELECT * FROM usuarios;

CREATE TABLE atendimento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,    
    mensagem TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE newsletter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM logs_produtos ORDER BY data DESC;

        SELECT * FROM logs_produtos;


UPDATE usuarios 
SET salt = ''
WHERE salt IS NULL;
