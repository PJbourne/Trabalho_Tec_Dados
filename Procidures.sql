-- Procedure 1: Adicionar uma nova carrida
DELIMITER //
CREATE PROCEDURE AdicionarCorrida(
	IN p_idcorrida INT,
    IN p_Localidade VARCHAR(50),
    IN p_Autodromo VARCHAR(50),
    IN p_Tempo VARCHAR(50),
    IN p_VoltaRapida DECIMAL(10, 2),
    IN p_Primeiro VARCHAR(50),
    IN p_Segundo VARCHAR(50),
    IN p_Terceiro VARCHAR(50),
    IN p_Quarto VARCHAR(50),
    IN p_Quinto VARCHAR(50),
    IN p_Sexto VARCHAR(50),
    IN p_Setimo VARCHAR(50),
    IN p_Oitavo VARCHAR(50),
    IN p_Nono VARCHAR(50),
    IN p_Decimo VARCHAR(50),
    IN p_ID_Campeonato INT
)
BEGIN
    -- Insere a nova corrida na tabela Corridas
    INSERT INTO Corridas (
        ID_Corrida,Localidade, Autodromo, Tempo, Volta_rapida,
        Primeiro, Segundo, Terceiro, Quarto, Quinto,
        Sexto, Setimo, Oitavo, Nono, Decimo, Championship
    ) VALUES (
        p_idcorrida,p_Localidade, p_Autodromo, p_Tempo, p_VoltaRapida,
        p_Primeiro, p_Segundo, p_Terceiro, p_Quarto, p_Quinto,
        p_Sexto, p_Setimo, p_Oitavo, p_Nono, p_Decimo, p_ID_Campeonato
    );
    -- Mensagem de sucesso
    SELECT 'Corrida adicionada com sucesso!' AS Mensagem;
END //
DELIMITER ;

CALL AdicionarCorrida('8','Brasil','Interlagos','1h30m',1.25,'Lewis Hamilton','Max Verstappen','Charles Leclerc','Sergio Perez','Carlos Sainz','Lando Norris','George Russell','Fernando Alonso','Esteban Ocon','Pierre Gasly',1);

SELECT * FROM Corridas WHERE Localidade = 'Brasil';



-- Procedure 2: Adicionar um novo campeonato
DELIMITER //

CREATE PROCEDURE AdicionarCampeonato(
    IN p_idcampeonato INT,
    IN p_ano DATE,
    IN p_info VARCHAR(50)
)
BEGIN
    -- Insere um novo campeonato na tabela Campeonato
    INSERT INTO Campeonato (ID_Campeonato, Ano, Informacaoes)
    VALUES (p_idcampeonato, p_ano, p_info);
    
    -- Mensagem de sucesso
    SELECT 'Campeonato adicionado com sucesso!' AS Mensagem;
END //

DELIMITER ;


CALL AdicionarCampeonato(4,'2024-01-01','Campeonato 2024');

SELECT * FROM campeonato;

-- Procedure 3:

DROP PROCEDURE montar_classificacao;
DELIMITER //
CREATE PROCEDURE montar_classificacao(championship_date DATE)
BEGIN
    DECLARE championship_id INT;
    DECLARE done INT DEFAULT 0;
    DECLARE piloto_nome VARCHAR(50);
    DECLARE piloto_pontos INT;
    DECLARE ranking INT DEFAULT 1;
    
    -- Cursor para armazenar a classificacao
    DECLARE class_cursor CURSOR FOR
        SELECT Piloto, Pontos FROM Pontuacao_Pilotos ORDER BY Pontos DESC, Piloto;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Obter o ID do campeonato com base no ano fornecido
    SELECT ID_Campeonato INTO championship_id 
    FROM Campeonato 
    WHERE YEAR(Ano) = YEAR(championship_date);
    
    -- Se o campeonato nao existir, sair
    IF championship_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Campeonato nao encontrado';
    END IF;
    
    -- Garantir que a tabela temporaria nao existe antes de criar
    DROP TEMPORARY TABLE IF EXISTS Pontuacao_Pilotos;
    
    -- Criar uma tabela temporaria para armazenar os pontos
    CREATE TEMPORARY TABLE Pontuacao_Pilotos (
        Piloto VARCHAR(50) PRIMARY KEY,
        Pontos INT DEFAULT 0
    );
    
    -- Inserir ou atualizar pontos com base nos resultados das corridas
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Primeiro, 25 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 25;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Segundo, 18 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 18;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Terceiro, 15 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 15;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Quarto, 12 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 12;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Quinto, 10 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 10;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Sexto, 8 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 8;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Setimo, 6 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 6;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Oitavo, 4 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 4;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Nono, 2 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 2;
    
    INSERT INTO Pontuacao_Pilotos (Piloto, Pontos)
    SELECT Decimo, 1 FROM Corridas WHERE Championship = championship_id
    ON DUPLICATE KEY UPDATE Pontos = Pontos + 1;
    
    -- Abrir cursor e inserir na classificacao
    OPEN class_cursor;
    
    DELETE FROM Classificacao WHERE Championship = championship_id;
    
    INSERT INTO Classificacao (Championship) VALUES (championship_id);
    
    read_loop: LOOP
        FETCH class_cursor INTO piloto_nome, piloto_pontos;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        CASE ranking
            WHEN 1 THEN UPDATE Classificacao SET Primeiro = piloto_nome WHERE Championship = championship_id;
            WHEN 2 THEN UPDATE Classificacao SET Segundo = piloto_nome WHERE Championship = championship_id;
            WHEN 3 THEN UPDATE Classificacao SET Terceiro = piloto_nome WHERE Championship = championship_id;
            WHEN 4 THEN UPDATE Classificacao SET Quarto = piloto_nome WHERE Championship = championship_id;
            WHEN 5 THEN UPDATE Classificacao SET Quinto = piloto_nome WHERE Championship = championship_id;
            WHEN 6 THEN UPDATE Classificacao SET Sexto = piloto_nome WHERE Championship = championship_id;
            WHEN 7 THEN UPDATE Classificacao SET Setimo = piloto_nome WHERE Championship = championship_id;
            WHEN 8 THEN UPDATE Classificacao SET Oitavo = piloto_nome WHERE Championship = championship_id;
            WHEN 9 THEN UPDATE Classificacao SET Nono = piloto_nome WHERE Championship = championship_id;
            WHEN 10 THEN UPDATE Classificacao SET Decimo = piloto_nome WHERE Championship = championship_id;
        END CASE;
        
        SET ranking = ranking + 1;
        IF ranking > 10 THEN LEAVE read_loop; END IF;
    END LOOP;
    
    CLOSE class_cursor;
    
    -- Remover tabela temporaria
    DROP TEMPORARY TABLE IF EXISTS Pontuacao_Pilotos;
END //
DELIMITER ;

DELETE FROM Classificacao WHERE Championship = 1;
SELECT * FROM Classificacao;
-- Chamada da procedure:
CALL montar_classificacao('2021-01-01');
SELECT * FROM Corridas;

