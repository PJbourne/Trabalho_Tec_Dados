USE formula_one;

-- DELETE FROM Campeonato WHERE ID_Campeonato = 3;
INSERT INTO Campeonato (ID_Campeonato, Ano, Informacaoes) 
VALUES (3, '2023-01-01', 'Campeonato 2023');
INSERT INTO Campeonato (ID_Campeonato, Ano, Informacaoes) 
VALUES (2, '2022-01-01', 'Campeonato 2022');
INSERT INTO Campeonato (ID_Campeonato, Ano, Informacaoes) 
VALUES (1, '2021-01-01', 'Campeonato 2021');

INSERT INTO Pilotos (ID_Pilotos, Nome_piloto, Equipe, Pontos, Salario) VALUES
(1, 'Max Verstappen', 'Red Bull', 400, 45000000.00),
(2, 'Lewis Hamilton', 'Mercedes', 350, 55000000.00),
(3, 'Charles Leclerc', 'Ferrari', 280, 25000000.00),
(4, 'Lando Norris', 'McLaren', 230, 20000000.00);
INSERT INTO Pilotos (ID_Pilotos, Nome_piloto, Equipe, Pontos, Salario) VALUES
(5, 'Sergio Perez', 'Red Bull', 210, 10000000.00),
(6, 'George Russell', 'Mercedes', 190, 18000000.00),
(7, 'Carlos Sainz', 'Ferrari', 220, 12000000.00),
(8, 'Oscar Piastri', 'McLaren', 150, 5000000.00),
(9, 'Fernando Alonso', 'Aston Martin', 200, 25000000.00),
(10, 'Pierre Gasly', 'Alpine', 120, 8000000.00),
(11, 'Esteban Ocon', 'Alpine', 110, 7000000.00),
(12, 'Valtteri Bottas', 'Alfa Romeo', 90, 6000000.00),
(13, 'Kevin Magnussen', 'Haas', 75, 4000000.00),
(14, 'Yuki Tsunoda', 'AlphaTauri', 80, 3000000.00);
INSERT INTO Pilotos (ID_Pilotos, Nome_piloto, Equipe, Pontos, Salario) VALUES
(15, 'Lance Stroll', 'Aston Martin', 100, 10000000.00),
(16, 'Zhou Guanyu', 'Alfa Romeo', 85, 2000000.00),
(17, 'Nico Hülkenberg', 'Haas', 70, 3500000.00),
(18, 'Daniel Ricciardo', 'AlphaTauri', 60, 2500000.00);
-- INSERT PILOTOS FIM -----------------------------------------------
INSERT INTO Equipes (Nome_Equipe, Piloto_1, Piloto_2, Carro) VALUES
('Red Bull', 1, 5, 'RB19'),
('Mercedes', 2, 6, 'W14'),
('Ferrari', 3, 7, 'SF-23'),
('McLaren', 4, 8, 'MCL60');
INSERT INTO Equipes (Nome_Equipe, Piloto_1, Piloto_2, Carro) VALUES
('Aston Martin', 9, 15, 'AMR23'),
('Alpine', 10, 11, 'A523'),
('Alfa Romeo', 12, 16, 'C43'),
('Haas', 13, 17, 'VF-23'),
('AlphaTauri', 14, 18, 'AT04');
-- INSERT EQUIPES FIM -----------------------------------------------
INSERT INTO Fabricante_de_motores (ID_fabricante_motor, About_we) VALUES
(1, 'Honda'),
(2, 'Mercedes'),
(3, 'Ferrari'),
(4, 'Renault');
INSERT INTO Fabricante_de_motores (ID_fabricante_motor, About_we) VALUES
(5, 'Aston Martin'),
(6, 'Alpine');
-- INSERT FAB_MOTOR FIM -----------------------------------------------
INSERT INTO Motor (ID_motor, Especificacoes, Fabricante, ID_fabricante) VALUES
(101, 'V6 Turbo Hybrid', 'Honda', 1),
(102, 'V6 Turbo Hybrid', 'Mercedes', 2),
(103, 'V6 Turbo Hybrid', 'Ferrari', 3),
(104, 'V6 Turbo Hybrid', 'Renault', 4);
INSERT INTO Motor (ID_motor, Especificacoes, Fabricante, ID_fabricante) VALUES
(105, 'V6 Turbo Hybrid', 'Aston Martin', 5),
(106, 'V6 Turbo Hybrid', 'Alpine', 6);
-- INSERT MOTOR FIM -----------------------------------------------
ALTER TABLE FabricanteDeCarros RENAME COLUMN ID_fabricante_motor TO ID_fabricante_carro;
INSERT INTO FabricanteDeCarros (Nome_fabricante, ID_fabricante_carro, ID_carro) VALUES
('Red Bull Racing', 1, 201),
('Mercedes-AMG', 2, 202),
('Ferrari', 3, 203),
('McLaren', 4, 204);
INSERT INTO FabricanteDeCarros (Nome_fabricante, ID_fabricante_carro, ID_carro) VALUES
('Aston Martin F1', 5, 205),
('Alpine F1', 6, 206),
('Alfa Romeo F1', 7, 207),
('Haas F1', 8, 208),
('AlphaTauri F1', 9, 209);
-- INSERT FAB_CARROS FIM -----------------------------------------------
-- INSERT CARROS INIT -----------------------------------------------
INSERT INTO Carros (ID_carro, Especificacoes, Fabricante, ID_motor) VALUES
(201, 'RB19, aerodinâmica avançada', 1, 101),
(202, 'W14, potência Mercedes', 2, 102),
(203, 'SF-23, motor Ferrari', 3, 103),
(204, 'MCL60, equilíbrio e velocidade', 4, 104);
INSERT INTO Carros (ID_carro, Especificacoes, Fabricante, ID_motor) VALUES
(205, 'AMR23, motor Mercedes', 5, 102),
(206, 'A523, motor Alpine', 6, 106),
(207, 'C43, motor Ferrari', 3, 103),
(208, 'VF-23, motor Ferrari', 3, 103),
(209, 'AT04, motor Honda', 1, 101);
-- INSERT CARROS FIM -----------------------------------------------
-- INSERT CORRIDAS INIT -----------------------------------------------
INSERT INTO Corridas (ID_Corrida, Localidade, Autodromo, Tempo, Volta_rapida, Primeiro, Segundo, Terceiro, Quarto, Quinto, Sexto, Setimo, Oitavo, Nono, Decimo, Championship) VALUES
(1, 'Bahrein', 'Sakhir', '1h32m03.897s', 92.090, 'Lewis Hamilton', 'Max Verstappen', 'Valtteri Bottas', 'Lando Norris', 'Sergio Pérez', 'Charles Leclerc', 'Daniel Ricciardo', 'Carlos Sainz Jr.', 'Yuki Tsunoda', 'Lance Stroll', 1),
(2, 'Itália', 'Imola', '2h02m34.598s', 75.484, 'Max Verstappen', 'Lewis Hamilton', 'Lando Norris', 'Charles Leclerc', 'Carlos Sainz Jr.', 'Daniel Ricciardo', 'Pierre Gasly', 'Lance Stroll', 'Esteban Ocon', 'Fernando Alonso', 1),
(3, 'Portugal', 'Portimão', '1h34m31.421s', 79.865, 'Lewis Hamilton', 'Max Verstappen', 'Valtteri Bottas', 'Sergio Pérez', 'Lando Norris', 'Charles Leclerc', 'Esteban Ocon', 'Fernando Alonso', 'Daniel Ricciardo', 'Pierre Gasly', 1),
(4, 'Espanha', 'Barcelona', '1h33m07.680s', 83.840, 'Lewis Hamilton', 'Max Verstappen', 'Valtteri Bottas', 'Charles Leclerc', 'Sergio Pérez', 'Daniel Ricciardo', 'Carlos Sainz Jr.', 'Lando Norris', 'Esteban Ocon', 'Pierre Gasly', 1),
(5, 'Mônaco', 'Monte Carlo', '1h38m56.820s', 73.798, 'Max Verstappen', 'Carlos Sainz Jr.', 'Lando Norris', 'Sergio Pérez', 'Sebastian Vettel', 'Pierre Gasly', 'Lewis Hamilton', 'Lance Stroll', 'Esteban Ocon', 'Antonio Giovinazzi', 1),
(6, 'Azerbaijão', 'Baku', '2h13m36.410s', 101.240, 'Sergio Pérez', 'Sebastian Vettel', 'Pierre Gasly', 'Charles Leclerc', 'Lando Norris', 'Fernando Alonso', 'Yuki Tsunoda', 'Carlos Sainz Jr.', 'Daniel Ricciardo', 'Kimi Räikkönen', 1),
(7, 'França', 'Le Castellet', '1h27m25.770s', 92.872, 'Max Verstappen', 'Lewis Hamilton', 'Sergio Pérez', 'Valtteri Bottas', 'Lando Norris', 'Daniel Ricciardo', 'Pierre Gasly', 'Fernando Alonso', 'Sebastian Vettel', 'Lance Stroll', 1),
(8, 'Áustria', 'Spielberg', '1h23m54.543s', 64.984, 'Max Verstappen', 'Valtteri Bottas', 'Lando Norris', 'Lewis Hamilton', 'Carlos Sainz Jr.', 'Sergio Pérez', 'Daniel Ricciardo', 'Charles Leclerc', 'Pierre Gasly', 'Fernando Alonso', 1),
(9, 'Grã-Bretanha', 'Silverstone', '1h58m23.284s', 87.097, 'Lewis Hamilton', 'Charles Leclerc', 'Valtteri Bottas', 'Lando Norris', 'Daniel Ricciardo', 'Carlos Sainz Jr.', 'Fernando Alonso', 'Lance Stroll', 'Esteban Ocon', 'Yuki Tsunoda', 1),
(10, 'Hungria', 'Budapeste', '2h04m43.199s', 80.828, 'Esteban Ocon', 'Lewis Hamilton', 'Carlos Sainz Jr.', 'Fernando Alonso', 'Pierre Gasly', 'Yuki Tsunoda', 'Nicholas Latifi', 'George Russell', 'Max Verstappen', 'Kimi Räikkönen', 1),
(11, 'Bélgica', 'Spa-Francorchamps', '3h27m07.000s', 0.000, 'Max Verstappen', 'George Russell', 'Lewis Hamilton', 'Daniel Ricciardo', 'Sebastian Vettel', 'Pierre Gasly', 'Esteban Ocon', 'Charles Leclerc', 'Nicholas Latifi', 'Carlos Sainz Jr.', 1),
(12, 'Países Baixos', 'Zandvoort', '1h30m05.395s', 73.643, 'Max Verstappen', 'Lewis Hamilton', 'Valtteri Bottas', 'Pierre Gasly', 'Charles Leclerc', 'Fernando Alonso', 'Carlos Sainz Jr.', 'Sergio Pérez', 'Esteban Ocon', 'Lando Norris', 1),
(13, 'Itália', 'Monza', '1h21m54.365s', 84.812, 'Daniel Ricciardo', 'Lando Norris', 'Valtteri Bottas', 'Charles Leclerc', 'Sergio Pérez', 'Carlos Sainz Jr.', 'Lance Stroll', 'Fernando Alonso', 'George Russell', 'Esteban Ocon', 1),
(14, 'Rússia', 'Sochi', '1h30m41.001s', 96.702, 'Lewis Hamilton', 'Max Verstappen', 'Carlos Sainz Jr.', 'Daniel Ricciardo', 'Valtteri Bottas', 'Fernando Alonso', 'Lando Norris', 'Kimi Räikkönen', 'Sergio Pérez', 'George Russell', 1);
-- (15, 'Turquia', 'Istanbul Park', '1h31m04.103s', 90.432, 'Valtteri Bottas', 'Max Verstappen', 'Sergio Pérez', 'Charles Leclerc', 'Lewis Hamilton', 'Pierre Gasly', 'Lando Norris', 'Carlos Sainz Jr.', 'Lance Stroll', 'Esteban Ocon', 1);

