-- View 1:
CREATE VIEW piloto_inf AS
SELECT 
    p.ID_Pilotos, 
    p.Nome_piloto, 
    p.Pontos, 
    e.Nome_Equipe
FROM Pilotos p
JOIN Equipes e ON (p.ID_Pilotos = e.Piloto_1 OR p.ID_Pilotos = e.Piloto_2);

SELECT * FROM piloto_inf;


-- View 2:
CREATE VIEW corridas_inf AS
SELECT 
    cr.ID_Corrida, 
    cr.Localidade, 
    cr.Autodromo, 
    cr.Tempo, 
    cm.Ano AS ChampionshipYear
FROM Corridas cr
JOIN Campeonato cm ON cr.Championship = cm.ID_Campeonato;

SELECT * FROM corridas_inf;


-- View 3:
CREATE VIEW equipe_inf AS
SELECT 
    e.Nome_Equipe, 
    CONCAT(p1.Nome_piloto, ' & ', p2.Nome_piloto) AS Drivers, 
    car.Especificacoes AS CarDetails
FROM equipes e
JOIN Pilotos p1 ON e.Piloto_1 = p1.ID_Pilotos
JOIN Pilotos p2 ON e.Piloto_2 = p2.ID_Pilotos
JOIN tem t ON e.Nome_Equipe = t.equipe
JOIN Carros car ON t.ID_carro = car.ID_carro;

SELECT * FROM equipe_inf;