-- INSERT INTO Corridas (ID_Corrida, Localidade, Autodromo, Tempo, Volta_rapida, Primeiro, Segundo, Terceiro, Quarto, Quinto, Sexto, Setimo, Oitavo, Nono, Decimo, Championship) VALUES
CALL AdicionarCorrida(15, 'Turquia', 'Istanbul Park', '1h31m04.103s', 90.432, 'Valtteri Bottas', 'Max Verstappen', 'Sergio Pérez', 'Charles Leclerc', 'Lewis Hamilton', 'Pierre Gasly', 'Lando Norris', 'Carlos Sainz Jr.', 'Lance Stroll', 'Esteban Ocon', 1);
-- Grande Prêmio dos Estados Unidos de 2021
INSERT INTO Corridas (ID_Corrida, Localidade, Autodromo, Tempo, Volta_rapida, Primeiro, Segundo, Terceiro, Quarto, Quinto, Sexto, Setimo, Oitavo, Nono, Decimo, Championship) VALUES
(16, 'Estados Unidos', 'Circuito das Américas, Austin, Texas', '1h34m36.552s', '98.485', 'Max Verstappen', 'Lewis Hamilton', 'Sergio Pérez', 'Charles Leclerc', 'Daniel Ricciardo', 'Valtteri Bottas', 'Carlos Sainz Jr.', 'Lando Norris', 'Yuki Tsunoda', 'Sebastian Vettel', 1);
-- Grande Prêmio da Cidade do México de 2021
INSERT INTO Corridas (ID_Corrida, Localidade, Autodromo, Tempo, Volta_rapida, Primeiro, Segundo, Terceiro, Quarto, Quinto, Sexto, Setimo, Oitavo, Nono, Decimo, Championship) VALUES
(17, 'México', 'Autódromo Hermanos Rodríguez, Cidade do México', '1h38m39.086s', '77.774', 'Max Verstappen', 'Lewis Hamilton', 'Sergio Pérez', 'Pierre Gasly', 'Charles Leclerc', 'Carlos Sainz Jr.', 'Sebastian Vettel', 'Kimi Räikkönen', 'Fernando Alonso', 'Lando Norris', 1);
-- Grande Prêmio de São Paulo de 2021
INSERT INTO Corridas (ID_Corrida, Localidade, Autodromo, Tempo, Volta_rapida, Primeiro, Segundo, Terceiro, Quarto, Quinto, Sexto, Setimo, Oitavo, Nono, Decimo, Championship) VALUES
(18, 'Brasil', 'Autódromo de Interlagos, São Paulo', '1h32m22.851s', '71.282', 'Lewis Hamilton', 'Max Verstappen', 'Valtteri Bottas', 'Carlos Sainz Jr.', 'Daniel Ricciardo', 'Lando Norris', 'Charles Leclerc', 'Sergio Pérez', 'Esteban Ocon', 'Sebastian Vettel', 1);

-- procedure 4:
drop procedure piloto_inf;
DELIMITER //
CREATE PROCEDURE piloto_inf(nome_piloto_input VARCHAR(50))
BEGIN
    SELECT 
        p.ID_Pilotos, 
        p.Nome_piloto, 
        p.Salario, 
        p.Equipe, 
        e.Carro, 
        IFNULL(COUNT(pc.ID_Campeonato), 0) AS Campeonatos
    FROM Pilotos p
    LEFT JOIN Equipes e ON p.Equipe = e.Nome_Equipe
    LEFT JOIN Piloto_campeonato pc ON p.ID_Pilotos = pc.ID_Pilotos
    WHERE p.Nome_piloto = nome_piloto_input
    GROUP BY p.ID_Pilotos;
END //
DELIMITER ;

call piloto_inf('George Russell');

-- procedure 5:
DELIMITER //
CREATE PROCEDURE equipe_inf()
BEGIN
    SELECT 
        e.Nome_Equipe,
        CONCAT(UPPER(p1.Nome_piloto), ' & ', UPPER(p2.Nome_piloto)) AS Drivers,
        c.Especificacoes AS CarSpecifications,
        m.Especificacoes AS MotorSpecs
    FROM Equipes e
    JOIN Pilotos p1 ON e.Piloto_1 = p1.ID_Pilotos
    JOIN Pilotos p2 ON e.Piloto_2 = p2.ID_Pilotos
    JOIN tem t ON e.Nome_Equipe = t.Equipe
    JOIN Carros c ON t.ID_carro = c.ID_carro
    JOIN Motor m ON c.ID_motor = m.ID_motor
    WHERE p1.Pontos > 0 AND p2.Pontos > 0;
END //
DELIMITER ;

call equipe_inf();