SELECT * FROM Corridas;
-- INSERT CORRIDAS FIM -----------------------------------------------
INSERT INTO Classificacao (Championship, Primeiro, Segundo, Terceiro, Quarto, Quinto, Sexto, Setimo, Oitavo, Nono, Decimo) VALUES
(1, 'Max Verstappen', 'Lewis Hamilton', 'Charles Leclerc', 'Lando Norris', 'Carlos Sainz', 'George Russell', 'Fernando Alonso', 'Sergio Perez', 'Oscar Piastri', 'Pierre Gasly');
INSERT INTO Classificacao (Championship, Primeiro, Segundo, Terceiro, Quarto, Quinto, Sexto, Setimo, Oitavo, Nono, Decimo) VALUES
(2, 'Max Verstappen', 'Sergio Perez', 'Lewis Hamilton', 'Charles Leclerc', 'Lando Norris', 'Carlos Sainz', 'George Russell', 'Fernando Alonso', 'Oscar Piastri', 'Pierre Gasly');
-- INSERT CLASSIFICACAO FIM -----------------------------------------------
INSERT INTO Participam (Equipe, ID_Corrida) VALUES
('Red Bull', 1),
('Mercedes', 1),
('Ferrari', 1),
('McLaren', 2);
INSERT INTO Participam (Equipe, ID_Corrida) VALUES
('Aston Martin', 3),
('Alpine', 3),
('Red Bull', 4),
('Mercedes', 4),
('Ferrari', 5),
('McLaren', 5),
('Alfa Romeo', 6),
('Haas', 6),
('AlphaTauri', 7),
('Red Bull', 7);
-- INSERT PARTICIPAM FIM -----------------------------------------------
-- PARA PROCEDURES:
UPDATE Corridas SET Quarto = 'Sergio Perez', Quinto = 'George Russell', Sexto = 'Esteban Ocon',
Setimo = 'Pierre Gasly', Oitavo = 'Valtteri Bottas', Nono = 'Kevin Magnussen', Decimo = 'Yuki Tsunoda' 
WHERE ID_Corrida = 1;

