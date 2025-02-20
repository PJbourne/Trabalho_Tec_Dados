 -- 1 Retorna o total de pontos da equipe selecionada
DELIMITER //
CREATE FUNCTION PontosEquipe(equipe VARCHAR(50)) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(p.Pontos) INTO total
    FROM Equipes e
    JOIN Pilotos p ON (e.Piloto_1 = p.ID_Pilotos OR e.Piloto_2 = p.ID_Pilotos)
    WHERE e.Nome_Equipe = equipe;
    RETURN total;
END //
DELIMITER ;
select PontosEquipe('Ferrari');


-- 2 Retorna o total corridas do campeonato selecionada
DELIMITER //
CREATE FUNCTION CorridasAno(championship_date DATE)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE TotalCorridas INT;
    SELECT COUNT(cr.ID_Corrida)
      INTO TotalCorridas
      FROM Campeonato c
      LEFT JOIN Corridas cr ON c.ID_Campeonato = cr.Championship
     WHERE YEAR(c.Ano) = YEAR(championship_date);

    RETURN TotalCorridas;
END //
DELIMITER ;

select CorridasAno('2021-01-01');

 -- 3 Retorna o total tempo da volta mais rapida do campeonato selecionada
DELIMITER //
CREATE FUNCTION VoltaMaisRapida(data_campeonato DATE)
RETURNS DECIMAL(10,2) DETERMINISTIC

BEGIN
    DECLARE menor_volta DECIMAL(10,2);
    SELECT MIN(c.Volta_rapida)
    INTO menor_volta
    FROM Corridas c
    JOIN Campeonato cam ON c.Championship = cam.ID_Campeonato
    WHERE cam.Ano = data_campeonato;
    RETURN menor_volta;
END //
DELIMITER ;

SELECT VoltaMaisRapida('2021-01-01');

 -- 4 Compara o menor tempo da volta no autodromo especificado com a menor volta no campeonato
DELIMITER //
CREATE FUNCTION VoltaMaisRapidaLoc(localidade VARCHAR(50), data_campeonato DATE)
RETURNS VARCHAR(250) DETERMINISTIC
BEGIN
    DECLARE menor_volta DECIMAL(10,2);
    DECLARE volta DECIMAL(10,2);
    DECLARE info VARCHAR(250);

    -- Calcula a menor volta do campeonato
    SELECT VoltaMaisRapida(data_campeonato) INTO menor_volta;

    -- Calcula a volta na localidade específica
    SELECT c.Volta_rapida
    INTO volta
    FROM Corridas c
    JOIN Campeonato cam ON c.Championship = cam.ID_Campeonato
    WHERE c.autodromo = localidade AND cam.Ano = data_campeonato;

    -- Compara as voltas e gera a mensagem
    IF menor_volta < volta THEN
        SET INFO = CONCAT('A menor volta do campeonato foi ', menor_volta, ', sendo menor que a volta de ', localidade, ', que foi ', volta, '.');
    ELSEIF menor_volta = volta THEN
        SET INFO = CONCAT('A menor volta do campeonato foi igual à volta de ', localidade, ', com o tempo ', menor_volta, '.');
    ELSE
        SET INFO = CONCAT('A menor volta do campeonato foi ', menor_volta, ', sendo maior que a volta de ', localidade, ', que foi ', volta, '.');
    END IF;

    -- Retorna a mensagem
    RETURN INFO;
END //

DELIMITER ;
SELECT VoltaMaisRapidaLoc('Interlagos', '2022-01-01') ;

-- 5 Retorna o carro utilizado pelo piloto
DELIMITER //
CREATE FUNCTION CarroPiloto(piloto_nome VARCHAR(50)) 
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE carro_especificacoes VARCHAR(100);

    -- Busca as especificações do carro utilizado pelo piloto
    SELECT c.Especificacoes INTO carro_especificacoes
    FROM Carros c
    JOIN Equipes e ON c.Especificacoes LIKE CONCAT('%', e.Carro, '%') -- Associação baseada em texto
    JOIN Pilotos p ON (e.Piloto_1 = p.ID_Pilotos OR e.Piloto_2 = p.ID_Pilotos)
    WHERE p.Nome_piloto = piloto_nome;
    RETURN carro_especificacoes;
END //

DELIMITER ;

select CarroPiloto('Max Verstappen');