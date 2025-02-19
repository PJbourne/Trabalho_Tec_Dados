-- Procedure 1:
-- retorna quantos pontos o piloto tem no campeonato (ano)
USE formula_one;
DELIMITER //
CREATE PROCEDURE piloto_pontos_ano(in_pilot VARCHAR(50), in_year INT) -- (IN in_pilot VARCHAR(50), IN in_year INT)
BEGIN
    SELECT 
        in_pilot AS Piloto,
        COUNT(*) AS total_races,
        SUM(race_points) AS total_points,
        AVG(race_points) AS avg_points
    FROM (
        SELECT
            c.ID_Corrida,
            CASE
                WHEN c.Primeiro = in_pilot THEN 25
                WHEN c.Segundo = in_pilot THEN 18
                WHEN c.Terceiro = in_pilot THEN 15
                WHEN c.Quarto = in_pilot THEN 12
                WHEN c.Quinto = in_pilot THEN 10
                WHEN c.Sexto = in_pilot THEN 8
                WHEN c.Setmo = in_pilot THEN 6
                WHEN c.Oitavo = in_pilot THEN 4
                WHEN c.Nono = in_pilot THEN 2
                WHEN c.`Décimo` = in_pilot THEN 1
                ELSE 0 -- Se o piloto não pontuou
            END AS race_points
        FROM Corridas c
        JOIN Campeonato camp ON c.Championship = camp.ID_Campeonato
        WHERE YEAR(camp.Ano) = in_year
        AND in_pilot IN (
            c.Primeiro, c.Segundo, c.Terceiro, c.Quarto, c.Quinto,
            c.Sexto, c.Setmo, c.Oitavo, c.Nono, c.`Décimo`
        )
    ) AS sub;
END //
DELIMITER ;
CALL piloto_pontos_ano('Lewis Hamilton', 2022);

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