UPDATE Corridas SET Quarto = 'Fernando Alonso', Quinto = 'Sergio Perez', Sexto = 'Esteban Ocon',
Setimo = 'Pierre Gasly', Oitavo = 'Kevin Magnussen', Nono = 'Lance Stroll', Decimo = 'Zhou Guanyu'
WHERE ID_Corrida = 2;

UPDATE Corridas SET Quarto = 'Carlos Sainz', Quinto = 'Sergio Perez', Sexto = 'George Russell',
Setimo = 'Oscar Piastri', Oitavo = 'Esteban Ocon', Nono = 'Pierre Gasly', Decimo = 'Valtteri Bottas'
WHERE ID_Corrida = 3;

UPDATE Corridas SET Quarto = 'Oscar Piastri', Quinto = 'Carlos Sainz', Sexto = 'Sergio Perez',
Setimo = 'Pierre Gasly', Oitavo = 'Lance Stroll', Nono = 'Kevin Magnussen', Decimo = 'Yuki Tsunoda'
WHERE ID_Corrida = 4;

UPDATE Corridas SET Quarto = 'Fernando Alonso', Quinto = 'Oscar Piastri', Sexto = 'George Russell',
Setimo = 'Sergio Perez', Oitavo = 'Pierre Gasly', Nono = 'Lance Stroll', Decimo = 'Zhou Guanyu'
WHERE ID_Corrida = 5;

UPDATE Corridas SET Quarto = 'Lance Stroll', Quinto = 'Pierre Gasly', Sexto = 'Yuki Tsunoda',
Setimo = 'Kevin Magnussen', Oitavo = 'Valtteri Bottas', Nono = 'Nico Hülkenberg', Decimo = 'Daniel Ricciardo'
WHERE ID_Corrida = 6;

UPDATE Corridas SET Quarto = 'Carlos Sainz', Quinto = 'Oscar Piastri', Sexto = 'Sergio Perez',
Setimo = 'Pierre Gasly', Oitavo = 'Lance Stroll', Nono = 'Kevin Magnussen', Decimo = 'Daniel Ricciardo'
WHERE ID_Corrida = 7;

INSERT INTO tem (Equipe, ID_carro) VALUES
('Red Bull', 201),
('Mercedes', 202),
('Ferrari', 203),
('McLaren', 204),
('Aston Martin', 205),
('Alpine', 206),
('Alfa Romeo', 207),
('Haas', 208),
('AlphaTauri', 209);