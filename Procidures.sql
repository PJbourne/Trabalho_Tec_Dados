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

-- Procedure 2:

DELIMITER //
CREATE FUNCTION total_pontos (in_team VARCHAR(50), in_year INT)
RETURNS INT DETERMINISTIC
BEGIN
    SELECT 
        e.Nome_Equipe,
        YEAR(c.Ano) AS Ano_Campeonato,  
        SUM(p.Pontos) AS total_team_points
    FROM Equipes e
    JOIN Pilotos p ON (e.Piloto_1 = p.ID_Pilotos OR e.Piloto_2 = p.ID_Pilotos)
    JOIN Piloto_campeonato pc ON p.ID_Pilotos = pc.ID_Pilotos
    JOIN Campeonato c ON pc.ID_Campeonato = c.ID_Campeonato
    WHERE e.Nome_Equipe = in_team AND YEAR(c.Ano) = in_year
    GROUP BY e.Nome_Equipe, YEAR(c.Ano)
    ORDER BY Ano_Campeonato;

    SELECT 
        p.Nome_piloto,
        YEAR(c.Ano) AS Ano_Campeonato,  
        SUM(p.Pontos) AS pilot_total_points
    FROM Equipes e
    JOIN Pilotos p ON (e.Piloto_1 = p.ID_Pilotos OR e.Piloto_2 = p.ID_Pilotos)
    JOIN Piloto_campeonato pc ON p.ID_Pilotos = pc.ID_Pilotos
    JOIN Campeonato c ON pc.ID_Campeonato = c.ID_Campeonato
    WHERE e.Nome_Equipe = in_team AND YEAR(c.Ano) = in_year
    GROUP BY p.Nome_piloto, YEAR(c.Ano)
    ORDER BY Ano_Campeonato;
END //
DELIMITER ;

CALL total_pontos('Mercedes',2023);

-- Procedure 3:
DELIMITER //
CREATE PROCEDURE campeonato_info(IN championship_date DATE)
BEGIN
    SELECT 
        c.ID_Campeonato,
        YEAR(c.Ano) AS AnoCampeonato,
        COUNT(cr.ID_Corrida) AS TotalCorridas
    FROM Campeonato c
    LEFT JOIN Corridas cr ON c.ID_Campeonato = cr.Championship
    WHERE YEAR(c.Ano) = YEAR(championship_date)
    GROUP BY c.ID_Campeonato, YEAR(c.Ano);

    SELECT 
        p.Nome_piloto,
        p.Pontos
    FROM Pilotos p
    JOIN Piloto_campeonato pc ON p.ID_Pilotos = pc.ID_Pilotos
    JOIN Campeonato c ON pc.ID_Campeonato = c.ID_Campeonato
    WHERE YEAR(c.Ano) = YEAR(championship_date)
    ORDER BY p.Pontos DESC
    LIMIT 1;

    SELECT 
        p.Nome_piloto,
        COUNT(cr.Volta_rápida) AS TotalVoltasRapidas
    FROM Pilotos p
    JOIN Corridas cr ON cr.Volta_rápida = p.ID_Pilotos
    JOIN Campeonato c ON cr.Championship = c.ID_Campeonato
    WHERE YEAR(c.Ano) = YEAR(championship_date)
    GROUP BY p.ID_Pilotos
    ORDER BY TotalVoltasRapidas DESC
    LIMIT 1;
END //
DELIMITER ;

-- Chamada da procedure:
CALL campeonato_info('2021-01-01');

-- procedure 4:
DELIMITER //
CREATE PROCEDURE piloto_inf(nome_piloto_input VARCHAR(50))
BEGIN
    SELECT 
        p.ID_Pilotos, 
        p.Nome_piloto, 
        p.Salário, 
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