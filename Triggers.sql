-- Adiona pontos aos pilotots apos 1 corrida ser adicionada

DELIMITER //
CREATE TRIGGER AtualizarPontuacaoPilotos
AFTER INSERT ON Corridas
FOR EACH ROW
BEGIN
    DECLARE pontos_primeiro INT DEFAULT 25;
    DECLARE pontos_segundo INT DEFAULT 18;
    DECLARE pontos_terceiro INT DEFAULT 15;
    DECLARE pontos_quarto INT DEFAULT 12;
    DECLARE pontos_quinto INT DEFAULT 10;
    DECLARE pontos_sexto INT DEFAULT 8;
    DECLARE pontos_setimo INT DEFAULT 6;
    DECLARE pontos_oitavo INT DEFAULT 4;
    DECLARE pontos_nono INT DEFAULT 2;
    DECLARE pontos_decimo INT DEFAULT 1;

    -- Atualiza os pontos do 1º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_primeiro
    WHERE Nome_piloto = NEW.Primeiro;

    -- Atualiza os pontos do 2º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_segundo
    WHERE Nome_piloto = NEW.Segundo;

    -- Atualiza os pontos do 3º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_terceiro
    WHERE Nome_piloto = NEW.Terceiro;

    -- Atualiza os pontos do 4º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_quarto
    WHERE Nome_piloto = NEW.Quarto;

    -- Atualiza os pontos do 5º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_quinto
    WHERE Nome_piloto = NEW.Quinto;

    -- Atualiza os pontos do 6º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_sexto
    WHERE Nome_piloto = NEW.Sexto;

    -- Atualiza os pontos do 7º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_setimo
    WHERE Nome_piloto = NEW.Setimo;

    -- Atualiza os pontos do 8º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_oitavo
    WHERE Nome_piloto = NEW.Oitavo;

    -- Atualiza os pontos do 9º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_nono
    WHERE Nome_piloto = NEW.Nono;

    -- Atualiza os pontos do 10º lugar
    UPDATE Pilotos
    SET Pontos = Pontos + pontos_decimo
    WHERE Nome_piloto = NEW.Decimo;
END //

DELIMITER ;
-- SET SQL_SAFE_UPDATES = 0;

select * from corridas;
SELECT Nome_piloto, Pontos FROM Pilotos;
CALL AdicionarCorrida('15','Brasil','Interlagos','1h30m',86.549,'Lewis Hamilton','Max Verstappen','Charles Leclerc','Sergio Perez','Carlos Sainz','Lando Norris','George Russell','Fernando Alonso','Esteban Ocon','Pierre Gasly',1);
SELECT Nome_piloto, Pontos FROM Pilotos;

-- Não deixa a criação de 2 campeonatos com o mesmo ano
DELIMITER //
CREATE TRIGGER ImpossibilitaCampeonatoIgual
BEFORE INSERT ON Campeonato
FOR EACH ROW
BEGIN
    DECLARE existe INT;
    
    -- Verificar se já existe um campeonato no mesmo ano
    SELECT COUNT(*) INTO existe FROM Campeonato WHERE YEAR(Ano) = YEAR(NEW.Ano);
    
    IF existe > 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Já existe um campeonato para este ano!';
    END IF;
END;
//
DELIMITER ;


CALL AdicionarCampeonato(4,'2023-01-01','Campeonato 2024');

SELECT * FROM campeonato;

